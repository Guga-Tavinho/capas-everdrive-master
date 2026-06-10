;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:43 2026
;--------------------------------------------------------
	.module sys
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sysDrawFileSize
	.globl _gScreenW
	.globl _gAppendChar
	.globl _gAppendStringMl
	.globl _gSetXY
	.globl _gAppendString
	.globl _gDrawString
	.globl _gDrawStringCx
	.globl _gAppendNum
	.globl _gAppendHex8
	.globl _gAppendHex16
	.globl _gAppendHex16SW
	.globl _gAppendHex32
	.globl _gDrawStringMl
	.globl _gDrawNum
	.globl _gDrawCursor
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_gDrawCursor_cursor_strobe_1_75:
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
;sys.c:4: void gDrawString(u8 *str, u8 x, u8 y) {
;	---------------------------------
; Function gDrawString
; ---------------------------------
_gDrawString_start::
_gDrawString:
;sys.c:6: gSetXY(x, y);
	ld	hl, #5+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #5+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_gSetXY
	pop	af
;sys.c:7: gAppendString(str);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_gAppendString
	pop	af
	ret
_gDrawString_end::
;sys.c:10: void gDrawStringCx(u8 *str, u8 y) {
;	---------------------------------
; Function gDrawStringCx
; ---------------------------------
_gDrawStringCx_start::
_gDrawStringCx:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys.c:13: while (str[x] != 0)x++;
	ld	bc,#0x0000
00101$:
	ld	l,4 (ix)
	ld	h,5 (ix)
	add	hl,bc
	ld	a,(hl)
	or	a, a
	jr	Z,00103$
	inc	bc
	jr	00101$
00103$:
;sys.c:14: x = (gScreenW() - x) / 2;
	push	bc
	call	_gScreenW
	pop	bc
	ld	h,#0x00
	cp	a, a
	sbc	hl, bc
	srl	h
	rr	l
;sys.c:15: gDrawString(str, x, y);
	ld	d,l
	ld	a,6 (ix)
	push	af
	inc	sp
	push	de
	inc	sp
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_gDrawString
	pop	af
	pop	af
	pop	ix
	ret
_gDrawStringCx_end::
;sys.c:18: void gAppendNum(u32 num) {
;	---------------------------------
; Function gAppendNum
; ---------------------------------
_gAppendNum_start::
_gAppendNum:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
;sys.c:22: u8 *str = (u8 *) & buff[10];
	ld	hl,#0x0000 + 0x000A
	add	hl,sp
;sys.c:25: *str = 0;
	ld	(hl),#0x00
;sys.c:26: if (num == 0)*--str = '0';
	ld	a,7 (ix)
	or	a, 6 (ix)
	or	a, 5 (ix)
	or	a,4 (ix)
	jr	NZ,00111$
	dec	hl
	ld	(hl),#0x30
;sys.c:27: for (i = 0; num != 0; i++) {
00111$:
	ld	c, l
	ld	b, h
00105$:
	ld	a,4 (ix)
	or	a, 5 (ix)
	or	a, 6 (ix)
	or	a, 7 (ix)
	jr	Z,00103$
;sys.c:28: *--str = num % 10 + '0';
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
;sys.c:29: num /= 10;
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
;sys.c:27: for (i = 0; num != 0; i++) {
	jr	00105$
00103$:
;sys.c:32: gAppendString(str);
	push	bc
	call	_gAppendString
	ld	sp,ix
	pop	ix
	ret
_gAppendNum_end::
;sys.c:36: void gAppendHex8(u8 num) {
;	---------------------------------
; Function gAppendHex8
; ---------------------------------
_gAppendHex8_start::
_gAppendHex8:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;sys.c:40: buff[2] = 0;
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	inc	hl
	inc	hl
	ld	(hl),#0x00
;sys.c:42: val = num >> 4;
	ld	a,4 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	ld	d,a
;sys.c:43: if (val > 9)val += 7;
	ld	a,#0x09
	sub	a, d
	jr	NC,00102$
	ld	a,d
	add	a, #0x07
	ld	d,a
00102$:
;sys.c:44: buff[0] = val + '0';
	ld	a,d
	add	a, #0x30
	ld	(bc),a
;sys.c:45: val = num & 0x0f;
	ld	a,4 (ix)
	and	a, #0x0F
	ld	d,a
;sys.c:46: if (val > 9)val += 7;
	ld	a,#0x09
	sub	a, d
	jr	NC,00104$
	ld	a,d
	add	a, #0x07
	ld	d,a
00104$:
;sys.c:47: buff[1] = val + '0';
	ld	l, c
	ld	h, b
	inc	hl
	ld	a,d
	add	a, #0x30
	ld	(hl),a
;sys.c:49: gAppendString(buff);
	push	de
	push	bc
	call	_gAppendString
	pop	af
	pop	de
	ld	sp,ix
	pop	ix
	ret
_gAppendHex8_end::
;sys.c:52: void gAppendHex16(u16 num) {
;	---------------------------------
; Function gAppendHex16
; ---------------------------------
_gAppendHex16_start::
_gAppendHex16:
;sys.c:54: gAppendHex8(num >> 8);
	ld	iy,#2
	add	iy,sp
	ld	h,1 (iy)
	ld	l,#0x00
	push	hl
	inc	sp
	call	_gAppendHex8
	inc	sp
;sys.c:55: gAppendHex8(num & 0xff);
	ld	iy,#2
	add	iy,sp
	ld	h,0 (iy)
	ld	l,#0x00
	push	hl
	inc	sp
	call	_gAppendHex8
	inc	sp
	ret
_gAppendHex16_end::
;sys.c:58: void gAppendHex16SW(u16 num) {
;	---------------------------------
; Function gAppendHex16SW
; ---------------------------------
_gAppendHex16SW_start::
_gAppendHex16SW:
;sys.c:60: gAppendHex8(num & 0xff);
	ld	iy,#2
	add	iy,sp
	ld	h,0 (iy)
	ld	l,#0x00
	push	hl
	inc	sp
	call	_gAppendHex8
	inc	sp
;sys.c:61: gAppendHex8(num >> 8);
	ld	iy,#2
	add	iy,sp
	ld	h,1 (iy)
	ld	l,#0x00
	push	hl
	inc	sp
	call	_gAppendHex8
	inc	sp
	ret
_gAppendHex16SW_end::
;sys.c:64: void gAppendHex32(u32 num) {
;	---------------------------------
; Function gAppendHex32
; ---------------------------------
_gAppendHex32_start::
_gAppendHex32:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys.c:66: gAppendHex16(num >> 16);
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
	push	hl
	call	_gAppendHex16
	pop	af
;sys.c:67: gAppendHex16(num & 0xffff);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_gAppendHex16
	pop	af
	pop	ix
	ret
_gAppendHex32_end::
;sys.c:70: void gDrawStringMl(u8 *str, u8 x, u8 y, u16 len) {
;	---------------------------------
; Function gDrawStringMl
; ---------------------------------
_gDrawStringMl_start::
_gDrawStringMl:
;sys.c:72: gSetXY(x, y);
	ld	hl, #5+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #5+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_gSetXY
	pop	af
;sys.c:73: gAppendStringMl(str, len);
	ld	hl, #6
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	hl, #4
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_gAppendStringMl
	pop	af
	pop	af
	ret
_gDrawStringMl_end::
;sys.c:76: void gDrawNum(u32 num, u8 x, u8 y) {
;	---------------------------------
; Function gDrawNum
; ---------------------------------
_gDrawNum_start::
_gDrawNum:
;sys.c:78: gSetXY(x, y);
	ld	hl, #7+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #7+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_gSetXY
	pop	af
;sys.c:79: gAppendNum(num);
	ld	iy,#2
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	call	_gAppendNum
	pop	af
	pop	af
	ret
_gDrawNum_end::
;sys.c:82: void sysDrawFileSize(u32 size, u16 x, u16 y) {
;	---------------------------------
; Function sysDrawFileSize
; ---------------------------------
_sysDrawFileSize_start::
_sysDrawFileSize:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;sys.c:85: gDrawNum(size, x, y);
	ld	a,10 (ix)
	ld	-1 (ix),a
	ld	a,8 (ix)
	ld	-2 (ix),a
;sys.c:84: if (size < 1024) {
	ld	a,5 (ix)
	and	a, #0xFC
	jr	NZ,00105$
	ld	a,6 (ix)
	or	a, a
	jr	NZ,00105$
	ld	a,7 (ix)
	or	a, a
	jr	NZ,00105$
;sys.c:85: gDrawNum(size, x, y);
	ld	h,-1 (ix)
	ld	l,-2 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_gDrawNum
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys.c:86: gAppendChar((u8) 'B');
	ld	a,#0x42
	push	af
	inc	sp
	call	_gAppendChar
	inc	sp
	jr	00107$
00105$:
;sys.c:87: } else if (size < 0x100000) {
	ld	a,6 (ix)
	and	a, #0xF0
	jr	NZ,00102$
	ld	a,7 (ix)
	or	a, a
	jr	NZ,00102$
;sys.c:88: gDrawNum(size / 1024, x, y);
	push	af
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	c,6 (ix)
	ld	b,7 (ix)
	pop	af
	ld	a,#0x0A
00119$:
	srl	b
	rr	c
	rr	d
	rr	e
	dec	a
	jr	NZ,00119$
	ld	h,-1 (ix)
	ld	l,-2 (ix)
	push	hl
	push	bc
	push	de
	call	_gDrawNum
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys.c:89: gAppendChar((u8) 'K');
	ld	a,#0x4B
	push	af
	inc	sp
	call	_gAppendChar
	inc	sp
	jr	00107$
00102$:
;sys.c:91: gDrawNum(size / 0x100000, x, y);
	push	af
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	c,6 (ix)
	ld	b,7 (ix)
	pop	af
	ld	a,#0x14
00121$:
	srl	b
	rr	c
	rr	d
	rr	e
	dec	a
	jr	NZ,00121$
	ld	h,-1 (ix)
	ld	l,-2 (ix)
	push	hl
	push	bc
	push	de
	call	_gDrawNum
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys.c:92: gAppendChar((u8) 'M');
	ld	a,#0x4D
	push	af
	inc	sp
	call	_gAppendChar
	inc	sp
00107$:
	ld	sp,ix
	pop	ix
	ret
_sysDrawFileSize_end::
;sys.c:96: void gDrawCursor(u8 *str, u16 x, u16 y) {
;	---------------------------------
; Function gDrawCursor
; ---------------------------------
_gDrawCursor_start::
_gDrawCursor:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys.c:100: cursor_strobe++;
	ld	hl, #_gDrawCursor_cursor_strobe_1_75+0
	inc	(hl)
	jr	NZ,00109$
	ld	hl, #_gDrawCursor_cursor_strobe_1_75+1
	inc	(hl)
00109$:
;sys.c:102: if ((cursor_strobe & 15) < 8) {
	ld	a,(#_gDrawCursor_cursor_strobe_1_75 + 0)
	and	a, #0x0F
	ld	l,a
	ld	e,#0x00
;sys.c:103: gDrawString(str, x, y);
	ld	h,8 (ix)
	ld	d,6 (ix)
;sys.c:102: if ((cursor_strobe & 15) < 8) {
	ld	a,l
	sub	a, #0x08
	ld	a,e
	sbc	a, #0x00
	jr	NC,00102$
;sys.c:103: gDrawString(str, x, y);
	push	hl
	inc	sp
	push	de
	inc	sp
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_gDrawString
	pop	af
	pop	af
	jr	00104$
00102$:
;sys.c:105: gDrawString(" ", x, y);
	ld	bc,#__str_0
	push	hl
	inc	sp
	push	de
	inc	sp
	push	bc
	call	_gDrawString
	pop	af
	pop	af
00104$:
	pop	ix
	ret
_gDrawCursor_end::
__str_0:
	.ascii " "
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
