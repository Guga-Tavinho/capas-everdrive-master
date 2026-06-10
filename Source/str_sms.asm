;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:43 2026
;--------------------------------------------------------
	.module str
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _str_cmp_len
	.globl _str_length
	.globl _str_extension
	.globl _str_extension_list
	.globl _str_eq_ncase
	.globl _str_copy
	.globl _str_append
	.globl _str_append_hex8
	.globl _str_append_hex16
	.globl _str_append_hex32
	.globl _str_contains
	.globl _str_append_num
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;str.c:6: u8 str_cmp_len(u8 *str1, u8 *str2, u8 len) {
;	---------------------------------
; Function str_cmp_len
; ---------------------------------
_str_cmp_len_start::
_str_cmp_len:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;str.c:8: while (len--)if (*str1++ != *str2++)return 0;
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	a,8 (ix)
	ld	-3 (ix),a
00103$:
	ld	h,-3 (ix)
	dec	-3 (ix)
	ld	a,h
	or	a, a
	jr	Z,00105$
	ld	a,(bc)
	ld	-1 (ix),a
	inc	bc
	ld	a,(de)
	ld	-2 (ix),a
	inc	de
	ld	a,-1 (ix)
	sub	a, -2 (ix)
	jr	Z,00103$
	ld	l,#0x00
	jr	00106$
00105$:
;str.c:10: return 1;
	ld	l,#0x01
00106$:
	ld	sp,ix
	pop	ix
	ret
_str_cmp_len_end::
;str.c:13: u8 str_length(u8 *str) {
;	---------------------------------
; Function str_length
; ---------------------------------
_str_length_start::
_str_length:
;str.c:16: while (*str++ != 0)len++;
	ld	d,#0x00
	pop	bc
	pop	hl
	push	hl
	push	bc
00101$:
	ld	a,(hl)
	inc	hl
	or	a, a
	jr	Z,00103$
	inc	d
	jr	00101$
00103$:
;str.c:17: return len;
	ld	l,d
	ret
_str_length_end::
;str.c:20: u8 str_extension(u8 *target, u8 *str) {
;	---------------------------------
; Function str_extension
; ---------------------------------
_str_extension_start::
_str_extension:
	push	ix
	ld	ix,#0
	add	ix,sp
;str.c:25: if (*target == (u8) '.')target++;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	a,(hl)
	sub	a, #0x2E
	jr	NZ,00102$
	inc	hl
	ld	4 (ix),l
	ld	5 (ix),h
00102$:
;str.c:26: str_len = str_length(str);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_str_length
;str.c:27: targ_len = str_length(target);
	ex	(sp),hl
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	call	_str_length
	pop	af
	ld	e,l
	pop	hl
;str.c:28: if (str_len < targ_len)return 0;
	ld	a,l
	sub	a, e
	jr	NC,00104$
	ld	l,#0x00
	jr	00105$
00104$:
;str.c:31: return str_eq_ncase(target, &str[str_len - targ_len]);
	ld	h,#0x00
	ld	d,#0x00
	cp	a, a
	sbc	hl, de
	ld	e,6 (ix)
	ld	d,7 (ix)
	add	hl,de
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_str_eq_ncase
	pop	af
	pop	af
00105$:
	pop	ix
	ret
_str_extension_end::
;str.c:35: u8 str_extension_list(u8 **ext_list, u8 *name) {
;	---------------------------------
; Function str_extension_list
; ---------------------------------
_str_extension_list_start::
_str_extension_list:
;str.c:37: while (*ext_list != 0) {
	pop	bc
	pop	hl
	push	hl
	push	bc
00103$:
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	hl
	ld	a,d
	or	a,e
	jr	Z,00105$
;str.c:38: if (str_extension(*ext_list, name))return 1;
	push	hl
	ld	hl, #6
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	push	de
	call	_str_extension
	pop	af
	pop	af
	ld	a,l
	pop	hl
	or	a, a
	jr	Z,00102$
	ld	l,#0x01
	ret
00102$:
;str.c:39: ext_list++;
	inc	hl
	inc	hl
	jr	00103$
00105$:
;str.c:42: return 0;
	ld	l,#0x00
	ret
_str_extension_list_end::
;str.c:45: u8 str_eq_ncase(u8 *str1, u8 *str2) {
;	---------------------------------
; Function str_eq_ncase
; ---------------------------------
_str_eq_ncase_start::
_str_eq_ncase:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
	ld	c,6 (ix)
	ld	b,7 (ix)
00113$:
;str.c:52: if (*str1 == 0 && *str2 == 0)return 1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-3 (ix),a
	ld	a,(bc)
	ld	e,a
	ld	a,-3 (ix)
	or	a,a
	jr	NZ,00102$
	or	a,e
	jr	NZ,00102$
	ld	l,#0x01
	jr	00115$
00102$:
;str.c:53: val1 = *str1++;
	inc	-2 (ix)
	jr	NZ,00141$
	inc	-1 (ix)
00141$:
	ld	a,-3 (ix)
	ld	-4 (ix),a
;str.c:54: val2 = *str2++;
	inc	bc
;str.c:55: if (val1 >= (u8) 'A' && val1 <= (u8) 'Z')val1 |= 0x20;
	ld	a,-4 (ix)
	sub	a, #0x41
	jr	C,00105$
	ld	a,#0x5A
	sub	a, -4 (ix)
	jr	C,00105$
	set	5, -4 (ix)
00105$:
;str.c:56: if (val2 >= (u8) 'A' && val2 <= (u8) 'Z')val2 |= 0x20;
	ld	a,e
	sub	a, #0x41
	jr	C,00108$
	ld	a,#0x5A
	sub	a, e
	jr	C,00108$
	set	5, e
00108$:
;str.c:57: if (val1 != val2)return 0;
	ld	a,-4 (ix)
	sub	a, e
	jr	Z,00113$
	ld	l,#0x00
00115$:
	ld	sp,ix
	pop	ix
	ret
_str_eq_ncase_end::
;str.c:62: void str_copy(u8 *src, u8 *dst) {
;	---------------------------------
; Function str_copy
; ---------------------------------
_str_copy_start::
_str_copy:
	push	ix
	ld	ix,#0
	add	ix,sp
;str.c:64: while (*src != 0)*dst++ = *src++;
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	c,6 (ix)
	ld	b,7 (ix)
00101$:
	ld	a,(de)
	or	a, a
	jr	Z,00103$
	inc	de
	ld	(bc),a
	inc	bc
	jr	00101$
00103$:
;str.c:65: *dst = 0;
	xor	a, a
	ld	(bc),a
	pop	ix
	ret
_str_copy_end::
;str.c:69: void str_append(u8 *dst, u8 *src) {
;	---------------------------------
; Function str_append
; ---------------------------------
_str_append_start::
_str_append:
	push	ix
	ld	ix,#0
	add	ix,sp
;str.c:71: while (*dst != 0)dst++;
	ld	c,4 (ix)
	ld	b,5 (ix)
00101$:
	ld	a,(bc)
	or	a, a
	jr	Z,00112$
	inc	bc
	jr	00101$
;str.c:72: while (*src != 0)*dst++ = *src++;
00112$:
	ld	e,6 (ix)
	ld	d,7 (ix)
00104$:
	ld	a,(de)
	or	a, a
	jr	Z,00106$
	inc	de
	ld	(bc),a
	inc	bc
	jr	00104$
00106$:
;str.c:73: *dst = 0;
	xor	a, a
	ld	(bc),a
	pop	ix
	ret
_str_append_end::
;str.c:76: void str_append_hex8(u8 num, u8 *dst) {
;	---------------------------------
; Function str_append_hex8
; ---------------------------------
_str_append_hex8_start::
_str_append_hex8:
	push	ix
	ld	ix,#0
	add	ix,sp
;str.c:81: str_len = str_length(dst);
	push	de
	ld	l,5 (ix)
	ld	h,6 (ix)
	push	hl
	call	_str_length
	pop	af
	pop	de
;str.c:82: dst = (u8 *) & dst[str_len];
	ld	a,5 (ix)
	add	a, l
	ld	5 (ix),a
	ld	a,6 (ix)
	adc	a, #0x00
	ld	6 (ix),a
;str.c:83: dst[2] = 0;
	ld	l,5 (ix)
	ld	h,6 (ix)
	inc	hl
	inc	hl
	ld	(hl),#0x00
;str.c:85: val = num >> 4;
	ld	a,4 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	ld	d,a
;str.c:86: if (val > 9)val += 7;
	ld	a,#0x09
	sub	a, d
	jr	NC,00102$
	ld	a,d
	add	a, #0x07
	ld	d,a
00102$:
;str.c:87: dst[0] = val + '0';
	ld	l,5 (ix)
	ld	h,6 (ix)
	ld	a,d
	add	a, #0x30
	ld	(hl),a
;str.c:88: val = num & 0x0f;
	ld	a,4 (ix)
	and	a, #0x0F
	ld	d,a
;str.c:89: if (val > 9)val += 7;
	ld	a,#0x09
	sub	a, d
	jr	NC,00104$
	ld	a,d
	add	a, #0x07
	ld	d,a
00104$:
;str.c:90: dst[1] = val + '0';
	inc	hl
	ld	a,d
	add	a, #0x30
	ld	(hl),a
	pop	ix
	ret
_str_append_hex8_end::
;str.c:94: void str_append_hex16(u16 num, u8 *dst) {
;	---------------------------------
; Function str_append_hex16
; ---------------------------------
_str_append_hex16_start::
_str_append_hex16:
;str.c:96: str_append_hex8(num >> 8, dst);
	ld	iy,#2
	add	iy,sp
	ld	h,1 (iy)
	ld	l,#0x00
	ld	iy,#4
	add	iy,sp
	ld	c,0 (iy)
	ld	b,1 (iy)
	push	bc
	push	hl
	inc	sp
	call	_str_append_hex8
	pop	af
	inc	sp
;str.c:97: str_append_hex8(num & 0xff, dst);
	ld	iy,#2
	add	iy,sp
	ld	h,0 (iy)
	ld	l,#0x00
	ld	iy,#4
	add	iy,sp
	ld	c,0 (iy)
	ld	b,1 (iy)
	push	bc
	push	hl
	inc	sp
	call	_str_append_hex8
	pop	af
	inc	sp
	ret
_str_append_hex16_end::
;str.c:102: void str_append_hex32(u32 num, u8 *dst) {
;	---------------------------------
; Function str_append_hex32
; ---------------------------------
_str_append_hex32_start::
_str_append_hex32:
	push	ix
	ld	ix,#0
	add	ix,sp
;str.c:104: str_append_hex16(num >> 16, dst);
	push	af
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	pop	af
	ld	b,#0x10
00103$:
	srl	d
	rr	e
	rr	h
	rr	l
	djnz	00103$
	ld	c,8 (ix)
	ld	b,9 (ix)
	push	bc
	push	hl
	call	_str_append_hex16
	pop	af
	pop	af
;str.c:105: str_append_hex16(num & 0xffff, dst);
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	c,8 (ix)
	ld	b,9 (ix)
	push	bc
	push	hl
	call	_str_append_hex16
	pop	af
	pop	af
	pop	ix
	ret
_str_append_hex32_end::
;str.c:110: u8 str_contains(u8 *target, u8 *str) {
;	---------------------------------
; Function str_contains
; ---------------------------------
_str_contains_start::
_str_contains:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;str.c:112: u16 targ_len = str_length(target);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_str_length
	pop	af
	ld	-4 (ix),l
	ld	-3 (ix),#0x00
;str.c:116: for (eq_len = 0; eq_len < targ_len;) {
	ld	de,#0x0000
	ld	c,6 (ix)
	ld	b,7 (ix)
00110$:
	ld	a,e
	sub	a, -4 (ix)
	ld	a,d
	sbc	a, -3 (ix)
	jr	NC,00106$
;str.c:118: if (*str == 0)return 0;
	ld	a,(bc)
	or	a,a
	jr	NZ,00102$
	ld	l,a
	jr	00112$
00102$:
;str.c:119: if (*str++ == target[eq_len]) {
	ld	-1 (ix),a
	inc	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	sub	a, -2 (ix)
	jr	NZ,00104$
;str.c:120: eq_len++;
	inc	de
	jr	00110$
00104$:
;str.c:122: eq_len = 0;
	ld	de,#0x0000
	jr	00110$
00106$:
;str.c:126: if (eq_len != targ_len)return 0;
	ld	a,-4 (ix)
	sub	a, e
	jr	NZ,00131$
	ld	a,-3 (ix)
	sub	a, d
	jr	Z,00108$
00131$:
	ld	l,#0x00
	jr	00112$
00108$:
;str.c:128: return 1;
	ld	l,#0x01
00112$:
	ld	sp,ix
	pop	ix
	ret
_str_contains_end::
;str.c:133: void str_append_num(u32 num, u8 *dst) {
;	---------------------------------
; Function str_append_num
; ---------------------------------
_str_append_num_start::
_str_append_num:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
;str.c:137: u8 *str = (u8 *) & buff[10];
	ld	hl,#0x0000 + 0x000A
	add	hl,sp
;str.c:140: *str = 0;
	ld	(hl),#0x00
;str.c:141: if (num == 0)*--str = '0';
	ld	a,7 (ix)
	or	a, 6 (ix)
	or	a, 5 (ix)
	or	a,4 (ix)
	jr	NZ,00111$
	dec	hl
	ld	(hl),#0x30
;str.c:142: for (i = 0; num != 0; i++) {
00111$:
	ld	c, l
	ld	b, h
00105$:
	ld	a,4 (ix)
	or	a, 5 (ix)
	or	a, 6 (ix)
	or	a, 7 (ix)
	jr	Z,00103$
;str.c:143: *--str = num % 10 + '0';
	dec	bc
	push	bc
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x000A
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__modulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
	ld	a,l
	add	a, #0x30
	ld	(bc),a
;str.c:144: num /= 10;
	push	bc
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x000A
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__divulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
	ld	4 (ix),l
	ld	5 (ix),h
	ld	6 (ix),e
	ld	7 (ix),d
;str.c:142: for (i = 0; num != 0; i++) {
	jr	00105$
00103$:
;str.c:147: str_append(dst, str);
	push	bc
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	_str_append
	ld	sp,ix
	pop	ix
	ret
_str_append_num_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
