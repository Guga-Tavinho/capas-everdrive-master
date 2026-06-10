;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:43 2026
;--------------------------------------------------------
	.module os_msed
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __osLoadSram
	.globl __osSaveSram
	.globl _osSetRomCfg
	.globl _g_set_vdp_reg
	.globl _osRomMenu
	.globl _osUsbListene2r
	.globl _bi_install_os
	.globl _bi_set_ram_bank
	.globl _bi_set_rom_bank
	.globl _str_copy
	.globl _str_extension_list
	.globl _str_extension
	.globl _str_cmp_len
	.globl _diskInit
	.globl _bi_is_gg_cart
	.globl _bi_usb_wr_byte
	.globl _bi_usb_rd_byte
	.globl _bi_usb_rd_busy
	.globl _bi_usb_to_rom
	.globl _bi_start_game
	.globl _bi_flash_erase
	.globl _bi_get_cpld_ver
	.globl _bi_init
	.globl _guiHexView
	.globl _guiDrawMenu
	.globl _guiPrintError
	.globl _gAppendChar
	.globl _gAppendNum
	.globl _gDrawStringCx
	.globl _gSetXY
	.globl _gDrawString
	.globl _gConsPrint
	.globl _gAppendString
	.globl _gCleanScreen
	.globl _gRepaint
	.globl _gSetFont
	.globl _sysJoyWait
	.globl _gSetSGpal
	.globl _sysInit
	.globl _gSetPal
	.globl _fat_make_dir
	.globl _fat_write_file
	.globl _fat_open_file_by_name
	.globl _fat_make_sync_name
	.globl _fat_read
	.globl _fat_skip_sectors
	.globl _fat_open_file
	.globl _fat_init
	.globl _rom_inf
	.globl _usb_to_rom_code
	.globl _spi_to_rom_code
	.globl _flash_erase_code
	.globl _os_ram
	.globl _ram_ptr
	.globl _bi_card_type
	.globl _joy
	.globl _cart_3e
	.globl _osInit
	.globl _osUsbListener
	.globl _osFileMenu
	.globl _osMallocRam
	.globl _osReleaseRam
	.globl _osMainMenu
	.globl _osExitBrowser
	.globl _osGetDate
	.globl _osGetTime
	.globl _osSysInfo
	.globl _osAbout
	.globl _osStartGame
	.globl _osSelectGame
	.globl _osSaveSram
	.globl _osLoadSram
	.globl _osCLeanGameSram
	.globl _osSaveRamMenu
	.globl _osFileToSram
	.globl _osSramToFile
	.globl _osUpdateMenu
	.globl _osUpdate
	.globl _osSelectGameUsb
	.globl _osUpdateUsb
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_cart_3e::
	.ds 1
_joy::
	.ds 2
_bi_card_type::
	.ds 1
_ram_ptr::
	.ds 2
_os_ram::
	.ds 4096
_flash_erase_code::
	.ds 128
_spi_to_rom_code::
	.ds 128
_usb_to_rom_code::
	.ds 128
_rom_inf::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;os_msed.c:68: u8 osInit() {
;	---------------------------------
; Function osInit
; ---------------------------------
_osInit_start::
_osInit:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;os_msed.c:71: rom_inf = (RomInfo *) 0x8000;
	ld	hl,#_rom_inf + 0
	ld	(hl), #0x00
	ld	hl,#_rom_inf + 1
	ld	(hl), #0x80
;os_msed.c:74: bi_init();
	call	_bi_init
;os_msed.c:75: sysInit();
	call	_sysInit
;os_msed.c:77: ram_ptr = OS_RAM_SIZE;
	ld	hl,#_ram_ptr + 0
	ld	(hl), #0x00
	ld	hl,#_ram_ptr + 1
	ld	(hl), #0x10
;os_msed.c:79: gSetFont((u8 *) 0x8000 - 1024);
	ld	hl,#0x7C00
	push	hl
	call	_gSetFont
	pop	af
;os_msed.c:81: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:82: gDrawStringCx("Sistema iniciando...", 12);
	ld	de,#__str_0
	ld	a,#0x0C
	push	af
	inc	sp
	push	de
	call	_gDrawStringCx
	pop	af
	inc	sp
;os_msed.c:83: gRepaint();
	call	_gRepaint
;os_msed.c:85: bi_set_ram_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:86: if (rom_inf->crc != 0xaa55) {
	ld	de,(_rom_inf)
	ld	l, e
	ld	h, d
	ld	bc, #0x0201
	add	hl, bc
	ld	b,(hl)
	inc	hl
	ld	h,(hl)
	ld	a,b
	sub	a, #0x55
	jr	NZ,00118$
	ld	a,h
	sub	a, #0xAA
	jr	Z,00102$
00118$:
;os_msed.c:88: rom_inf->run_cfg = 0;
	ld	hl,#0x0200
	add	hl,de
	ld	(hl),#0x00
;os_msed.c:89: rom_inf->crc = 0xaa55;
	ld	hl,(_rom_inf)
	ld	bc,#0x0201
	add	hl,bc
	ld	(hl),#0x55
	inc	hl
	ld	(hl),#0xAA
;os_msed.c:90: rom_inf->file_name[0] = 0;
	ld	hl,(_rom_inf)
	ld	(hl),#0x00
;os_msed.c:91: osCLeanGameSram();
	call	_osCLeanGameSram
;os_msed.c:93: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:94: gDrawStringCx("Settings reset to default", 10);
	ld	de,#__str_1
	ld	a,#0x0A
	push	af
	inc	sp
	push	de
	call	_gDrawStringCx
	pop	af
	inc	sp
;os_msed.c:95: gDrawStringCx("Press any key", 12);
	ld	de,#__str_2
	ld	a,#0x0C
	push	af
	inc	sp
	push	de
	call	_gDrawStringCx
	pop	af
	inc	sp
;os_msed.c:96: gRepaint();
	call	_gRepaint
;os_msed.c:97: sysJoyWait();
	call	_sysJoyWait
;os_msed.c:98: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:99: gSetXY(0, 0);
	ld	hl,#0x0000
	push	hl
	call	_gSetXY
	pop	af
00102$:
;os_msed.c:101: bi_set_rom_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
;os_msed.c:103: resp = diskInit();
	call	_diskInit
;os_msed.c:104: if (resp)return resp;
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00104$
	ld	l,-1 (ix)
	jr	00107$
00104$:
;os_msed.c:106: resp = fat_init();
	call	_fat_init
;os_msed.c:107: if (resp)return resp;
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00106$
	ld	l,-1 (ix)
	jr	00107$
00106$:
;os_msed.c:109: return 0;
	ld	l,#0x00
00107$:
	inc	sp
	pop	ix
	ret
_osInit_end::
__str_0:
	.ascii "Sistema iniciando..."
	.db 0x00
__str_1:
	.ascii "Settings reset to default"
	.db 0x00
__str_2:
	.ascii "Press any key"
	.db 0x00
;os_msed.c:112: u8 osUsbListene2r() {
;	---------------------------------
; Function osUsbListene2r
; ---------------------------------
_osUsbListene2r_start::
_osUsbListene2r:
;os_msed.c:113: return 0;
	ld	l,#0x00
	ret
_osUsbListene2r_end::
;os_msed.c:116: void osUsbListener() {
;	---------------------------------
; Function osUsbListener
; ---------------------------------
_osUsbListener_start::
_osUsbListener:
	dec	sp
;os_msed.c:122: if (bi_usb_rd_busy())return;
	call	_bi_usb_rd_busy
	ld	a,l
	or	a, a
	jr	NZ,00111$
;os_msed.c:125: cmd = bi_usb_rd_byte();
	call	_bi_usb_rd_byte
	ld	iy,#0
	add	iy,sp
	ld	0 (iy),l
;os_msed.c:126: if (cmd != (u8) '+')return;
	ld	a,0 (iy)
	sub	a, #0x2B
	jr	NZ,00111$
;os_msed.c:128: cmd = bi_usb_rd_byte();
	call	_bi_usb_rd_byte
	ld	iy,#0
	add	iy,sp
	ld	0 (iy),l
;os_msed.c:130: switch (cmd) {
	ld	a, 0 (iy)
	cp	a,#0x66
	jr	Z,00111$
	cp	a,#0x67
	jr	Z,00106$
	cp	a,#0x6F
	jr	Z,00107$
	cp	a,#0x73
	jr	Z,00111$
	sub	a, #0x74
	jr	NZ,00111$
;os_msed.c:133: bi_usb_wr_byte((u8) 'k');
	ld	a,#0x6B
	push	af
	inc	sp
	call	_bi_usb_wr_byte
	inc	sp
;os_msed.c:134: break;
	jr	00111$
;os_msed.c:135: case 'g':
00106$:
;os_msed.c:136: osSelectGameUsb();
	call	_osSelectGameUsb
;os_msed.c:137: osStartGame();
	call	_osStartGame
;os_msed.c:138: break;
	jr	00111$
;os_msed.c:139: case 'o':
00107$:
;os_msed.c:141: osUpdateUsb();
	call	_osUpdateUsb
;os_msed.c:151: }
00111$:
	inc	sp
	ret
_osUsbListener_end::
;os_msed.c:155: u8 osRomMenu(FatFullRecord *rec) {
;	---------------------------------
; Function osRomMenu
; ---------------------------------
_osRomMenu_start::
_osRomMenu:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;os_msed.c:158: const u8 * rom_menu_str[] = {
	ld	hl,#0x0000
	add	hl,sp
	ld	e,l
	ld	d,h
	ld	(hl),#<(__str_3)
	inc	hl
	ld	(hl),#>(__str_3)
	push	de
	pop	iy
	inc	iy
	inc	iy
	ld	0 (iy),#<(__str_4)
	ld	1 (iy),#>(__str_4)
	ld	iy,#0x0004
	add	iy, de
	ld	0 (iy),#<(__str_5)
	ld	1 (iy),#>(__str_5)
	ld	iy,#0x0006
	add	iy, de
	ld	0 (iy),#<(__str_6)
	ld	1 (iy),#>(__str_6)
	ld	hl,#0x0008
	add	hl,de
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;os_msed.c:162: resp = guiDrawMenu(rom_menu_str, 0);
	push	bc
	ld	hl,#0x0000
	push	hl
	push	de
	call	_guiDrawMenu
	pop	af
	pop	af
	pop	bc
	ld	c,l
;os_msed.c:164: if (resp == 0) {
	ld	a,c
	or	a, a
	jr	NZ,00111$
;os_msed.c:165: resp = osSelectGame(rec);
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_osSelectGame
	pop	af
	pop	bc
	ld	c,l
;os_msed.c:166: if (resp)return resp;
	ld	a,c
	or	a, a
	jr	Z,00102$
	ld	l,c
	jr	00113$
00102$:
;os_msed.c:167: resp = osStartGame();
	push	bc
	call	_osStartGame
	pop	bc
	ld	c,l
;os_msed.c:168: if (resp)return resp;
	ld	a,c
	or	a, a
	jr	Z,00112$
	ld	l,c
	jr	00113$
00111$:
;os_msed.c:169: } else if (resp == 1) {
	ld	a,c
	dec	a
	jr	NZ,00108$
;os_msed.c:170: resp = osSelectGame(rec);
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_osSelectGame
	pop	af
	pop	bc
;os_msed.c:171: return resp;
	jr	00113$
00108$:
;os_msed.c:172: } else if (resp == 2) {
	ld	a,c
	sub	a, #0x02
	jr	NZ,00112$
;os_msed.c:173: resp = guiHexView(rec);
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_guiHexView
	pop	af
	pop	bc
;os_msed.c:174: return resp;
	jr	00113$
00112$:
;os_msed.c:178: return 0;
	ld	l,#0x00
00113$:
	ld	sp,ix
	pop	ix
	ret
_osRomMenu_end::
__str_3:
	.ascii "Menu de arquivos"
	.db 0x00
__str_4:
	.ascii "Carregar e iniciar"
	.db 0x00
__str_5:
	.ascii "Apenas carregar"
	.db 0x00
__str_6:
	.ascii "Visualizacao hexadecimal"
	.db 0x00
;os_msed.c:181: u8 osFileMenu(FatFullRecord *rec) {
;	---------------------------------
; Function osFileMenu
; ---------------------------------
_osFileMenu_start::
_osFileMenu:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-18
	add	hl,sp
	ld	sp,hl
;os_msed.c:184: const u8 * zip_list[] = {"zip", "rar", "7z", "7z ", 0};
	ld	hl,#0x0006
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	(hl),#<(__str_7)
	inc	hl
	ld	(hl),#>(__str_7)
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	de,#__str_8
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	hl,#0x0004
	add	hl,bc
	ld	de,#__str_9
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	hl,#0x0006
	add	hl,bc
	ld	de,#__str_10
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	hl,#0x0008
	add	hl,bc
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;os_msed.c:185: const u8 * zip_menu_str[] = {
	ld	hl,#0x0000
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#<(__str_11)
	inc	hl
	ld	(hl),#>(__str_11)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	inc	hl
	inc	hl
	ld	de,#__str_12
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	a,-2 (ix)
	add	a, #0x04
	ld	l,a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	h,a
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;os_msed.c:190: if (str_extension(".mso", rec->name)) {
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	hl,#__str_13
	push	bc
	push	de
	push	de
	push	hl
	call	_str_extension
	pop	af
	pop	af
	ld	a,l
	pop	de
	pop	bc
	or	a, a
	jr	Z,00111$
;os_msed.c:191: return osUpdateMenu(rec);
	push	de
	call	_osUpdateMenu
	pop	af
	jr	00113$
00111$:
;os_msed.c:192: } else if (str_extension(".txt", rec->name)) {
	ld	hl,#__str_14
	push	bc
	push	de
	push	de
	push	hl
	call	_str_extension
	pop	af
	pop	af
	ld	a,l
	pop	de
	pop	bc
	or	a, a
	jr	Z,00108$
;os_msed.c:193: return guiHexView(rec);
	push	de
	call	_guiHexView
	pop	af
	jr	00113$
00108$:
;os_msed.c:194: } else if (str_extension_list(zip_list, rec->name)) {
	push	de
	push	de
	push	bc
	call	_str_extension_list
	pop	af
	pop	af
	ld	a,l
	pop	de
	or	a, a
	jr	Z,00105$
;os_msed.c:195: guiDrawMenu(zip_menu_str, 0);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	bc,#0x0000
	push	bc
	push	hl
	call	_guiDrawMenu
	pop	af
	pop	af
;os_msed.c:196: return 0;
	ld	l,#0x00
	jr	00113$
00105$:
;os_msed.c:197: } else if (str_extension(".srm", rec->name)) {
	ld	hl,#__str_15
	push	de
	push	de
	push	hl
	call	_str_extension
	pop	af
	pop	af
	ld	a,l
	pop	de
	or	a, a
	jr	Z,00102$
;os_msed.c:198: resp = osSaveRamMenu(rec);
	push	de
	call	_osSaveRamMenu
	pop	af
	jr	00109$
00102$:
;os_msed.c:200: resp = osRomMenu(rec);
	push	de
	call	_osRomMenu
	pop	af
00109$:
;os_msed.c:202: return resp;
00113$:
	ld	sp,ix
	pop	ix
	ret
_osFileMenu_end::
__str_7:
	.ascii "zip"
	.db 0x00
__str_8:
	.ascii "rar"
	.db 0x00
__str_9:
	.ascii "7z"
	.db 0x00
__str_10:
	.ascii "7z "
	.db 0x00
__str_11:
	.ascii "File Menu"
	.db 0x00
__str_12:
	.ascii "ROM file must be unzipped"
	.db 0x00
__str_13:
	.ascii ".mso"
	.db 0x00
__str_14:
	.ascii ".txt"
	.db 0x00
__str_15:
	.ascii ".srm"
	.db 0x00
;os_msed.c:205: void *osMallocRam(u16 size) {
;	---------------------------------
; Function osMallocRam
; ---------------------------------
_osMallocRam_start::
_osMallocRam:
;os_msed.c:207: if (ram_ptr < size) {
	ld	hl,#2
	add	hl,sp
	ld	a,(#_ram_ptr + 0)
	sub	a, (hl)
	ld	a,(#_ram_ptr + 1)
	inc	hl
	sbc	a, (hl)
	jr	NC,00103$
;os_msed.c:208: guiPrintError(ERR_OUT_OF_RAM1);
	ld	a,#0x35
	push	af
	inc	sp
	call	_guiPrintError
	inc	sp
00104$:
;os_msed.c:209: for (;;)osUsbListener();
	call	_osUsbListener
	jr	00104$
00103$:
;os_msed.c:212: ram_ptr -= size;
	ld	hl,#2
	add	hl,sp
	push	de
	ld	iy,#_ram_ptr
	push	iy
	pop	de
	ld	a,(de)
	sub	a, (hl)
	ld	(de),a
	inc	de
	ld	a,(de)
	inc	hl
	sbc	a, (hl)
	ld	(de),a
	pop	de
;os_msed.c:213: return (void *) &os_ram[ram_ptr];
	ld	a,(#_ram_ptr + 0)
	add	a, #<(_os_ram)
	ld	e,a
	ld	a,(#_ram_ptr + 1)
	adc	a, #>(_os_ram)
	ld	d,a
	ex	de,hl
	ret
_osMallocRam_end::
;os_msed.c:216: void osReleaseRam(u16 size) {
;	---------------------------------
; Function osReleaseRam
; ---------------------------------
_osReleaseRam_start::
_osReleaseRam:
;os_msed.c:218: ram_ptr += size;
	ld	hl,#2
	add	hl,sp
	push	de
	ld	iy,#_ram_ptr
	push	iy
	pop	de
	ld	a,(de)
	add	a, (hl)
	ld	(de),a
	inc	de
	ld	a,(de)
	inc	hl
	adc	a, (hl)
	ld	(de),a
	pop	de
;os_msed.c:219: if (ram_ptr > OS_RAM_SIZE) {
	xor	a, a
	ld	iy,#_ram_ptr
	cp	a, 0 (iy)
	ld	a,#0x10
	ld	iy,#_ram_ptr
	sbc	a, 1 (iy)
	ret	NC
;os_msed.c:220: guiPrintError(ERR_OUT_OF_RAM2);
	ld	a,#0x36
	push	af
	inc	sp
	call	_guiPrintError
	inc	sp
00104$:
;os_msed.c:221: for (;;)osUsbListener();
	call	_osUsbListener
	jr	00104$
	ret
_osReleaseRam_end::
;os_msed.c:227: u8 osMainMenu() {
;	---------------------------------
; Function osMainMenu
; ---------------------------------
_osMainMenu_start::
_osMainMenu:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-12
	add	hl,sp
	ld	sp,hl
;os_msed.c:230: const u8 * menu_str[] = {
	ld	hl,#0x0000
	add	hl,sp
	ld	e,l
	ld	d,h
	ld	(hl),#<(__str_16)
	inc	hl
	ld	(hl),#>(__str_16)
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	bc,#__str_17
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	hl,#0x0004
	add	hl,de
	ld	bc,#__str_18
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	hl,#0x0006
	add	hl,de
	ld	bc,#__str_19
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	hl,#0x0008
	add	hl,de
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;os_msed.c:235: selector = 0;
	ld	l,#0x00
	ld	-2 (ix),e
	ld	-1 (ix),d
00110$:
;os_msed.c:237: gCleanScreen();
	push	hl
	call	_gCleanScreen
	pop	hl
;os_msed.c:238: selector = guiDrawMenu(menu_str, selector);
	ld	h,#0x00
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	push	hl
	push	de
	call	_guiDrawMenu
	pop	af
	pop	af
;os_msed.c:239: if (selector == 0)osStartGame();
	ld	a,l
	or	a, a
	jr	NZ,00102$
	push	hl
	call	_osStartGame
	pop	hl
00102$:
;os_msed.c:240: if (selector == 1)osSysInfo();
	ld	a,l
	dec	a
	jr	NZ,00104$
	push	hl
	call	_osSysInfo
	pop	hl
00104$:
;os_msed.c:241: if (selector == 2)osAbout();
	ld	a,l
	sub	a, #0x02
	jr	NZ,00106$
	push	hl
	call	_osAbout
	pop	hl
00106$:
;os_msed.c:242: if (selector == 0xff)break;
	ld	a,l
;os_msed.c:246: return 0;
	inc	a
	jr	NZ,00110$
	ld	l,a
	ld	sp,ix
	pop	ix
	ret
_osMainMenu_end::
__str_16:
	.ascii "Menu principal"
	.db 0x00
__str_17:
	.ascii "Iniciar jogo"
	.db 0x00
__str_18:
	.ascii "Informacoes do dispositivo"
	.db 0x00
__str_19:
	.ascii "Sobre"
	.db 0x00
;os_msed.c:249: u8 osExitBrowser() {
;	---------------------------------
; Function osExitBrowser
; ---------------------------------
_osExitBrowser_start::
_osExitBrowser:
;os_msed.c:250: osMainMenu();
	call	_osMainMenu
;os_msed.c:251: return 0;
	ld	l,#0x00
	ret
_osExitBrowser_end::
;os_msed.c:254: u16 osGetDate() {
;	---------------------------------
; Function osGetDate
; ---------------------------------
_osGetDate_start::
_osGetDate:
;os_msed.c:255: return 0;
	ld	hl,#0x0000
	ret
_osGetDate_end::
;os_msed.c:258: u16 osGetTime() {
;	---------------------------------
; Function osGetTime
; ---------------------------------
_osGetTime_start::
_osGetTime:
;os_msed.c:259: return 0;
	ld	hl,#0x0000
	ret
_osGetTime_end::
;os_msed.c:262: void osSysInfo() {
;	---------------------------------
; Function osSysInfo
; ---------------------------------
_osSysInfo_start::
_osSysInfo:
;os_msed.c:267: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:269: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
;os_msed.c:271: gDrawString("Versao da CPLD: ", x, y);
	ld	de,#__str_20
	ld	hl,#0x0706
	push	hl
	push	de
	call	_gDrawString
	pop	af
	pop	af
;os_msed.c:272: gAppendNum(bi_get_cpld_ver());
	call	_bi_get_cpld_ver
	ld	h,#0x00
	ld	de,#0x0000
	push	de
	push	hl
	call	_gAppendNum
	pop	af
	pop	af
;os_msed.c:275: gDrawString("Versao do SO: ", x, y);
	ld	de,#__str_21
	ld	hl,#0x0906
	push	hl
	push	de
	call	_gDrawString
	pop	af
	pop	af
;os_msed.c:276: gAppendNum(os_ver);
	ld	iy,#_os_ver
	ld	l,0 (iy)
	ld	h,#0x00
	ld	de,#0x0000
	push	de
	push	hl
	call	_gAppendNum
	pop	af
	pop	af
;os_msed.c:279: gDrawString("Max. Diretorios: ", x, y);
	ld	de,#__str_22
	ld	hl,#0x0B06
	push	hl
	push	de
	call	_gDrawString
	pop	af
;os_msed.c:280: gAppendNum(OS_MAX_DIR_SIZE);
	ld	hl, #0x0000
	ex	(sp),hl
	ld	hl,#0x0200
	push	hl
	call	_gAppendNum
	pop	af
	pop	af
;os_msed.c:283: gDrawString("Tipo de Cartucho: ", x, y);
	ld	de,#__str_23
	ld	hl,#0x0D06
	push	hl
	push	de
	call	_gDrawString
	pop	af
	pop	af
;os_msed.c:284: if (bi_is_gg_cart()) {
	call	_bi_is_gg_cart
	ld	a, l
	or	a, a
	jr	Z,00102$
;os_msed.c:285: gAppendString("GG");
	ld	hl,#__str_24
	push	hl
	call	_gAppendString
	pop	af
	jr	00103$
00102$:
;os_msed.c:287: gAppendString("SMS");
	ld	hl,#__str_25
	push	hl
	call	_gAppendString
	pop	af
00103$:
;os_msed.c:291: gDrawString("Dat. Firmware: 09/06/2026", x, y);
	ld	de,#__str_26
	ld	hl,#0x0F06
	push	hl
	push	de
	call	_gDrawString
	pop	af
;os_msed.c:293: bi_set_rom_bank(1);
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
;os_msed.c:295: gRepaint();
	call	_gRepaint
;os_msed.c:296: sysJoyWait();
	jp	_sysJoyWait
_osSysInfo_end::
__str_20:
	.ascii "Versao da CPLD: "
	.db 0x00
__str_21:
	.ascii "Versao do SO: "
	.db 0x00
__str_22:
	.ascii "Max. Diretorios: "
	.db 0x00
__str_23:
	.ascii "Tipo de Cartucho: "
	.db 0x00
__str_24:
	.ascii "GG"
	.db 0x00
__str_25:
	.ascii "SMS"
	.db 0x00
__str_26:
	.ascii "Dat. Firmware: 09/06/2026"
	.db 0x00
;os_msed.c:299: void osAbout() {
;	---------------------------------
; Function osAbout
; ---------------------------------
_osAbout_start::
_osAbout:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;os_msed.c:301: u8 gg_cart = bi_is_gg_cart();
	call	_bi_is_gg_cart
	ld	-1 (ix),l
;os_msed.c:303: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:304: gSetXY(0, 2);
	ld	hl,#0x0200
	push	hl
	call	_gSetXY
;os_msed.c:305: gSetPal(4);
	ld	hl, #0x0004
	ex	(sp),hl
	call	_gSetPal
;os_msed.c:306: gConsPrint("");
	ld	hl, #__str_27
	ex	(sp),hl
	call	_gConsPrint
	pop	af
;os_msed.c:307: if (gg_cart) {
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00102$
;os_msed.c:308: gConsPrint("EverDrive GG ");
	ld	hl,#__str_28
	push	hl
	call	_gConsPrint
;os_msed.c:309: gConsPrint("Developed by:");
	ld	hl, #__str_29
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:310: gSetPal(0);
	ld	hl, #0x0000
	ex	(sp),hl
	call	_gSetPal
;os_msed.c:311: gConsPrint("I. Golubovskiy");
	ld	hl, #__str_30
	ex	(sp),hl
	call	_gConsPrint
	pop	af
	jr	00103$
00102$:
;os_msed.c:313: gConsPrint("Firmware desenvolvida por:");
	ld	hl,#__str_31
	push	hl
	call	_gConsPrint
;os_msed.c:314: gConsPrint("@tavinho.games");
	ld	hl, #__str_32
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:315: gConsPrint("Agradecimentos: thalescamara e ludufre");
	ld	hl, #__str_33
	ex	(sp),hl
	call	_gConsPrint
	pop	af
00103$:
;os_msed.c:319: gSetPal(4);
	ld	hl,#0x0004
	push	hl
	call	_gSetPal
;os_msed.c:320: gConsPrint("");
	ld	hl, #__str_27
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:322: gConsPrint("Suporte:");
	ld	hl, #__str_34
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:323: gSetPal(0);
	ld	hl, #0x0000
	ex	(sp),hl
	call	_gSetPal
;os_msed.c:324: gConsPrint("Instagram:");
	ld	hl, #__str_35
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:325: gConsPrint("tavinho.games");
	ld	hl, #__str_36
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:327: gConsPrint("");
	ld	hl, #__str_27
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:328: gSetPal(4);
	ld	hl, #0x0004
	ex	(sp),hl
	call	_gSetPal
;os_msed.c:329: gConsPrint("Controles:");
	ld	hl, #__str_37
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:330: gSetPal(0);
	ld	hl, #0x0000
	ex	(sp),hl
	call	_gSetPal
	pop	af
;os_msed.c:331: if (gg_cart) {
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00105$
;os_msed.c:332: gConsPrint("Esq/Dir - Alternar pagina");
	ld	hl,#__str_38
	push	hl
	call	_gConsPrint
	pop	af
	jr	00106$
00105$:
;os_msed.c:334: gConsPrint("Esq/Dir - Alternar pagina");
	ld	hl,#__str_38
	push	hl
	call	_gConsPrint
	pop	af
00106$:
;os_msed.c:336: gConsPrint("Bot. 1 - Menu de arquivos");
	ld	hl,#__str_39
	push	hl
	call	_gConsPrint
;os_msed.c:337: gConsPrint("Bot. 2 - Voltar");
	ld	hl, #__str_40
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:338: gConsPrint("Bot. 2 na raiz - Menu principal");
	ld	hl, #__str_41
	ex	(sp),hl
	call	_gConsPrint
	pop	af
;os_msed.c:341: gDrawString("SN:", 2, 23);
	ld	de,#__str_42
	ld	hl,#0x1702
	push	hl
	push	de
	call	_gDrawString
	pop	af
	pop	af
;os_msed.c:343: gRepaint();
	call	_gRepaint
;os_msed.c:345: sysJoyWait();
	call	_sysJoyWait
	inc	sp
	pop	ix
	ret
_osAbout_end::
__str_27:
	.db 0x00
__str_28:
	.ascii "EverDrive GG "
	.db 0x00
__str_29:
	.ascii "Developed by:"
	.db 0x00
__str_30:
	.ascii "I. Golubovskiy"
	.db 0x00
__str_31:
	.ascii "Firmware desenvolvida por:"
	.db 0x00
__str_32:
	.ascii "@tavinho.games"
	.db 0x00
__str_33:
	.ascii "Agradecimentos: thalescamara e ludufre"
	.db 0x00
__str_34:
	.ascii "Suporte:"
	.db 0x00
__str_35:
	.ascii "Instagram:"
	.db 0x00
__str_36:
	.ascii "tavinho.games"
	.db 0x00
__str_37:
	.ascii "Controles:"
	.db 0x00
__str_38:
	.ascii "Esq/Dir - Alternar pagina"
	.db 0x00
__str_39:
	.ascii "Bot. 1 - Menu de arquivos"
	.db 0x00
__str_40:
	.ascii "Bot. 2 - Voltar"
	.db 0x00
__str_41:
	.ascii "Bot. 2 na raiz - Menu principal"
	.db 0x00
__str_42:
	.ascii "SN:"
	.db 0x00
;os_msed.c:359: u8 osStartGame() {
;	---------------------------------
; Function osStartGame
; ---------------------------------
_osStartGame_start::
_osStartGame:
;os_msed.c:362: g_set_vdp_reg(1, 0);
	ld	hl,#0x0001
	push	hl
	call	_g_set_vdp_reg
	pop	af
;os_msed.c:364: if ((rom_inf->run_cfg & CFG_SMS_MODE)) {
	ld	hl,(_rom_inf)
	ld	de, #0x0200
	add	hl, de
	bit	6,(hl)
	jr	Z,00102$
;os_msed.c:365: REG_CFG |= CFG_SMS_MODE;
	ld	a,(#0xFFF8)
	set	6, a
	ld	(#0xFFF8),a
00102$:
;os_msed.c:368: if (bi_is_gg_cart()) {
	call	_bi_is_gg_cart
	ld	a,l
	or	a, a
	jr	Z,00104$
;os_msed.c:369: gSetSGpal();
	call	_gSetSGpal
00104$:
;os_msed.c:374: bi_set_ram_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:375: cfg = CFG_ROM_WE_OFF | rom_inf->run_cfg;
	ld	hl,(_rom_inf)
	ld	de, #0x0200
	add	hl, de
	ld	a,(hl)
	set	5, a
	ld	l,a
;os_msed.c:376: bi_set_rom_bank(1);
	push	hl
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
	pop	hl
;os_msed.c:380: bi_start_game(cfg);
	ld	h,#0x00
	push	hl
	call	_bi_start_game
	pop	af
;os_msed.c:381: return 0;
	ld	l,#0x00
	ret
_osStartGame_end::
;os_msed.c:384: void osSetRomCfg(u8 *name) {
;	---------------------------------
; Function osSetRomCfg
; ---------------------------------
_osSetRomCfg_start::
_osSetRomCfg:
	push	af
	push	af
;os_msed.c:387: volatile u8 codemasters = 1;
	ld	iy,#3
	add	iy,sp
	ld	0 (iy),#0x01
;os_msed.c:392: run_cfg = 0;
	ld	d,#0x00
;os_msed.c:394: *(u8 *) 0xffff = 1;
	ld	hl,#0xFFFF
	ld	(hl),#0x01
;os_msed.c:395: bi_set_rom_bank(1);
	push	de
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
	pop	de
;os_msed.c:396: norm_size = *((u8 *) 0xbfff);
	ld	a,(#0xBFFF)
	ld	iy,#2
	add	iy,sp
	ld	0 (iy),a
;os_msed.c:397: norm_size &= 0xf;
	ld	a,0 (iy)
	and	a, #0x0F
	ld	0 (iy),a
;os_msed.c:401: if (norm_size == 0x0c)norm_size = 2;
	ld	a,0 (iy)
	sub	a, #0x0C
	jr	NZ,00114$
	ld	0 (iy),#0x02
	jr	00115$
00114$:
;os_msed.c:403: if (norm_size == 0x0e)norm_size = 4;
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	sub	a, #0x0E
	jr	NZ,00111$
	ld	0 (iy),#0x04
	jr	00115$
00111$:
;os_msed.c:405: if (norm_size == 0x0f)norm_size = 8;
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	sub	a, #0x0F
	jr	NZ,00108$
	ld	0 (iy),#0x08
	jr	00115$
00108$:
;os_msed.c:407: if (norm_size == 0x00)norm_size = 16;
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	or	a, a
	jr	NZ,00105$
	ld	0 (iy),#0x10
	jr	00115$
00105$:
;os_msed.c:409: if (norm_size == 0x01)norm_size = 32;
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	dec	a
	jr	NZ,00102$
	ld	0 (iy),#0x20
	jr	00115$
00102$:
;os_msed.c:411: norm_size = 64;
	ld	iy,#2
	add	iy,sp
	ld	0 (iy),#0x40
00115$:
;os_msed.c:413: if (norm_size != *((u8 *) 0xbfe0) && norm_size != 2)codemasters = 0;
	ld	hl,#0xBFE0
	ld	e,(hl)
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	sub	a, e
	jr	Z,00117$
	ld	a,0 (iy)
	sub	a, #0x02
	jr	Z,00117$
	ld	iy,#3
	add	iy,sp
	ld	0 (iy),#0x00
00117$:
;os_msed.c:415: if (*rom_ptr++ == 0)codemasters = 0;
	ld	a,(#0xBFE9)
	or	a, a
	jr	NZ,00144$
	ld	iy,#3
	add	iy,sp
	ld	0 (iy),#0x00
;os_msed.c:416: for (i = 0; i < 6; i++) {
00144$:
	ld	c,#0x00
	ld	hl,#0xBFEA
00131$:
;os_msed.c:417: if (*rom_ptr++ != 0)codemasters = 0;
	ld	a,(hl)
	inc	hl
	or	a, a
	jr	Z,00132$
	ld	iy,#3
	add	iy,sp
	ld	0 (iy),#0x00
00132$:
;os_msed.c:416: for (i = 0; i < 6; i++) {
	inc	c
	ld	a,c
	sub	a, #0x06
	jr	C,00131$
;os_msed.c:413: if (norm_size != *((u8 *) 0xbfe0) && norm_size != 2)codemasters = 0;
	ld	hl,#0xBFE0
	ld	l,(hl)
;os_msed.c:420: if (*((u8 *) 0xbfe0) < 8 || *((u8 *) 0xbfe0) > 32)codemasters = 0;
	ld	a,l
	sub	a, #0x08
	jr	C,00124$
	ld	a,#0x20
	sub	a, l
	jr	NC,00125$
00124$:
	ld	iy,#3
	add	iy,sp
	ld	0 (iy),#0x00
00125$:
;os_msed.c:423: if (str_extension(".gg", name) == 0) {
	push	de
	ld	hl, #8
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	hl,#__str_43
	push	hl
	call	_str_extension
	pop	af
	pop	af
	ld	a,l
	pop	de
	or	a, a
	jr	NZ,00128$
;os_msed.c:424: run_cfg |= CFG_SMS_MODE;
	ld	d,#0x40
00128$:
;os_msed.c:428: if (codemasters) {
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z,00130$
;os_msed.c:429: run_cfg |= CFG_CDM_MAP;
	set	3, d
00130$:
;os_msed.c:432: bi_set_ram_bank(1);
	push	de
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
	pop	de
;os_msed.c:433: rom_inf->run_cfg = run_cfg;
	ld	hl,(_rom_inf)
	ld	bc,#0x0200
	add	hl,bc
	ld	(hl),d
;os_msed.c:434: bi_set_rom_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
	pop	af
	pop	af
	ret
_osSetRomCfg_end::
__str_43:
	.ascii ".gg"
	.db 0x00
;os_msed.c:449: u8 osSelectGame(FatFullRecord *rec) {
;	---------------------------------
; Function osSelectGame
; ---------------------------------
_osSelectGame_start::
_osSelectGame:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;os_msed.c:456: if (rec->size > 0x100000)return ERR_ROM_SIZE;
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	de, #0x00E0
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	xor	a, a
	cp	a, e
	sbc	a, d
	ld	a,#0x10
	sbc	a, c
	ld	a,#0x00
	sbc	a, h
	jr	NC,00102$
	ld	l,#0x30
	jp	00123$
00102$:
;os_msed.c:458: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:459: gSetXY(1, 1);
	ld	hl,#0x0101
	push	hl
	call	_gSetXY
;os_msed.c:460: gSetPal(0);
	ld	hl, #0x0000
	ex	(sp),hl
	call	_gSetPal
;os_msed.c:461: gConsPrint("");
	ld	hl, #__str_44
	ex	(sp),hl
	call	_gConsPrint
;os_msed.c:462: gConsPrint("");
	ld	hl, #__str_44
	ex	(sp),hl
	call	_gConsPrint
	pop	af
;os_msed.c:463: if (bi_is_gg_cart()) {
	call	_bi_is_gg_cart
	ld	-7 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00104$
;os_msed.c:464: gConsPrint("!!NAO DESLIGUE!!");
	ld	hl,#__str_45
	push	hl
	call	_gConsPrint
;os_msed.c:465: gSetPal(0);
	ld	hl, #0x0000
	ex	(sp),hl
	call	_gSetPal
;os_msed.c:466: gConsPrint("-------------------");
	ld	hl, #__str_46
	ex	(sp),hl
	call	_gConsPrint
	pop	af
	jr	00105$
00104$:
;os_msed.c:468: gConsPrint("!NAO DESLIGUE O CONSOLE!");
	ld	hl,#__str_47
	push	hl
	call	_gConsPrint
;os_msed.c:469: gSetPal(0);
	ld	hl, #0x0000
	ex	(sp),hl
	call	_gSetPal
;os_msed.c:470: gConsPrint("----------------------------");
	ld	hl, #__str_48
	ex	(sp),hl
	call	_gConsPrint
	pop	af
00105$:
;os_msed.c:472: gRepaint();
	call	_gRepaint
;os_msed.c:476: resp = osSaveSram();
	call	_osSaveSram
;os_msed.c:477: if (resp)return resp;
	ld	-8 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00107$
	ld	l,-8 (ix)
	jp	00123$
00107$:
;os_msed.c:479: resp = fat_open_file(rec, 0);
	ld	hl,#0x0000
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_fat_open_file
	pop	af
	pop	af
;os_msed.c:480: if (resp)return resp;
	ld	-8 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00109$
	ld	l,-8 (ix)
	jp	00123$
00109$:
;os_msed.c:482: if ((file.sec_available & 1) != 0) {
	ld	hl, (#(_file + 0x000c) + 0)
	bit	0, l
	jr	Z,00113$
;os_msed.c:483: resp = fat_skip_sectors(1);
	ld	hl,#0x0001
	push	hl
	call	_fat_skip_sectors
	pop	af
;os_msed.c:484: if (resp)return resp;
	ld	-8 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00113$
	ld	l,-8 (ix)
	jp	00123$
00113$:
;os_msed.c:487: err_len = file.sec_available / 128;
	ld	hl, (#(_file + 0x000c) + 0)
	ld	e, l
	ld	d, h
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;os_msed.c:488: if ((file.sec_available & 127) != 0)err_len++;
	ld	a,l
	and	a, #0x7F
	jr	Z,00115$
	inc	e
00115$:
;os_msed.c:490: gConsPrint("Apagando...");
	ld	hl,#__str_49
	push	de
	push	hl
	call	_gConsPrint
	pop	af
	call	_gRepaint
	pop	de
;os_msed.c:492: bi_flash_erase(0, err_len);
	ld	d,#0x00
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	call	_bi_flash_erase
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;os_msed.c:494: gConsPrint("Escrevendo.");
	ld	hl,#__str_50
	push	hl
	call	_gConsPrint
	pop	af
;os_msed.c:495: gRepaint();
	call	_gRepaint
;os_msed.c:496: addr = 0;
	ld	hl,#0x0000
	ex	(sp), hl
;os_msed.c:497: while (file.sec_available) {
00118$:
	ld	hl, #(_file + 0x000c) + 0
	ld	a,(hl)
	ld	-2 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-1 (ix), a
	or	a,-2 (ix)
	jr	Z,00120$
;os_msed.c:498: slen = file.sec_available > 128 ? 128 : file.sec_available;
	ld	a,#0x80
	cp	a, -2 (ix)
	ld	a,#0x00
	sbc	a, -1 (ix)
	jr	NC,00125$
	ld	-6 (ix),#0x80
	ld	-5 (ix),#0x00
	jr	00126$
00125$:
	ld	a,-2 (ix)
	ld	-6 (ix),a
	ld	a,-1 (ix)
	ld	-5 (ix),a
00126$:
	ld	e,-6 (ix)
;os_msed.c:499: resp = fat_read((u8*) & addr, slen, ROM);
	ld	d,#0x00
	ld	hl,#0x0000
	add	hl,sp
	ld	c, l
	ld	b, h
	xor	a, a
	push	af
	inc	sp
	push	de
	push	bc
	call	_fat_read
	pop	af
	pop	af
	inc	sp
;os_msed.c:500: if (resp)return resp;
	ld	-8 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00117$
	ld	l,-8 (ix)
	jr	00123$
00117$:
;os_msed.c:501: gAppendChar((u8) '.');
	ld	a,#0x2E
	push	af
	inc	sp
	call	_gAppendChar
	inc	sp
;os_msed.c:502: gRepaint();
	call	_gRepaint
	jr	00118$
00120$:
;os_msed.c:505: bi_set_ram_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:506: str_copy(rec->name, rom_inf->file_name);
	ld	hl,(_rom_inf)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_str_copy
	pop	af
;os_msed.c:507: bi_set_rom_bank(1);
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
;os_msed.c:508: resp = osLoadSram();
	call	_osLoadSram
;os_msed.c:509: if (resp)return resp;
	ld	-8 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00122$
	ld	l,-8 (ix)
	jr	00123$
00122$:
;os_msed.c:511: osSetRomCfg(rec->name);
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_osSetRomCfg
	pop	af
;os_msed.c:516: gRepaint();
	call	_gRepaint
;os_msed.c:519: return 0;
	ld	l,#0x00
00123$:
	ld	sp,ix
	pop	ix
	ret
_osSelectGame_end::
__str_44:
	.db 0x00
__str_45:
	.ascii "!!NAO DESLIGUE!!"
	.db 0x00
__str_46:
	.ascii "-------------------"
	.db 0x00
__str_47:
	.ascii "!NAO DESLIGUE O CONSOLE!"
	.db 0x00
__str_48:
	.ascii "----------------------------"
	.db 0x00
__str_49:
	.ascii "Apagando..."
	.db 0x00
__str_50:
	.ascii "Escrevendo."
	.db 0x00
;os_msed.c:522: u8 _osSaveSram(FatFullRecord *rec) {
;	---------------------------------
; Function _osSaveSram
; ---------------------------------
__osSaveSram_start::
__osSaveSram:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;os_msed.c:528: bi_set_ram_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:529: if (rom_inf->file_name[0] == 0)return 0;
	ld	hl,(_rom_inf)
	ld	a, (hl)
	or	a,a
	jr	NZ,00102$
	ld	l,a
	jp	00118$
00102$:
;os_msed.c:531: bi_set_ram_bank(0);
	xor	a, a
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:532: for (i = 0; i < OS_SAVE_FILE_SIZE; i++) {
	ld	bc,#0x0000
	ld	hl,#0x8000
00116$:
;os_msed.c:533: if (*sram_ptr++ != OS_EMPTY_RAM_BYTE)break;
	ld	a,(hl)
	inc	hl
	or	a, a
	jr	NZ,00105$
;os_msed.c:532: for (i = 0; i < OS_SAVE_FILE_SIZE; i++) {
	inc	bc
	ld	a,b
	and	a, #0xC0
	jr	Z,00116$
00105$:
;os_msed.c:537: if (i == OS_SAVE_FILE_SIZE)return 0;
	ld	a,c
	or	a, a
	jr	NZ,00107$
	ld	a,b
	sub	a,#0x40
	jr	NZ,00107$
	ld	l,a
	jp	00118$
00107$:
;os_msed.c:539: gConsPrint("Salvando dados da RAM...");
	ld	hl,#__str_51
	push	hl
	call	_gConsPrint
	pop	af
;os_msed.c:540: gRepaint();
	call	_gRepaint
;os_msed.c:542: bi_set_ram_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:529: if (rom_inf->file_name[0] == 0)return 0;
	ld	de,(_rom_inf)
;os_msed.c:543: fat_make_sync_name(SAVE_DIR, rom_inf->file_name, "srm", rom_inf->sync_name);
	ld	hl,#0x0100
	add	hl,de
	ld	c,l
	ld	b,h
	ld	hl,#__str_52
	push	bc
	ld	bc,#__str_53
	push	bc
	push	de
	push	hl
	call	_fat_make_sync_name
	ld	hl,#0x0008
	add	hl,sp
	ld	sp,hl
;os_msed.c:546: resp = fat_open_file_by_name(rom_inf->sync_name, rec, OS_SAVE_FILE_SIZE / 512);
	ld	hl,(_rom_inf)
	ld	bc,#0x0100
	add	hl,bc
	ld	bc,#0x0020
	push	bc
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	push	hl
	call	_fat_open_file_by_name
	pop	af
	pop	af
	pop	af
	ld	-2 (ix),l
	ld	-1 (ix),#0x00
;os_msed.c:548: if (resp == FAT_ERR_PATH_NOT_EXIST) {
	ld	a,-2 (ix)
	sub	a, #0xFA
	jr	NZ,00111$
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00111$
;os_msed.c:549: resp = fat_make_dir(rec, SAVE_DIR);
	ld	hl,#__str_52
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_make_dir
	pop	af
	pop	af
	ld	-2 (ix),l
;os_msed.c:550: if (resp)return resp;
	ld	-1 (ix), #0x00
	ld	a, #0x00
	or	a,-2 (ix)
	jr	Z,00109$
	ld	l,-2 (ix)
	jr	00118$
00109$:
;os_msed.c:551: resp = fat_open_file_by_name(rom_inf->sync_name, rec, OS_SAVE_FILE_SIZE / 512);
	ld	hl,(_rom_inf)
	ld	bc,#0x0100
	add	hl,bc
	ld	bc,#0x0020
	push	bc
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	push	hl
	call	_fat_open_file_by_name
	pop	af
	pop	af
	pop	af
	ld	-2 (ix),l
	ld	-1 (ix),#0x00
00111$:
;os_msed.c:553: if (resp)return resp;
	ld	a,-1 (ix)
	or	a,-2 (ix)
	jr	Z,00113$
	ld	l,-2 (ix)
	jr	00118$
00113$:
;os_msed.c:556: bi_set_ram_bank(0);
	xor	a, a
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:557: resp = fat_write_file(sram_ptr, OS_SAVE_FILE_SIZE / 512);
	ld	hl,#0x0020
	push	hl
	ld	hl,#0x8000
	push	hl
	call	_fat_write_file
	pop	af
	pop	af
	ld	-2 (ix),l
;os_msed.c:558: if (resp)return resp;
	ld	-1 (ix), #0x00
	ld	a, #0x00
	or	a,-2 (ix)
	jr	Z,00115$
	ld	l,-2 (ix)
	jr	00118$
00115$:
;os_msed.c:561: return 0;
	ld	l,#0x00
00118$:
	ld	sp,ix
	pop	ix
	ret
__osSaveSram_end::
__str_51:
	.ascii "Salvando dados da RAM..."
	.db 0x00
__str_52:
	.ascii "/SAVE"
	.db 0x00
__str_53:
	.ascii "srm"
	.db 0x00
;os_msed.c:564: u8 osSaveSram() {
;	---------------------------------
; Function osSaveSram
; ---------------------------------
_osSaveSram_start::
_osSaveSram:
;os_msed.c:567: FatFullRecord *rec = (FatFullRecord *) osMallocRam(sizeof (FatFullRecord));
	ld	hl,#0x00E5
	push	hl
	call	_osMallocRam
;os_msed.c:568: resp = _osSaveSram(rec);
	ex	(sp),hl
	call	__osSaveSram
;os_msed.c:569: osReleaseRam(sizeof (FatFullRecord));
	ex	(sp),hl
	ld	bc,#0x00E5
	push	bc
	call	_osReleaseRam
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
	pop	hl
;os_msed.c:572: return resp;
	ret
_osSaveSram_end::
;os_msed.c:575: u8 _osLoadSram(FatFullRecord *rec) {
;	---------------------------------
; Function _osLoadSram
; ---------------------------------
__osLoadSram_start::
__osLoadSram:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;os_msed.c:580: osCLeanGameSram();
	push	bc
	call	_osCLeanGameSram
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
	pop	bc
;os_msed.c:584: fat_make_sync_name(SAVE_DIR, rom_inf->file_name, "srm", rom_inf->sync_name);
	ld	de,(_rom_inf)
	ld	iy,#0x0100
	add	iy, de
	push	bc
	push	iy
	ld	hl,#__str_55
	push	hl
	push	de
	ld	hl,#__str_54
	push	hl
	call	_fat_make_sync_name
	ld	hl,#0x0008
	add	hl,sp
	ld	sp,hl
	pop	bc
;os_msed.c:587: resp = fat_open_file_by_name(rom_inf->sync_name, rec, 0);
	ld	hl,(_rom_inf)
	ld	de,#0x0100
	add	hl,de
	push	bc
	ld	de,#0x0000
	push	de
	ld	e,4 (ix)
	ld	d,5 (ix)
	push	de
	push	hl
	call	_fat_open_file_by_name
	pop	af
	pop	af
	pop	af
	pop	bc
	ld	c,l
	ld	b,#0x00
;os_msed.c:588: if (resp == FAT_ERR_NOT_EXIST)return 0;
	ld	a,c
	sub	a,#0xF0
	jr	NZ,00102$
	or	a,b
	jr	NZ,00102$
	ld	l,a
	jr	00109$
00102$:
;os_msed.c:589: if (resp)return resp;
	ld	a,b
	or	a,c
	jr	Z,00104$
	ld	l,c
	jr	00109$
00104$:
;os_msed.c:591: gConsPrint("Load save RAM...");
	ld	hl,#__str_56
	push	bc
	push	hl
	call	_gConsPrint
	pop	af
	call	_gRepaint
	pop	bc
;os_msed.c:594: size = OS_SAVE_FILE_SIZE / 512;
	ld	-4 (ix),#0x20
	xor	a, a
	ld	-3 (ix),a
	ld	-2 (ix),a
	ld	-1 (ix),a
;os_msed.c:595: if (size > file.sec_available)size = file.sec_available;
	ld	hl, (#_file + 12)
	ld	de,#0x0000
	ld	a,l
	sub	a, #0x20
	ld	a,h
	sbc	a, #0x00
	ld	a,d
	sbc	a, #0x00
	ld	a,e
	sbc	a, #0x00
	jr	NC,00106$
	ld	-4 (ix),l
	ld	-3 (ix),h
	ld	-2 (ix),d
	ld	-1 (ix),e
00106$:
;os_msed.c:597: bi_set_ram_bank(0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
	pop	bc
;os_msed.c:598: resp = fat_read((void *) 0x8000, size, RAM);
	pop	de
	push	de
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	push	de
	ld	hl,#0x8000
	push	hl
	call	_fat_read
	pop	af
	pop	af
	inc	sp
	pop	bc
	ld	c,l
;os_msed.c:599: if (resp)return resp;
	ld	a, #0x00
	or	a,c
	jr	Z,00108$
	ld	l,c
	jr	00109$
00108$:
;os_msed.c:601: return 0;
	ld	l,#0x00
00109$:
	ld	sp,ix
	pop	ix
	ret
__osLoadSram_end::
__str_54:
	.ascii "/SAVE"
	.db 0x00
__str_55:
	.ascii "srm"
	.db 0x00
__str_56:
	.ascii "Load save RAM..."
	.db 0x00
;os_msed.c:604: u8 osLoadSram() {
;	---------------------------------
; Function osLoadSram
; ---------------------------------
_osLoadSram_start::
_osLoadSram:
;os_msed.c:607: FatFullRecord *rec = (FatFullRecord *) osMallocRam(sizeof (FatFullRecord));
	ld	hl,#0x00E5
	push	hl
	call	_osMallocRam
;os_msed.c:608: resp = _osLoadSram(rec);
	ex	(sp),hl
	call	__osLoadSram
;os_msed.c:609: osReleaseRam(sizeof (FatFullRecord));
	ex	(sp),hl
	ld	bc,#0x00E5
	push	bc
	call	_osReleaseRam
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
	pop	hl
;os_msed.c:611: return resp;
	ret
_osLoadSram_end::
;os_msed.c:614: void osCLeanGameSram() {
;	---------------------------------
; Function osCLeanGameSram
; ---------------------------------
_osCLeanGameSram_start::
_osCLeanGameSram:
;os_msed.c:619: bi_set_ram_bank(0);
	xor	a, a
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:620: for (i = 0; i < OS_SAVE_FILE_SIZE; i++)*sram_ptr++ = OS_EMPTY_RAM_BYTE;
	ld	de,#0x8000
	ld	bc,#0x4000
00104$:
	xor	a, a
	ld	(de),a
	inc	de
	dec	bc
	ld	a,b
	or	a,c
	jr	NZ,00104$
;os_msed.c:621: bi_set_rom_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
	ret
_osCLeanGameSram_end::
;os_msed.c:624: u8 osSaveRamMenu(FatFullRecord *rec) {
;	---------------------------------
; Function osSaveRamMenu
; ---------------------------------
_osSaveRamMenu_start::
_osSaveRamMenu:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-12
	add	hl,sp
	ld	sp,hl
;os_msed.c:627: const u8 * sram_menu_str[] = {
	ld	hl,#0x0000
	add	hl,sp
	ld	e,l
	ld	d,h
	ld	(hl),#<(__str_57)
	inc	hl
	ld	(hl),#>(__str_57)
	push	de
	pop	iy
	inc	iy
	inc	iy
	ld	0 (iy),#<(__str_58)
	ld	1 (iy),#>(__str_58)
	ld	iy,#0x0004
	add	iy, de
	ld	0 (iy),#<(__str_59)
	ld	1 (iy),#>(__str_59)
	ld	iy,#0x0006
	add	iy, de
	ld	0 (iy),#<(__str_60)
	ld	1 (iy),#>(__str_60)
	ld	iy,#0x0008
	add	iy, de
	ld	0 (iy),#<(__str_61)
	ld	1 (iy),#>(__str_61)
	ld	hl,#0x000A
	add	hl,de
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;os_msed.c:630: resp = guiDrawMenu(sram_menu_str, 0);
	push	bc
	ld	hl,#0x0000
	push	hl
	push	de
	call	_guiDrawMenu
	pop	af
	pop	af
	pop	bc
	ld	c,l
;os_msed.c:632: if (resp == 0) {
	ld	a,c
;os_msed.c:633: return 0;
	or	a,a
	jr	NZ,00110$
	ld	l,a
	jr	00112$
00110$:
;os_msed.c:634: } else if (resp == 1) {
	ld	a,c
	dec	a
	jr	NZ,00107$
;os_msed.c:635: resp = osFileToSram(rec);
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_osFileToSram
	pop	af
	pop	bc
;os_msed.c:636: return resp;
	jr	00112$
00107$:
;os_msed.c:637: } else if (resp == 2) {
	ld	a,c
	sub	a, #0x02
	jr	NZ,00104$
;os_msed.c:638: resp = osSramToFile(rec);
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_osSramToFile
	pop	af
	pop	bc
;os_msed.c:639: return resp;
	jr	00112$
00104$:
;os_msed.c:640: } else if (resp == 3) {
	ld	a,c
	sub	a, #0x03
	jr	NZ,00108$
;os_msed.c:641: resp = guiHexView(rec);
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_guiHexView
	pop	af
	pop	bc
;os_msed.c:642: return resp;
	jr	00112$
00108$:
;os_msed.c:644: return 0;
	ld	l,#0x00
00112$:
	ld	sp,ix
	pop	ix
	ret
_osSaveRamMenu_end::
__str_57:
	.ascii "File Menu"
	.db 0x00
__str_58:
	.ascii "Cancel"
	.db 0x00
__str_59:
	.ascii "Copy File To SRAM"
	.db 0x00
__str_60:
	.ascii "Copy SRAM To File"
	.db 0x00
__str_61:
	.ascii "Hex View"
	.db 0x00
;os_msed.c:647: u8 osFileToSram(FatFullRecord *rec) {
;	---------------------------------
; Function osFileToSram
; ---------------------------------
_osFileToSram_start::
_osFileToSram:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;os_msed.c:652: resp = fat_open_file(rec, 0);
	push	bc
	ld	hl,#0x0000
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_open_file
	pop	af
	pop	af
	pop	bc
	ld	c,l
	ld	b,#0x00
;os_msed.c:653: if (resp)return resp;
	ld	a,b
	or	a,c
	jr	Z,00102$
	ld	l,c
	jp	00109$
00102$:
;os_msed.c:655: len = rec->size / 512;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	de, #0x00E0
	add	hl, de
	ld	a,(hl)
	ld	-4 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-3 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-2 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-1 (ix),a
	push	af
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	ld	h,-2 (ix)
	ld	l,-1 (ix)
	pop	af
	ld	a,#0x09
00123$:
	srl	l
	rr	h
	rr	d
	rr	e
	dec	a
	jr	NZ,00123$
;os_msed.c:656: if (rec->size % 512 != 0)len++;
	ld	a,-4 (ix)
	or	a, a
	jr	NZ,00125$
	bit	0, -3 (ix)
	jr	Z,00104$
00125$:
	inc	de
00104$:
;os_msed.c:657: if (len > OS_SAVE_FILE_SIZE / 512)len = OS_SAVE_FILE_SIZE / 512;
	ld	a,#0x20
	cp	a, e
	ld	a,#0x00
	sbc	a, d
	jr	NC,00106$
	ld	de,#0x0020
00106$:
;os_msed.c:659: bi_set_ram_bank(0);
	push	bc
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
	pop	de
	ld	a,#0x01
	push	af
	inc	sp
	push	de
	ld	hl,#0x8000
	push	hl
	call	_fat_read
	pop	af
	pop	af
	inc	sp
	pop	bc
	ld	c,l
	ld	b,#0x00
;os_msed.c:661: bi_set_rom_bank(1);
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
	pop	bc
;os_msed.c:662: if (resp)return resp;
	ld	a,b
	or	a,c
	jr	Z,00108$
	ld	l,c
	jr	00109$
00108$:
;os_msed.c:664: return 0;
	ld	l,#0x00
00109$:
	ld	sp,ix
	pop	ix
	ret
_osFileToSram_end::
;os_msed.c:667: u8 osSramToFile(FatFullRecord *rec) {
;	---------------------------------
; Function osSramToFile
; ---------------------------------
_osSramToFile_start::
_osSramToFile:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;os_msed.c:673: if (rec->size < OS_SAVE_FILE_SIZE) {
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	l, e
	ld	h, d
	ld	bc, #0x00E0
	add	hl, bc
	ld	a,(hl)
	ld	-4 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-3 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-2 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-1 (ix),a
	ld	a,-3 (ix)
	and	a, #0xC0
	jr	NZ,00104$
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00104$
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00104$
;os_msed.c:674: len = rec->size / 512;
	push	af
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	ld	h,-2 (ix)
	ld	l,-1 (ix)
	pop	af
	ld	a,#0x09
00126$:
	srl	l
	rr	h
	rr	b
	rr	c
	dec	a
	jr	NZ,00126$
;os_msed.c:675: if (rec->size % 512 != 0)len++;
	ld	a,-4 (ix)
	or	a, a
	jr	NZ,00128$
	bit	0, -3 (ix)
	jr	Z,00105$
00128$:
	inc	bc
	jr	00105$
00104$:
;os_msed.c:677: len = OS_SAVE_FILE_SIZE / 512;
	ld	bc,#0x0020
00105$:
;os_msed.c:680: resp = fat_open_file(rec, len);
	push	bc
	push	bc
	push	de
	call	_fat_open_file
	pop	af
	pop	af
	pop	bc
	ld	-6 (ix),l
;os_msed.c:681: if (resp)return resp;
	ld	-5 (ix), #0x00
	ld	a, #0x00
	or	a,-6 (ix)
	jr	Z,00107$
	ld	l,-6 (ix)
	jr	00110$
00107$:
;os_msed.c:683: bi_set_ram_bank(0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
	ld	hl,#0x8000
	push	hl
	call	_fat_write_file
	pop	af
	pop	af
	ld	-6 (ix),l
	ld	-5 (ix),#0x00
;os_msed.c:685: bi_set_rom_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
;os_msed.c:686: if (resp)return resp;
	ld	a,-5 (ix)
	or	a,-6 (ix)
	jr	Z,00109$
	ld	l,-6 (ix)
	jr	00110$
00109$:
;os_msed.c:688: return 0;
	ld	l,#0x00
00110$:
	ld	sp,ix
	pop	ix
	ret
_osSramToFile_end::
;os_msed.c:691: u8 osUpdateMenu(FatFullRecord *rec) {
;	---------------------------------
; Function osUpdateMenu
; ---------------------------------
_osUpdateMenu_start::
_osUpdateMenu:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;os_msed.c:694: const u8 * menu_str[] = {
	ld	hl,#0x0000
	add	hl,sp
	ld	e,l
	ld	d,h
	ld	(hl),#<(__str_62)
	inc	hl
	ld	(hl),#>(__str_62)
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	bc,#__str_63
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	hl,#0x0004
	add	hl,de
	ld	bc,#__str_64
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	hl,#0x0006
	add	hl,de
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;os_msed.c:697: resp = guiDrawMenu(menu_str, 0);
	ld	hl,#0x0000
	push	hl
	push	de
	call	_guiDrawMenu
	pop	af
	pop	af
;os_msed.c:699: if (resp == 1)return osUpdate(rec);
	dec	l
	jr	NZ,00102$
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_osUpdate
	pop	af
	jr	00103$
00102$:
;os_msed.c:701: return 0;
	ld	l,#0x00
00103$:
	ld	sp,ix
	pop	ix
	ret
_osUpdateMenu_end::
__str_62:
	.ascii "Menu de arquivos"
	.db 0x00
__str_63:
	.ascii "Cancelar"
	.db 0x00
__str_64:
	.ascii "Atualizar firmware"
	.db 0x00
;os_msed.c:704: u8 osUpdate(FatFullRecord *rec) {
;	---------------------------------
; Function osUpdate
; ---------------------------------
_osUpdate_start::
_osUpdate:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;os_msed.c:711: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:712: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
;os_msed.c:713: gDrawStringCx("!NAO DESLIGUE O CONSOLE!", 11);
	ld	de,#__str_65
	ld	a,#0x0B
	push	af
	inc	sp
	push	de
	call	_gDrawStringCx
	pop	af
	inc	sp
;os_msed.c:714: gRepaint();
	call	_gRepaint
;os_msed.c:716: if (rec->size != 0x8000)return ERR_OS_SIZE;
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	l, c
	ld	h, b
	ld	de, #0x00E0
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	l,(hl)
	ld	h,a
	ld	a,e
	or	a, a
	jr	NZ,00133$
	ld	a,d
	sub	a,#0x80
	jr	NZ,00133$
	or	a,l
	jr	NZ,00133$
	or	a,h
	jr	Z,00102$
00133$:
	ld	l,#0x37
	jp	00113$
00102$:
;os_msed.c:718: resp = fat_open_file(rec, 0);
	push	bc
	ld	hl,#0x0000
	push	hl
	push	bc
	call	_fat_open_file
	pop	af
	pop	af
	pop	bc
;os_msed.c:719: if (resp)return resp;
	ld	-3 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00104$
	ld	l,-3 (ix)
	jp	00113$
00104$:
;os_msed.c:721: buff = osMallocRam(512);
	push	bc
	ld	hl,#0x0200
	push	hl
	call	_osMallocRam
	pop	af
	pop	bc
	ex	de,hl
;os_msed.c:722: resp = fat_read(buff, 1, RAM);
	push	bc
	push	de
	ld	a,#0x01
	push	af
	inc	sp
	ld	hl,#0x0001
	push	hl
	push	de
	call	_fat_read
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	-3 (ix),l
;os_msed.c:723: edos = str_cmp_len(&buff[0x80], "EDOS", 4);
	ld	hl,#0x0080
	add	hl,de
	ex	de,hl
	push	bc
	ld	a,#0x04
	push	af
	inc	sp
	ld	hl,#__str_66
	push	hl
	push	de
	call	_str_cmp_len
	pop	af
	pop	af
	inc	sp
	pop	bc
;os_msed.c:724: osReleaseRam(512);
	push	hl
	push	bc
	ld	de,#0x0200
	push	de
	call	_osReleaseRam
	pop	af
	pop	bc
	pop	hl
;os_msed.c:725: if (resp)return resp;
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00106$
	ld	l,-3 (ix)
	jr	00113$
00106$:
;os_msed.c:726: if (!edos)return ERR_OS_FILE;
	ld	a,l
	or	a, a
	jr	NZ,00108$
	ld	l,#0x38
	jr	00113$
00108$:
;os_msed.c:728: resp = fat_open_file(rec, 0);
	ld	hl,#0x0000
	push	hl
	push	bc
	call	_fat_open_file
	pop	af
	pop	af
;os_msed.c:729: if (resp)return resp;
	ld	-3 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00110$
	ld	l,-3 (ix)
	jr	00113$
00110$:
;os_msed.c:731: bi_flash_erase(0x10000, 1);
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x0000
	push	hl
	call	_bi_flash_erase
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;os_msed.c:733: addr = 128;
	ld	-2 (ix),#0x80
	ld	-1 (ix),#0x00
;os_msed.c:734: resp = fat_read((u8*) & addr, 64, ROM);
	ld	hl,#0x0001
	add	hl,sp
	ex	de,hl
	xor	a, a
	push	af
	inc	sp
	ld	hl,#0x0040
	push	hl
	push	de
	call	_fat_read
	pop	af
	pop	af
	inc	sp
;os_msed.c:735: if (resp)return resp;
	ld	-3 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00112$
	ld	l,-3 (ix)
	jr	00113$
00112$:
;os_msed.c:737: bi_install_os();
	call	_bi_install_os
;os_msed.c:740: return 0;
	ld	l,#0x00
00113$:
	ld	sp,ix
	pop	ix
	ret
_osUpdate_end::
__str_65:
	.ascii "!NAO DESLIGUE O CONSOLE!"
	.db 0x00
__str_66:
	.ascii "EDOS"
	.db 0x00
;os_msed.c:743: void osSelectGameUsb() {
;	---------------------------------
; Function osSelectGameUsb
; ---------------------------------
_osSelectGameUsb_start::
_osSelectGameUsb:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;os_msed.c:748: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
;os_msed.c:749: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:750: gSetXY(0, 2);
	ld	hl,#0x0200
	push	hl
	call	_gSetXY
;os_msed.c:751: gConsPrint("USB loading...");
	ld	hl, #__str_67
	ex	(sp),hl
	call	_gConsPrint
	pop	af
;os_msed.c:752: gRepaint();
	call	_gRepaint
;os_msed.c:753: wr_len = bi_usb_rd_byte();
	call	_bi_usb_rd_byte
	ld	-2 (ix),l
;os_msed.c:754: if (wr_len > 16 || wr_len == 0)return;
	ld	a,#0x10
	sub	a, -2 (ix)
	jp	C,00107$
	ld	a,-2 (ix)
	or	a, a
	jp	Z,00107$
;os_msed.c:759: gConsPrint("Flash Erase...");
	ld	hl,#__str_68
	push	hl
	call	_gConsPrint
	pop	af
;os_msed.c:760: gRepaint();
	call	_gRepaint
;os_msed.c:762: bi_flash_erase(0, wr_len);
	ld	l,-2 (ix)
	ld	h,#0x00
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	call	_bi_flash_erase
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;os_msed.c:763: bi_usb_wr_byte((u8) 'k');
	ld	a,#0x6B
	push	af
	inc	sp
	call	_bi_usb_wr_byte
	inc	sp
;os_msed.c:765: gConsPrint("Copy ROM.");
	ld	hl,#__str_69
	push	hl
	call	_gConsPrint
	pop	af
;os_msed.c:766: gRepaint();
	call	_gRepaint
;os_msed.c:768: addr = 0;
	ld	hl,#0x0000
	ex	(sp), hl
;os_msed.c:769: while (wr_len) {
	ld	a,-2 (ix)
	ld	-1 (ix),a
00104$:
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00106$
;os_msed.c:771: bi_usb_to_rom(&addr, 64);
	ld	hl,#0x0000
	add	hl,sp
	ld	bc,#0x0040
	push	bc
	push	hl
	call	_bi_usb_to_rom
	pop	af
;os_msed.c:772: bi_usb_wr_byte((u8) 'k');
	ld	h,#0x6B
	ex	(sp),hl
	inc	sp
	call	_bi_usb_wr_byte
	inc	sp
;os_msed.c:773: addr += 64;
	ld	a,-4 (ix)
	add	a, #0x40
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
;os_msed.c:774: bi_usb_to_rom(&addr, 64);
	ld	hl,#0x0000
	add	hl,sp
	ld	bc,#0x0040
	push	bc
	push	hl
	call	_bi_usb_to_rom
	pop	af
;os_msed.c:775: bi_usb_wr_byte((u8) 'k');
	ld	h,#0x6B
	ex	(sp),hl
	inc	sp
	call	_bi_usb_wr_byte
	inc	sp
;os_msed.c:776: addr += 64;
	ld	a,-4 (ix)
	add	a, #0x40
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
;os_msed.c:778: wr_len--;
	dec	-1 (ix)
;os_msed.c:779: gAppendChar((u8) '.');
	ld	a,#0x2E
	push	af
	inc	sp
	call	_gAppendChar
	inc	sp
;os_msed.c:780: gRepaint();
	call	_gRepaint
	jr	00104$
00106$:
;os_msed.c:783: bi_set_ram_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_ram_bank
	inc	sp
;os_msed.c:784: str_copy("usb-game-savedata.sms", rom_inf->file_name);
	ld	hl,(_rom_inf)
	ld	de,#__str_70
	push	hl
	push	de
	call	_str_copy
	pop	af
	pop	af
;os_msed.c:785: rom_inf->run_cfg = 0;
	ld	hl,(_rom_inf)
	ld	bc,#0x0200
	add	hl,bc
	ld	(hl),#0x00
;os_msed.c:786: bi_set_rom_bank(1);
	ld	a,#0x01
	push	af
	inc	sp
	call	_bi_set_rom_bank
	inc	sp
;os_msed.c:787: osLoadSram();
	call	_osLoadSram
00107$:
	ld	sp,ix
	pop	ix
	ret
_osSelectGameUsb_end::
__str_67:
	.ascii "USB loading..."
	.db 0x00
__str_68:
	.ascii "Flash Erase..."
	.db 0x00
__str_69:
	.ascii "Copy ROM."
	.db 0x00
__str_70:
	.ascii "usb-game-savedata.sms"
	.db 0x00
;os_msed.c:810: void osUpdateUsb() {
;	---------------------------------
; Function osUpdateUsb
; ---------------------------------
_osUpdateUsb_start::
_osUpdateUsb:
	push	af
;os_msed.c:813: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
;os_msed.c:814: gCleanScreen();
	call	_gCleanScreen
;os_msed.c:815: gSetXY(0, 2);
	ld	hl,#0x0200
	push	hl
	call	_gSetXY
;os_msed.c:816: gConsPrint("USB loading...");
	ld	hl, #__str_71
	ex	(sp),hl
	call	_gConsPrint
	pop	af
;os_msed.c:817: gRepaint();
	call	_gRepaint
;os_msed.c:820: bi_flash_erase(0x10000, 1);
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x0000
	push	hl
	call	_bi_flash_erase
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;os_msed.c:821: bi_usb_wr_byte((u8) 'k');
	ld	a,#0x6B
	push	af
	inc	sp
	call	_bi_usb_wr_byte
	inc	sp
;os_msed.c:822: addr = 128;
	ld	hl,#0x0080
	ex	(sp), hl
;os_msed.c:823: bi_usb_to_rom(&addr, 64);
	ld	hl,#0x0000
	add	hl,sp
	ld	bc,#0x0040
	push	bc
	push	hl
	call	_bi_usb_to_rom
	pop	af
;os_msed.c:824: bi_usb_wr_byte((u8) 'k');
	ld	h,#0x6B
	ex	(sp),hl
	inc	sp
	call	_bi_usb_wr_byte
	inc	sp
;os_msed.c:825: bi_install_os();
	call	_bi_install_os
	pop	af
	ret
_osUpdateUsb_end::
__str_71:
	.ascii "USB loading..."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
