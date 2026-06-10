from PIL import Image, ImageEnhance, ImageOps
import argparse
import glob
import os
import sys


class CoverArgumentParser(argparse.ArgumentParser):
    def error(self, message):
        raise SystemExit(f"Erro: {message}\n")


COV_WIDTH_TILES = 14
COV_HEIGHT_TILES = 18
TILE_SIZE = 8
COV_WIDTH = COV_WIDTH_TILES * TILE_SIZE
COV_HEIGHT = COV_HEIGHT_TILES * TILE_SIZE

RESERVED_PALETTE = [
    (0, 0, 0, 0),
    (1, 255, 255, 255),
]

BAYER_4X4 = (
    (0, 8, 2, 10),
    (12, 4, 14, 6),
    (3, 11, 1, 9),
    (15, 7, 13, 5),
)


def nearest_sms_color(pixel, palette):
    r, g, b = pixel[:3]
    best_index = 0
    best_dist = 1 << 30

    for index, pr, pg, pb in palette:
        dr = r - pr
        dg = g - pg
        db = b - pb
        dist = dr * dr + dg * dg + db * db
        if dist < best_dist:
            best_dist = dist
            best_index = index

    return best_index


def sms_level(value):
    return max(0, min(3, int(round(value / 85))))


def sms_rgb_to_cram(rgb):
    r, g, b = rgb[:3]
    return sms_level(r) | (sms_level(g) << 2) | (sms_level(b) << 4)


def cram_to_rgb(cram):
    return (
        (cram & 0x03) * 85,
        ((cram >> 2) & 0x03) * 85,
        ((cram >> 4) & 0x03) * 85,
    )


def build_palette(image):
    quantized = image.quantize(colors=14, method=Image.Quantize.MEDIANCUT)
    raw_palette = quantized.getpalette()[:14 * 3]
    palette = RESERVED_PALETTE[:]
    used = {0x00, 0x3F}

    for i in range(0, len(raw_palette), 3):
        cram = sms_rgb_to_cram(raw_palette[i:i + 3])
        if cram in used:
            continue
        used.add(cram)
        r, g, b = cram_to_rgb(cram)
        palette.append((len(palette), r, g, b))
        if len(palette) == 16:
            break

    fallback = [0x15, 0x2A, 0x0A, 0x30, 0x03, 0x0F, 0x33, 0x3C, 0x12, 0x24, 0x09, 0x06, 0x18, 0x21]
    for cram in fallback:
        if len(palette) == 16:
            break
        if cram in used:
            continue
        used.add(cram)
        r, g, b = cram_to_rgb(cram)
        palette.append((len(palette), r, g, b))

    return palette


def palette_to_cram(palette):
    cram = [0] * 16
    for index, r, g, b in palette:
        cram[index] = sms_rgb_to_cram((r, g, b))
    return cram


def crop_to_cover(image):
    target_ratio = COV_WIDTH / COV_HEIGHT
    width, height = image.size
    ratio = width / height

    if ratio > target_ratio:
        new_width = int(height * target_ratio)
        left = (width - new_width) // 2
        image = image.crop((left, 0, left + new_width, height))
    elif ratio < target_ratio:
        new_height = int(width / target_ratio)
        top = (height - new_height) // 2
        image = image.crop((0, top, width, top + new_height))

    return image


def resize_to_cover(image):
    return image.resize((COV_WIDTH, COV_HEIGHT), Image.Resampling.LANCZOS)


def preprocess_image(image, contrast, sharpness, brightness, auto_resize):
    if auto_resize:
        image = crop_to_cover(image)
        image = resize_to_cover(image)
    elif image.size != (COV_WIDTH, COV_HEIGHT):
        raise ValueError(
            f"a imagem precisa estar em {COV_WIDTH}x{COV_HEIGHT} quando o redimensionamento automatico estiver desativado"
        )

    image = ImageOps.autocontrast(image, cutoff=1)
    image = ImageEnhance.Brightness(image).enhance(brightness)
    image = ImageEnhance.Contrast(image).enhance(contrast)
    image = ImageEnhance.Sharpness(image).enhance(sharpness)
    return image


def clamp_channel(value):
    return max(0, min(255, int(value)))


def ordered_dither_pixel(pixel, x, y, strength):
    threshold = (BAYER_4X4[y & 3][x & 3] - 7.5) * strength
    return (
        clamp_channel(pixel[0] + threshold),
        clamp_channel(pixel[1] + threshold),
        clamp_channel(pixel[2] + threshold),
    )


def encode_tile(indices, tile_x, tile_y):
    data = bytearray()

    for row in range(TILE_SIZE):
        planes = [0, 0, 0, 0]

        for col in range(TILE_SIZE):
            color = indices[tile_y * TILE_SIZE + row][tile_x * TILE_SIZE + col]
            bit = 7 - col

            if color & 1:
                planes[0] |= 1 << bit
            if color & 2:
                planes[1] |= 1 << bit
            if color & 4:
                planes[2] |= 1 << bit
            if color & 8:
                planes[3] |= 1 << bit

        data.extend(planes)

    return data


def convert_image(src, dst, dither, contrast, sharpness, brightness, auto_resize):
    cov_height = COV_HEIGHT
    if not os.path.isfile(src):
        raise ValueError(f"arquivo nao encontrado: {src}")

    image = Image.open(src).convert("RGB")
    image = preprocess_image(image, contrast, sharpness, brightness, auto_resize)
    palette = build_palette(image)
    pixels = [
        [list(image.getpixel((x, y))) for x in range(COV_WIDTH)]
        for y in range(cov_height)
    ]

    indices = []
    for y in range(cov_height):
        row = []
        for x in range(COV_WIDTH):
            old = pixels[y][x]
            quant_pixel = ordered_dither_pixel(old, x, y, 14) if dither == "ordered" else old
            index = nearest_sms_color(quant_pixel, palette)
            row.append(index)

            if dither == "fs":
                _, nr, ng, nb = next(color for color in palette if color[0] == index)
                error = [old[0] - nr, old[1] - ng, old[2] - nb]
                for dx, dy, weight in ((1, 0, 7), (-1, 1, 3), (0, 1, 5), (1, 1, 1)):
                    nx = x + dx
                    ny = y + dy
                    if nx < 0 or nx >= COV_WIDTH or ny >= cov_height:
                        continue
                    for channel in range(3):
                        value = pixels[ny][nx][channel] + error[channel] * weight / 16
                        pixels[ny][nx][channel] = max(0, min(255, int(value)))

        indices.append(row)

    out = bytearray()
    out.extend(b"COV1")
    out.append(COV_WIDTH_TILES)
    out.append(COV_HEIGHT_TILES)
    out.extend(bytes(10))

    for tile_y in range(COV_HEIGHT_TILES):
        for tile_x in range(COV_WIDTH_TILES):
            out.extend(encode_tile(indices, tile_x, tile_y))

    out.extend(palette_to_cram(palette))

    try:
        with open(dst, "wb") as f:
            f.write(out)
    except OSError as error:
        raise ValueError(f"nao foi possivel gravar {dst}: {error.strerror}")


def pause():
    input("\nPressione ENTER para continuar...")


def fix_png_name(name):
    if os.path.isfile(name):
        return name
    if not name.lower().endswith(".png") and os.path.isfile(name + ".png"):
        return name + ".png"
    return name


def convert_one_interactive(auto_resize):
    input_path = input("\nDigite o nome do PNG: ").strip().strip('"')
    if not input_path:
        return

    input_path = fix_png_name(input_path)
    output = os.path.splitext(input_path)[0] + ".cov"

    try:
        convert_image(input_path, output, "none", 1.35, 2.0, 1.0, auto_resize)
    except ValueError as error:
        print(f"\nErro: {input_path}: {error}")
        pause()
        return

    print(f"\nCriado: {output}")
    pause()


def convert_all_interactive(auto_resize):
    inputs = sorted(glob.glob("*.png"))
    if not inputs:
        print("\nErro: Nao foram encontrados arquivos .png nesta pasta.")
        pause()
        return

    print()
    for input_path in inputs:
        output = os.path.splitext(input_path)[0] + ".cov"
        try:
            convert_image(input_path, output, "none", 1.35, 2.0, 1.0, auto_resize)
        except ValueError as error:
            print(f"Erro: {input_path}: {error}")
            continue
        print(f"Criado: {output}")

    pause()


def show_credits():
    os.system("cls")
    print("==========================================")
    print(" Creditos")
    print("==========================================")
    print()
    print("Desenvolvido por: tavinho.games")
    print("Siga no instagram: @tavinho.games")
    print("Agradecimentos: Canal thalescamara e ludufre")
    pause()


def interactive_menu():
    while True:
        os.system("cls")
        print("==========================================")
        print(" Conversor de capas .PNG para .COV")
        print("==========================================")
        print()
        print("Pasta atual:")
        print(os.getcwd())
        print()
        print("1 - Converter todos os PNGs com resize automatico 112x144")
        print("2 - Converter todos os PNGs sem resize automatico")
        print("3 - Converter um PNG com resize automatico 112x144")
        print("4 - Converter um PNG sem resize automatico")
        print("5 - Creditos")
        print("6 - Sair")
        print()
        choice = input("Escolha uma opcao: ").strip()

        if choice == "1":
            convert_all_interactive(True)
        elif choice == "2":
            print("\nAs imagens precisam estar exatamente em 112x144.")
            convert_all_interactive(False)
        elif choice == "3":
            convert_one_interactive(True)
        elif choice == "4":
            print("\nA imagem precisa estar exatamente em 112x144.")
            convert_one_interactive(False)
        elif choice == "5":
            show_credits()
        elif choice == "6":
            return


def main():
    if len(sys.argv) == 1:
        interactive_menu()
        return

    parser = CoverArgumentParser(description="Convert an image to SMS EverDrive OS .cov cover format.")
    parser.add_argument("input", nargs="*", help="Input image(s), e.g. Sonic.png")
    parser.add_argument("-o", "--output", help="Output .cov file. Only valid with one input. Defaults to input name with .cov")
    parser.add_argument("--all-png", action="store_true", help="Convert all .png files in the current folder.")
    parser.add_argument("--folder", default=".", help="Folder used with --all-png. Defaults to current folder.")
    parser.add_argument("--dither", choices=("ordered", "fs", "none"), default="none", help="Dither mode.")
    parser.add_argument("--contrast", type=float, default=1.35, help="Pre-quantization contrast.")
    parser.add_argument("--sharpness", type=float, default=2.0, help="Pre-quantization sharpness.")
    parser.add_argument("--brightness", type=float, default=1.0, help="Pre-quantization brightness.")
    parser.add_argument("--resize", choices=("auto", "manual"), default="auto", help="auto crops/resizes to 112x144. manual requires the input image to already be 112x144.")
    parser.add_argument("--no-resize", action="store_true", help="Alias for --resize manual.")
    parser.add_argument("--no-dither", action="store_true", help="Alias for --dither none.")
    args = parser.parse_args()

    inputs = args.input
    if args.all_png:
        inputs = sorted(glob.glob(os.path.join(args.folder, "*.png")))
        if not inputs:
            parser.error("Nao foram encontrados arquivos .png")

    if not inputs:
        parser.error("nenhuma imagem foi informada")

    if args.output is not None and len(inputs) != 1:
        parser.error("--output so pode ser usado com uma imagem")

    dither = "none" if args.no_dither else args.dither
    auto_resize = False if args.no_resize else args.resize == "auto"
    for input_path in inputs:
        output = args.output
        if output is None:
            output = os.path.splitext(input_path)[0] + ".cov"

        try:
            convert_image(input_path, output, dither, args.contrast, args.sharpness, args.brightness, auto_resize)
        except ValueError as error:
            parser.error(f"{input_path}: {error}")
        print(f"Criado: {output}")


if __name__ == "__main__":
    main()
