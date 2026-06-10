;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:35 2026
;--------------------------------------------------------
	.module browser
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _browser
	.globl _guiGetMaxRows
	.globl _guiDrawBrowser
	.globl _sysJoyWait
	.globl _osExitBrowser
	.globl _osMainMenu
	.globl _osStartGame
	.globl _osFileMenu
	.globl _fat_get_full_record
	.globl _fat_load_dir
	.globl _sel_stack
	.globl _br_rec
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_br_rec::
	.ds 229
_sel_stack::
	.ds 64
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
;browser.c:13: u8 browser() {
;	---------------------------------
; Function browser
; ---------------------------------
_browser_start::
_browser:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-28
	add	hl,sp
	ld	sp,hl
;browser.c:26: selector = 0;
	ld	-23 (ix),#0x00
	ld	-22 (ix),#0x00
;browser.c:27: rows = guiGetMaxRows();
	call	_guiGetMaxRows
	ld	-27 (ix),l
;browser.c:28: full_repaint = 2;
	ld	-26 (ix),#0x02
;browser.c:29: current_dir = 0;
	xor	a, a
	ld	-17 (ix),a
	ld	-16 (ix),a
	ld	-15 (ix),a
	ld	-14 (ix),a
;browser.c:30: sel_stack_ptr = 0;
	ld	-21 (ix),#0x00
	ld	-20 (ix),#0x00
00163$:
;browser.c:34: if (full_repaint == 2) {
	ld	a,-26 (ix)
	sub	a, #0x02
	jr	NZ,00104$
;browser.c:35: resp = fat_load_dir(current_dir);
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	_fat_load_dir
	pop	af
	pop	af
;browser.c:36: if (resp)return resp;
	ld	-28 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00104$
	ld	l,-28 (ix)
	jp	00164$
00104$:
;browser.c:39: resp = guiDrawBrowser(full_repaint, selector);
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	push	hl
	ld	a,-26 (ix)
	push	af
	inc	sp
	call	_guiDrawBrowser
	pop	af
	inc	sp
;browser.c:40: if (resp)return resp;
	ld	-28 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00106$
	ld	l,-28 (ix)
	jp	00164$
00106$:
;browser.c:41: full_repaint = 0;
	ld	-26 (ix),#0x00
;browser.c:42: sysJoyWait();
	call	_sysJoyWait
;browser.c:44: if ((joy & JOY_U) == JOY_U) {
	ld	a,(#_joy + 0)
	and	a, #0x01
	ld	d,a
	ld	e,#0x00
;browser.c:45: page = selector / rows * rows;
	ld	a,-27 (ix)
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
;browser.c:47: sub_sel = sub_sel == 0 ? rows - 1 : sub_sel - 1;
	ld	a,-27 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
;browser.c:49: if (selector >= fat_dir_size && fat_dir_size > 0)selector = fat_dir_size - 1;
	ld	a,(#_fat_dir_size + 0)
	add	a,#0xFF
	ld	-4 (ix),a
	ld	a,(#_fat_dir_size + 1)
	adc	a,#0xFF
	ld	-3 (ix),a
;browser.c:45: page = selector / rows * rows;
	push	de
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	ld	c,-6 (ix)
	ld	b,-5 (ix)
	push	bc
	push	hl
;browser.c:44: if ((joy & JOY_U) == JOY_U) {
	call	__mulint_rrx_s
	pop	af
	pop	af
	ld	-1 (ix),h
	ld	-2 (ix),l
	pop	de
	dec	d
	jp	NZ,00111$
	ld	a,e
	or	a, a
	jr	NZ,00111$
;browser.c:45: page = selector / rows * rows;
	ld	a,-2 (ix)
	ld	-19 (ix),a
	ld	a,-1 (ix)
	ld	-18 (ix),a
;browser.c:46: sub_sel = selector - page;
	ld	a,-23 (ix)
	sub	a, -19 (ix)
	ld	l,a
	ld	a,-22 (ix)
	sbc	a, -18 (ix)
	ld	-25 (ix), l
;browser.c:47: sub_sel = sub_sel == 0 ? rows - 1 : sub_sel - 1;
	ld	-24 (ix), a
	or	a, -25 (ix)
	sub	a,#0x01
	ld	a,#0x00
	rla
	or	a, a
	jr	Z,00166$
	ld	e,-9 (ix)
	ld	d,-8 (ix)
	dec	de
	jr	00167$
00166$:
	ld	e,-25 (ix)
	ld	d,-24 (ix)
	dec	de
00167$:
	ld	-25 (ix),e
	ld	-24 (ix),d
;browser.c:48: selector = page + sub_sel;
	ld	a,-19 (ix)
	add	a, -25 (ix)
	ld	h,a
	ld	a,-18 (ix)
	adc	a, -24 (ix)
	ld	-23 (ix), h
	ld	-22 (ix), a
;browser.c:49: if (selector >= fat_dir_size && fat_dir_size > 0)selector = fat_dir_size - 1;
	ld	hl,#_fat_dir_size
	ld	a,-23 (ix)
	sub	a, (hl)
	ld	a,-22 (ix)
	inc	hl
	sbc	a, (hl)
	jp	C,00163$
	ld	a,(#_fat_dir_size + 1)
	ld	hl,#_fat_dir_size + 0
	or	a,(hl)
	jp	Z,00163$
	ld	a,-4 (ix)
	ld	-23 (ix),a
	ld	a,-3 (ix)
	ld	-22 (ix),a
;browser.c:50: continue;
	jp	00163$
00111$:
;browser.c:53: if ((joy & JOY_D) == JOY_D) {
	ld	a,(#_joy + 0)
	and	a, #0x02
	ld	h,a
	ld	l,#0x00
	ld	a,h
	sub	a,#0x02
	jr	NZ,00117$
	or	a,l
	jr	NZ,00117$
;browser.c:54: page = selector / rows * rows;
	ld	a,-2 (ix)
	ld	-19 (ix),a
	ld	a,-1 (ix)
	ld	-18 (ix),a
;browser.c:55: sub_sel = selector - page;
	ld	a,-23 (ix)
	sub	a, -19 (ix)
	ld	h,a
	ld	a,-22 (ix)
	sbc	a, -18 (ix)
	ld	-25 (ix), h
	ld	-24 (ix), a
;browser.c:56: sub_sel++;
	inc	-25 (ix)
	jr	NZ,00273$
	inc	-24 (ix)
00273$:
;browser.c:57: if (sub_sel >= rows)sub_sel = 0;
	ld	a,-25 (ix)
	sub	a, -6 (ix)
	ld	a,-24 (ix)
	sbc	a, -5 (ix)
	jr	C,00113$
	ld	-25 (ix),#0x00
	ld	-24 (ix),#0x00
00113$:
;browser.c:58: selector = page + sub_sel;
	ld	a,-19 (ix)
	add	a, -25 (ix)
	ld	h,a
	ld	a,-18 (ix)
	adc	a, -24 (ix)
	ld	-23 (ix), h
	ld	-22 (ix), a
;browser.c:59: if (selector >= fat_dir_size)selector = page;
	ld	hl,#_fat_dir_size
	ld	a,-23 (ix)
	sub	a, (hl)
	ld	a,-22 (ix)
	inc	hl
	sbc	a, (hl)
	jp	C,00163$
	ld	a,-19 (ix)
	ld	-23 (ix),a
	ld	a,-18 (ix)
	ld	-22 (ix),a
;browser.c:60: continue;
	jp	00163$
00117$:
;browser.c:63: if ((joy & JOY_R) == JOY_R) {
	ld	a,(#_joy + 0)
	and	a, #0x08
	ld	d,a
	ld	e,#0x00
;browser.c:64: if (fat_dir_size <= rows)continue;
	ld	a,-6 (ix)
	ld	iy,#_fat_dir_size
	sub	a, 0 (iy)
	ld	a,-5 (ix)
	ld	iy,#_fat_dir_size
	sbc	a, 1 (iy)
	ld	a,#0x00
	rla
	ld	-7 (ix),a
;browser.c:67: page += rows;
;browser.c:63: if ((joy & JOY_R) == JOY_R) {
	ld	a,d
	sub	a,#0x08
	jp	NZ,00125$
	or	a,e
	jp	NZ,00125$
;browser.c:64: if (fat_dir_size <= rows)continue;
	ld	a,-7 (ix)
	or	a, a
	jp	Z,00163$
;browser.c:65: page = selector / rows * rows;
	ld	a,-2 (ix)
	ld	-19 (ix),a
	ld	a,-1 (ix)
	ld	-18 (ix),a
;browser.c:66: sub_sel = selector - page;
	ld	a,-23 (ix)
	sub	a, -19 (ix)
	ld	h,a
	ld	a,-22 (ix)
	sbc	a, -18 (ix)
	ld	-25 (ix), h
	ld	-24 (ix), a
;browser.c:67: page += rows;
	ld	a,-19 (ix)
	add	a, -9 (ix)
	ld	-19 (ix),a
	ld	a,-18 (ix)
	adc	a, -8 (ix)
	ld	-18 (ix),a
;browser.c:68: if (page >= fat_dir_size)page = 0;
	ld	hl,#_fat_dir_size
	ld	a,-19 (ix)
	sub	a, (hl)
	ld	a,-18 (ix)
	inc	hl
	sbc	a, (hl)
	jr	C,00121$
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
00121$:
;browser.c:69: selector = page + sub_sel;
	ld	a,-19 (ix)
	add	a, -25 (ix)
	ld	h,a
	ld	a,-18 (ix)
	adc	a, -24 (ix)
	ld	-23 (ix), h
	ld	-22 (ix), a
;browser.c:70: if (selector >= fat_dir_size)selector = fat_dir_size - 1;
	ld	hl,#_fat_dir_size
	ld	a,-23 (ix)
	sub	a, (hl)
	ld	a,-22 (ix)
	inc	hl
	sbc	a, (hl)
	jr	C,00123$
	ld	a,-4 (ix)
	ld	-23 (ix),a
	ld	a,-3 (ix)
	ld	-22 (ix),a
00123$:
;browser.c:71: full_repaint = 1;
	ld	-26 (ix),#0x01
00125$:
;browser.c:77: if ((joy & JOY_L) == JOY_L) {
	ld	a,(#_joy + 0)
	and	a, #0x04
	ld	h,a
	ld	l,#0x00
	ld	a,h
	sub	a,#0x04
	jp	NZ,00134$
	or	a,l
	jp	NZ,00134$
;browser.c:78: if (fat_dir_size <= rows)continue;
	ld	a,-7 (ix)
	or	a, a
	jp	Z,00163$
;browser.c:79: page = selector / rows * rows;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	ld	-1 (ix),h
	ld	-2 (ix),l
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	__mulint_rrx_s
	pop	af
	pop	af
	ld	-1 (ix),h
	ld	-2 (ix), l
	ld	-19 (ix), l
	ld	a,-1 (ix)
	ld	-18 (ix),a
;browser.c:80: sub_sel = selector - page;
	ld	a,-23 (ix)
	sub	a, -19 (ix)
	ld	-2 (ix),a
	ld	a,-22 (ix)
	sbc	a, -18 (ix)
	ld	-1 (ix),a
	ld	a,-2 (ix)
	ld	-25 (ix),a
	ld	a,-1 (ix)
	ld	-24 (ix),a
;browser.c:81: if (selector < rows) {
	ld	a,-23 (ix)
	sub	a, -6 (ix)
	ld	a,-22 (ix)
	sbc	a, -5 (ix)
	jr	NC,00131$
;browser.c:82: selector = fat_dir_size / rows * rows + sub_sel;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	hl,(_fat_dir_size)
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	ld	-1 (ix),h
	ld	-2 (ix),l
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	__mulint_rrx_s
	pop	af
	pop	af
	ld	-1 (ix),h
	ld	-2 (ix),l
	ld	a,-25 (ix)
	add	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,-24 (ix)
	adc	a, -1 (ix)
	ld	-1 (ix),a
	ld	a,-2 (ix)
	ld	-23 (ix),a
	ld	a,-1 (ix)
	ld	-22 (ix),a
;browser.c:83: if (selector >= fat_dir_size) selector = fat_dir_size - 1;
	ld	hl,#_fat_dir_size
	ld	a,-23 (ix)
	sub	a, (hl)
	ld	a,-22 (ix)
	inc	hl
	sbc	a, (hl)
	jr	C,00132$
	ld	a,-4 (ix)
	ld	-23 (ix),a
	ld	a,-3 (ix)
	ld	-22 (ix),a
	jr	00132$
00131$:
;browser.c:85: selector -= rows;
	ld	a,-23 (ix)
	sub	a, -9 (ix)
	ld	-23 (ix),a
	ld	a,-22 (ix)
	sbc	a, -8 (ix)
	ld	-22 (ix),a
00132$:
;browser.c:87: full_repaint = 1;
	ld	-26 (ix),#0x01
00134$:
;browser.c:92: if ((joy & JOY_B) == JOY_B && fat_dir_size != 0) {
	ld	a,(#_joy + 0)
	and	a, #0x10
	ld	h,a
	ld	l,#0x00
	ld	a,h
	sub	a,#0x10
	jp	NZ,00145$
	or	a,l
	jp	NZ,00145$
	ld	a,(#_fat_dir_size + 1)
	ld	hl,#_fat_dir_size + 0
	or	a,(hl)
	jp	Z,00145$
;browser.c:93: resp = fat_get_full_record(fat_dir[selector], &br_rec);
	ld	a,-23 (ix)
	ld	-2 (ix),a
	ld	a,-22 (ix)
	ld	-1 (ix),a
	ld	a,#0x02+1
	jr	00281$
00280$:
	sla	-2 (ix)
	rl	-1 (ix)
00281$:
	dec	a
	jr	NZ,00280$
	ld	a,(#_fat_dir + 0)
	add	a, -2 (ix)
	ld	-2 (ix),a
	ld	iy,#_fat_dir
	ld	a,1 (iy)
	adc	a, -1 (ix)
	ld	-1 (ix),a
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	ld	hl, #0x000F
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	hl,#_br_rec
	push	hl
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	push	hl
	call	_fat_get_full_record
	pop	af
	pop	af
	pop	af
	ld	-13 (ix), l
	ld	a, l
;browser.c:94: if (resp)return resp;
	ld	-28 (ix), a
	or	a, a
	jr	Z,00136$
	ld	l,-28 (ix)
	jp	00164$
00136$:
;browser.c:96: if (br_rec.is_dir) {
	ld	a,(#_br_rec + 228)
	ld	-13 (ix), a
	or	a, a
	jr	Z,00142$
;browser.c:97: if (sel_stack_ptr >= MAX_SEL_STACK_DEEP)continue;
	ld	a,-21 (ix)
	sub	a, #0x20
	ld	a,-20 (ix)
	sbc	a, #0x00
	jp	NC,00163$
;browser.c:98: current_dir = br_rec.data_clsut;
	ld	de, #_br_rec + 220
	ld	hl, #0x000B
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
;browser.c:99: full_repaint = 2;
	ld	-26 (ix),#0x02
;browser.c:100: sel_stack[sel_stack_ptr++] = selector;
	ld	a,-21 (ix)
	ld	-13 (ix),a
	ld	a,-20 (ix)
	ld	-12 (ix),a
	inc	-21 (ix)
	jr	NZ,00282$
	inc	-20 (ix)
00282$:
	ld	a,-13 (ix)
	ld	-13 (ix),a
	ld	a,-12 (ix)
	ld	-12 (ix),a
	sla	-13 (ix)
	rl	-12 (ix)
	ld	a,#<(_sel_stack)
	add	a, -13 (ix)
	ld	-13 (ix),a
	ld	a,#>(_sel_stack)
	adc	a, -12 (ix)
	ld	-12 (ix),a
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	a,-23 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-22 (ix)
	ld	(hl),a
;browser.c:101: selector = 0;
	ld	-23 (ix),#0x00
	ld	-22 (ix),#0x00
	jp	00163$
00142$:
;browser.c:103: full_repaint = 2;
	ld	-26 (ix),#0x02
;browser.c:104: resp = osFileMenu(&br_rec);
	ld	hl,#_br_rec
	push	hl
	call	_osFileMenu
	pop	af
;browser.c:105: if (resp)return resp;
	ld	-28 (ix), l
	ld	a, l
	or	a, a
	jp	Z,00163$
	ld	l,-28 (ix)
	jp	00164$
;browser.c:108: continue;
00145$:
;browser.c:111: if ((joy & JOY_A) == JOY_A && sel_stack_ptr == 0) {
	ld	a,(#_joy + 0)
	and	a, #0x20
	ld	h,a
	ld	l,#0x00
	ld	a,h
	sub	a,#0x20
	jr	NZ,00150$
	or	a,l
	jr	NZ,00150$
	ld	a,-20 (ix)
	or	a,-21 (ix)
	jr	NZ,00150$
;browser.c:112: full_repaint = 2;
	ld	-26 (ix),#0x02
;browser.c:113: resp = osExitBrowser();
	call	_osExitBrowser
;browser.c:114: if (resp)return resp;
	ld	-28 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00150$
	ld	l,-28 (ix)
	jp	00164$
00150$:
;browser.c:117: if ((joy & JOY_A) == JOY_A && sel_stack_ptr != 0) {
	ld	iy,#_joy
	ld	a,0 (iy)
	and	a, #0x20
	ld	h,a
	ld	l,#0x00
	ld	a,h
	sub	a,#0x20
	jr	NZ,00153$
	or	a,l
	jr	NZ,00153$
	ld	a,-20 (ix)
	or	a,-21 (ix)
	jr	Z,00153$
;browser.c:119: current_dir = fat_sub_dir_clust;
	ld	hl, #11
	add	hl, sp
	ex	de, hl
	ld	hl, #_fat_sub_dir_clust
	ld	bc, #4
	ldir
;browser.c:120: full_repaint = 2;
	ld	-26 (ix),#0x02
;browser.c:121: selector = sel_stack[--sel_stack_ptr];
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	dec	hl
	ld	-21 (ix),l
	ld	-20 (ix),h
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	add	hl, hl
	ld	de,#_sel_stack
	add	hl,de
	ld	a,(hl)
	ld	-23 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-22 (ix),a
;browser.c:122: continue;
	jp	00163$
00153$:
;browser.c:129: if ((joy & JOY_SEL) == JOY_SEL) {
	ld	hl,#_joy + 0
	ld	h, (hl)
	res	0, h
	ld	l,#0x00
	ld	a,h
	sub	a,#0xFE
	jr	NZ,00158$
	or	a,l
	jr	NZ,00158$
;browser.c:130: resp = osMainMenu();
	call	_osMainMenu
;browser.c:131: if (resp)return resp;
	ld	-28 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00156$
	ld	l,-28 (ix)
	jr	00164$
00156$:
;browser.c:132: full_repaint = 2;
	ld	-26 (ix),#0x02
;browser.c:133: continue;
	jp	00163$
00158$:
;browser.c:138: if ((joy & JOY_STA) == JOY_STA) {
	ld	hl,#_joy + 0
	ld	h, (hl)
	ld	l,#0x00
	inc	h
	jp	NZ,00163$
	ld	a,l
	or	a, a
	jp	NZ,00163$
;browser.c:139: resp = osStartGame();
	call	_osStartGame
;browser.c:140: return resp;
	ld	-28 (ix), l
00164$:
	ld	sp,ix
	pop	ix
	ret
_browser_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
