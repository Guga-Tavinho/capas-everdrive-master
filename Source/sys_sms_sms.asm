;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:50 2026
;--------------------------------------------------------
	.module sys_sms
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sys_joy_read
	.globl _g_vdp_init
	.globl _g_set_vdp_reg
	.globl _g_vram_wr
	.globl _g_set_pal
	.globl _bi_is_gg_cart
	.globl _diskReadToRam
	.globl _str_eq_ncase
	.globl _str_extension
	.globl _str_length
	.globl _sysMemSet
	.globl _gDrawStringMl
	.globl _gAppendNum
	.globl _gAppendHex32
	.globl _gAppendHex16SW
	.globl _gAppendHex8
	.globl _gDrawStringCx
	.globl _gDrawString
	.globl _gRepaint
	.globl _gVsync
	.globl _osReleaseRam
	.globl _osMallocRam
	.globl _osUsbListener
	.globl _fat_cluster_to_sector
	.globl _fat_read
	.globl _fat_open_file
	.globl _fat_get_full_record
	.globl _cover_miss
	.globl _cover_loaded_h
	.globl _cover_loaded_w
	.globl _cover_name
	.globl _gfx_buff
	.globl _g_cons_border
	.globl _g_current_pal
	.globl _g_ptr
	.globl _SYS_BR_ROWS
	.globl _pal_sg
	.globl _pal_gg
	.globl _pal_sms
	.globl _sysInit
	.globl _gSetSGpal
	.globl _sysJoyWait
	.globl _sysJoyRead
	.globl _gSetFont
	.globl _gCleanScreen
	.globl _gFillRect
	.globl _gAppendString
	.globl _gConsPrint
	.globl _gSetXY
	.globl _gMoveXY
	.globl _gAppendChar
	.globl _gCopyActiveToRam
	.globl _gCopyRamToBack
	.globl _guiPrintError
	.globl _guiDrawBrowser
	.globl _guiDrawCover
	.globl _guiMakeCoverName
	.globl _guiFindCover
	.globl _guiLoadCover
	.globl _guiClearCover
	.globl _guiPutCoverMap
	.globl _guiResetCoverCache
	.globl _guiGetCoverMiss
	.globl _guiSetCoverMiss
	.globl _guiDrawMenu
	.globl _guiDrawForm
	.globl _guiHexView
	.globl _guiGetMaxRows
	.globl _sysGetRomRegion
	.globl _gScreenW
	.globl _gScreenH
	.globl _gSetPal
	.globl _gAppendStringMl
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_SYS_BR_ROWS::
	.ds 1
_g_ptr::
	.ds 2
_g_current_pal::
	.ds 2
_g_cons_border::
	.ds 1
_gfx_buff::
	.ds 1792
_cover_name::
	.ds 212
_cover_loaded_w::
	.ds 1
_cover_loaded_h::
	.ds 1
_cover_miss::
	.ds 64
_sysJoyRead_joy_ctr_1_91:
	.ds 1
_guiDrawBrowser_old_selector_1_123:
	.ds 2
_guiDrawCover_old_selector_1_135:
	.ds 2
_guiDrawCover_old_valid_1_135:
	.ds 1
_guiDrawCover_old_found_1_135:
	.ds 1
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
;sys_sms.c:146: void sysInit() {
;	---------------------------------
; Function sysInit
; ---------------------------------
_sysInit_start::
_sysInit:
;sys_sms.c:148: g_current_pal = 0;
	ld	hl,#_g_current_pal + 0
	ld	(hl), #0x00
	ld	hl,#_g_current_pal + 1
	ld	(hl), #0x00
;sys_sms.c:149: g_vdp_init();
	call	_g_vdp_init
;sys_sms.c:152: if (bi_is_gg_cart()) {
	call	_bi_is_gg_cart
	ld	a,l
	or	a, a
	jr	Z,00102$
;sys_sms.c:153: SYS_BR_ROWS = 13;
	ld	hl,#_SYS_BR_ROWS + 0
	ld	(hl), #0x0D
;sys_sms.c:154: g_cons_border = 6;
	ld	hl,#_g_cons_border + 0
	ld	(hl), #0x06
;sys_sms.c:155: g_set_pal(pal_gg, 0, 64);
	ld	de,#_pal_gg
	ld	hl,#0x4000
	push	hl
	push	de
	call	_g_set_pal
	pop	af
	pop	af
	jr	00103$
00102$:
;sys_sms.c:157: g_cons_border = 2;
	ld	hl,#_g_cons_border + 0
	ld	(hl), #0x02
;sys_sms.c:158: SYS_BR_ROWS = 18;
	ld	hl,#_SYS_BR_ROWS + 0
	ld	(hl), #0x12
;sys_sms.c:159: g_set_pal(pal_sms, 0, 32);
	ld	de,#_pal_sms
	ld	hl,#0x2000
	push	hl
	push	de
	call	_g_set_pal
	pop	af
	pop	af
00103$:
;sys_sms.c:162: gCleanScreen();
	call	_gCleanScreen
;sys_sms.c:163: gRepaint();
	call	_gRepaint
;sys_sms.c:165: g_set_vdp_reg(VDP_REG_SPRITE_PAT, 0);
	ld	hl,#0x0006
	push	hl
	call	_g_set_vdp_reg
;sys_sms.c:166: g_set_vdp_reg(VDP_REG_MODE2, VDP_MOD2_BLK);
	ld	hl, #0x4001
	ex	(sp),hl
	call	_g_set_vdp_reg
	pop	af
	ret
_sysInit_end::
_pal_sms:
	.db #0x00	; 0
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x0A	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0A	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_pal_gg:
	.dw #0x0000
	.dw #0x0FFF
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0666
	.dw #0x0000
	.dw #0x00CC
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0666
	.dw #0x0FFF
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x00CC
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
_pal_sg:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x0C	; 12
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x02	; 2
	.db #0x3C	; 60
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x0A	; 10
	.db #0x0F	; 15
	.db #0x08	; 8
	.db #0x33	; 51	'3'
	.db #0x2A	; 42
	.db #0x3F	; 63
;sys_sms.c:170: void gSetSGpal() {
;	---------------------------------
; Function gSetSGpal
; ---------------------------------
_gSetSGpal_start::
_gSetSGpal:
;sys_sms.c:172: g_set_pal(pal_sg, 0, 64);
	ld	de,#_pal_sg
	ld	hl,#0x4000
	push	hl
	push	de
	call	_g_set_pal
	pop	af
	pop	af
	ret
_gSetSGpal_end::
;sys_sms.c:175: void sysJoyWait() {
;	---------------------------------
; Function sysJoyWait
; ---------------------------------
_sysJoyWait_start::
_sysJoyWait:
;sys_sms.c:177: while (sysJoyRead() != 0);
00101$:
	call	_sysJoyRead
	ld	a,h
	or	a,l
	jr	NZ,00101$
;sys_sms.c:178: while (sysJoyRead() == 0);
00104$:
	call	_sysJoyRead
	ld	a,h
	or	a,l
	jr	Z,00104$
	ret
_sysJoyWait_end::
;sys_sms.c:184: u16 sysJoyRead() {
;	---------------------------------
; Function sysJoyRead
; ---------------------------------
_sysJoyRead_start::
_sysJoyRead:
;sys_sms.c:194: osUsbListener();
	call	_osUsbListener
;sys_sms.c:195: if (joy_ctr < JOY_DELAY - 2)gVsync();
	ld	a,(#_sysJoyRead_joy_ctr_1_91 + 0)
	sub	a, #0x0E
	jr	NC,00102$
	call	_gVsync
00102$:
;sys_sms.c:198: joy = sys_joy_read();
	call	_sys_joy_read
	ld	iy,#_joy
	ld	0 (iy),l
	ld	hl,#_joy + 1
	ld	(hl), #0x00
;sys_sms.c:201: if (joy != 0 && (joy & (JOY_L | JOY_R | JOY_U | JOY_D)) != 0) {
	ld	a,(#_joy + 1)
	ld	hl,#_joy + 0
	or	a,(hl)
	jr	Z,00104$
	ld	a,(#_joy + 0)
	and	a, #0x0F
	jr	Z,00104$
;sys_sms.c:202: joy_ctr++;
	ld	hl, #_sysJoyRead_joy_ctr_1_91+0
	inc	(hl)
	jr	00105$
00104$:
;sys_sms.c:204: joy_ctr = 0;
	ld	hl,#_sysJoyRead_joy_ctr_1_91 + 0
	ld	(hl), #0x00
00105$:
;sys_sms.c:206: if (joy_ctr > JOY_DELAY) {
	ld	a,#0x10
	ld	iy,#_sysJoyRead_joy_ctr_1_91
	sub	a, 0 (iy)
	jr	NC,00108$
;sys_sms.c:207: joy_ctr -= 2;
	ld	hl, #_sysJoyRead_joy_ctr_1_91+0
	dec	(hl)
	ld	hl, #_sysJoyRead_joy_ctr_1_91+0
	dec	(hl)
;sys_sms.c:208: joy = 0;
	ld	hl,#_joy + 0
	ld	(hl), #0x00
	ld	hl,#_joy + 1
	ld	(hl), #0x00
00108$:
;sys_sms.c:215: return joy;
	ld	hl,(_joy)
	ret
_sysJoyRead_end::
;sys_sms.c:218: void gSetFont(u8 *ptr) {
;	---------------------------------
; Function gSetFont
; ---------------------------------
_gSetFont_start::
_gSetFont:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-71
	add	hl,sp
	ld	sp,hl
;sys_sms.c:225: g_set_vdp_reg(VDP_REG_MODE2, 0);
	ld	hl,#0x0001
	push	hl
	call	_g_set_vdp_reg
	pop	af
;sys_sms.c:227: for (i = 0; i < 64; i++)buff[i] = 0;
	ld	hl,#0x0002
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	de,#0x0000
00104$:
	ld	l, c
	ld	h, b
	add	hl,de
	ld	(hl),#0x00
	inc	de
	ld	a,e
	sub	a, #0x40
	ld	a,d
	sbc	a, #0x00
	jr	C,00104$
;sys_sms.c:228: g_vram_wr(buff, 0, 64);
	ld	l, c
	ld	h, b
	push	bc
	ld	de,#0x0040
	push	de
	ld	de,#0x0000
	push	de
	push	hl
	call	_g_vram_wr
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	pop	bc
;sys_sms.c:231: ptr2 = ptr;
	ld	l,4 (ix)
	ld	h,5 (ix)
;sys_sms.c:232: for (i = 0; i < 4096; i += 64) {
	ld	-2 (ix),c
	ld	-1 (ix),b
	ld	-71 (ix),#0x00
	ld	-70 (ix),#0x00
;sys_sms.c:233: for (u = 0; u < 64; u += 4) {
00114$:
	ld	e,#0x00
00106$:
;sys_sms.c:234: buff[u] = *ptr2++;
	push	hl
	ld	l,e
	ld	h,#0x00
	push	hl
	pop	iy
	pop	hl
	add	iy, bc
	ld	a,(hl)
	inc	hl
	ld	0 (iy), a
;sys_sms.c:235: buff[u + 3] = 0;
	ld	a,e
	add	a, #0x03
	ld	-5 (ix),a
	push	hl
	ld	l,-5 (ix)
	ld	h,#0x00
	push	hl
	pop	iy
	pop	hl
	add	iy, bc
	ld	0 (iy), #0x00
;sys_sms.c:236: buff[u + 1] = 0;
	ld	d,e
	inc	d
	push	hl
	ld	l,d
	ld	h,#0x00
	push	hl
	pop	iy
	pop	hl
	add	iy, bc
	ld	0 (iy), #0x00
;sys_sms.c:233: for (u = 0; u < 64; u += 4) {
	inc	e
	inc	e
	inc	e
	inc	e
	ld	a,e
	sub	a, #0x40
	jr	C,00106$
;sys_sms.c:238: g_vram_wr(buff, i + 1024, 64);
	ld	iy,#0x0400
	pop	de
	push	de
	add	iy, de
	ld	a,-2 (ix)
	ld	-4 (ix),a
	ld	a,-1 (ix)
	ld	-3 (ix),a
	push	hl
	push	bc
	ld	de,#0x0040
	push	de
	push	iy
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	push	de
	call	_g_vram_wr
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	pop	bc
	pop	hl
;sys_sms.c:232: for (i = 0; i < 4096; i += 64) {
	ld	a,-71 (ix)
	add	a, #0x40
	ld	-71 (ix),a
	ld	a,-70 (ix)
	adc	a, #0x00
	ld	-70 (ix), a
	and	a, #0xF0
	jp	Z,00114$
;sys_sms.c:241: g_set_vdp_reg(VDP_REG_MODE2, VDP_MOD2_BLK);
	ld	hl,#0x4001
	push	hl
	call	_g_set_vdp_reg
	ld	sp,ix
	pop	ix
	ret
_gSetFont_end::
;sys_sms.c:245: void gCleanScreen() {
;	---------------------------------
; Function gCleanScreen
; ---------------------------------
_gCleanScreen_start::
_gCleanScreen:
;sys_sms.c:247: sysMemSet(gfx_buff, 0, G_SCREEN_W * G_SCREEN_H * 2);
	ld	de,#_gfx_buff
	ld	hl,#0x0700
	push	hl
	xor	a, a
	push	af
	inc	sp
	push	de
	call	_sysMemSet
	pop	af
	pop	af
	inc	sp
	ret
_gCleanScreen_end::
;sys_sms.c:250: void gFillRect(u16 data, u8 x, u8 y, u8 w, u8 h) {
;	---------------------------------
; Function gFillRect
; ---------------------------------
_gFillRect_start::
_gFillRect:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;sys_sms.c:257: gSetXY(x, y);
	ld	h,7 (ix)
	ld	l,6 (ix)
	push	hl
	call	_gSetXY
	pop	af
;sys_sms.c:259: for (yy = 0; yy < h; yy++) {
	ld	bc,#_gfx_buff
	ld	e,#0x00
00107$:
	ld	a,e
	sub	a, 9 (ix)
	jr	NC,00109$
;sys_sms.c:260: ptr = (u16 *) & gfx_buff[g_ptr];
	ld	hl,(_g_ptr)
	add	hl, hl
	add	hl,bc
	ld	-2 (ix),l
	ld	-1 (ix),h
;sys_sms.c:261: for (xx = 0; xx < w; xx++) {
	ld	d,#0x00
00104$:
	ld	a,d
	sub	a, 8 (ix)
	jr	NC,00101$
;sys_sms.c:262: *ptr++ = data | g_current_pal;
	ld	a,4 (ix)
	ld	hl,#_g_current_pal + 0
	or	a,(hl)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	hl,#_g_current_pal + 1
	or	a,(hl)
	ld	-3 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,-4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-3 (ix)
	ld	(hl),a
	ld	a,-2 (ix)
	add	a, #0x02
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
;sys_sms.c:261: for (xx = 0; xx < w; xx++) {
	inc	d
	jr	00104$
00101$:
;sys_sms.c:264: g_ptr += G_SCREEN_W;
	ld	hl,#_g_ptr
	ld	a,(hl)
	add	a, #0x20
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, #0x00
	ld	(hl),a
;sys_sms.c:259: for (yy = 0; yy < h; yy++) {
	inc	e
	jr	00107$
00109$:
	ld	sp,ix
	pop	ix
	ret
_gFillRect_end::
;sys_sms.c:268: void gAppendString(u8 *str) {
;	---------------------------------
; Function gAppendString
; ---------------------------------
_gAppendString_start::
_gAppendString:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;sys_sms.c:270: u16 *ptr = (u16 *) & gfx_buff[g_ptr];
	ld	hl,(_g_ptr)
	add	hl, hl
	ld	de,#_gfx_buff
	add	hl,de
	ex	de,hl
;sys_sms.c:273: while (*str != 0) {
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	-3 (ix),#0x00
00101$:
	ld	a,(bc)
	or	a, a
	jr	Z,00103$
;sys_sms.c:274: *ptr++ = *str++ | g_current_pal;
	inc	bc
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	a,-2 (ix)
	ld	hl,#_g_current_pal + 0
	or	a,(hl)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	ld	hl,#_g_current_pal + 1
	or	a,(hl)
	ld	-1 (ix),a
	ld	l, e
	ld	h, d
	ld	a,-2 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-1 (ix)
	ld	(hl),a
	inc	de
	inc	de
;sys_sms.c:275: str_len++;
	inc	-3 (ix)
	jr	00101$
00103$:
;sys_sms.c:277: g_ptr += str_len;
	ld	d,-3 (ix)
	ld	b,#0x00
	ld	hl,#_g_ptr
	ld	a,(hl)
	add	a, d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, b
	ld	(hl),a
	ld	sp,ix
	pop	ix
	ret
_gAppendString_end::
;sys_sms.c:280: void gConsPrint(u8 *str) {
;	---------------------------------
; Function gConsPrint
; ---------------------------------
_gConsPrint_start::
_gConsPrint:
;sys_sms.c:282: g_ptr = g_ptr / G_SCREEN_W * G_SCREEN_W + G_SCREEN_W;
	ld	hl,(_g_ptr)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #0x0020
	add	hl, de
	ld	(_g_ptr),hl
;sys_sms.c:283: g_ptr += g_cons_border;
	ld	hl,#_g_cons_border + 0
	ld	d, (hl)
	ld	e,#0x00
	ld	hl,#_g_ptr
	ld	a,(hl)
	add	a, d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, e
	ld	(hl),a
;sys_sms.c:284: gAppendString(str);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_gAppendString
	pop	af
	ret
_gConsPrint_end::
;sys_sms.c:287: void gSetXY(u8 x, u8 y) {
;	---------------------------------
; Function gSetXY
; ---------------------------------
_gSetXY_start::
_gSetXY:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys_sms.c:289: g_ptr = x + y * G_SCREEN_W;
	ld	d,4 (ix)
	ld	b,#0x00
	ld	l,5 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e,l
	ld	c,h
	ld	a,d
	ld	hl,#_g_ptr
	add	a, e
	ld	(hl),a
	ld	a,b
	adc	a, c
	inc	hl
	ld	(hl),a
	pop	ix
	ret
_gSetXY_end::
;sys_sms.c:292: void gMoveXY(s8 x, s8 y) {
;	---------------------------------
; Function gMoveXY
; ---------------------------------
_gMoveXY_start::
_gMoveXY:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys_sms.c:294: g_ptr += x + y * G_SCREEN_W;
	ld	e,4 (ix)
	ld	a,4 (ix)
	rla
	sbc	a, a
	ld	d,a
	ld	l,5 (ix)
	ld	a,5 (ix)
	rla
	sbc	a, a
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,de
	ex	de,hl
	ld	hl,#_g_ptr
	ld	a,(hl)
	add	a, e
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, d
	ld	(hl),a
	pop	ix
	ret
_gMoveXY_end::
;sys_sms.c:297: void gAppendChar(u8 str) {
;	---------------------------------
; Function gAppendChar
; ---------------------------------
_gAppendChar_start::
_gAppendChar:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys_sms.c:299: gfx_buff[g_ptr++] = str | (g_current_pal << 8);
	ld	de,(_g_ptr)
	ld	hl, #_g_ptr+0
	inc	(hl)
	jr	NZ,00103$
	ld	hl, #_g_ptr+1
	inc	(hl)
00103$:
	ex	de,hl
	add	hl, hl
	ld	de,#_gfx_buff
	add	hl,de
	ld	iy,#_g_current_pal
	ld	d,0 (iy)
	ld	e,#0x00
	ld	c,4 (ix)
	ld	b,#0x00
	ld	a,e
	or	a, c
	ld	e,a
	ld	a,d
	or	a, b
	ld	d,a
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	ix
	ret
_gAppendChar_end::
;sys_sms.c:302: void gCopyActiveToRam(u16 *buff) {
;	---------------------------------
; Function gCopyActiveToRam
; ---------------------------------
_gCopyActiveToRam_start::
_gCopyActiveToRam:
;sys_sms.c:303: buff;
	ret
_gCopyActiveToRam_end::
;sys_sms.c:306: void gCopyRamToBack(u16 *buff) {
;	---------------------------------
; Function gCopyRamToBack
; ---------------------------------
_gCopyRamToBack_start::
_gCopyRamToBack:
;sys_sms.c:307: buff;
	ret
_gCopyRamToBack_end::
;sys_sms.c:310: void guiPrintError(u8 code) {
;	---------------------------------
; Function guiPrintError
; ---------------------------------
_guiPrintError_start::
_guiPrintError:
;sys_sms.c:312: gCleanScreen();
	call	_gCleanScreen
;sys_sms.c:313: gDrawStringCx("ERROR: 0x00", 10);
	ld	de,#__str_0
	ld	a,#0x0A
	push	af
	inc	sp
	push	de
	call	_gDrawStringCx
;sys_sms.c:314: gMoveXY(-2, 0);
	inc	sp
	ld	hl,#0x00FE
	ex	(sp),hl
	call	_gMoveXY
	pop	af
;sys_sms.c:315: gAppendHex8(code);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_gAppendHex8
	inc	sp
;sys_sms.c:316: if (code == FAT_ERR_FAT16) {
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0xFB
	jr	NZ,00102$
;sys_sms.c:317: gDrawStringCx("FAT16 is not supported", 12);
	ld	de,#__str_1
	ld	a,#0x0C
	push	af
	inc	sp
	push	de
	call	_gDrawStringCx
	pop	af
	inc	sp
;sys_sms.c:318: gDrawStringCx("Please use FAT32", 14);
	ld	de,#__str_2
	ld	a,#0x0E
	push	af
	inc	sp
	push	de
	call	_gDrawStringCx
	pop	af
	inc	sp
00102$:
;sys_sms.c:321: gRepaint();
	call	_gRepaint
;sys_sms.c:322: sysJoyWait();
	jp	_sysJoyWait
_guiPrintError_end::
__str_0:
	.ascii "ERROR: 0x00"
	.db 0x00
__str_1:
	.ascii "FAT16 is not supported"
	.db 0x00
__str_2:
	.ascii "Please use FAT32"
	.db 0x00
;sys_sms.c:325: u8 guiDrawBrowser(u8 full_repaint, u16 selector) {
;	---------------------------------
; Function guiDrawBrowser
; ---------------------------------
_guiDrawBrowser_start::
_guiDrawBrowser:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-23
	add	hl,sp
	ld	sp,hl
;sys_sms.c:328: u8 gg_cart = bi_is_gg_cart();
	call	_bi_is_gg_cart
	ld	b,l
;sys_sms.c:330: u16 page = selector / SYS_BR_ROWS * SYS_BR_ROWS;
	ld	hl,#_SYS_BR_ROWS + 0
	ld	e, (hl)
	ld	d,#0x00
	push	bc
	push	de
	push	de
	ld	l,5 (ix)
	ld	h,6 (ix)
	push	hl
	call	__divuint_rrx_s
	pop	af
	ex	(sp),hl
	call	__mulint_rrx_s
	pop	af
	pop	af
	pop	bc
	ld	-18 (ix),l
	ld	-17 (ix),h
;sys_sms.c:333: u8 y = gg_cart ? 3 : 1;
	ld	a,b
	or	a, a
	jr	Z,00137$
	ld	e,#0x03
	jr	00138$
00137$:
	ld	e,#0x01
00138$:
;sys_sms.c:334: u8 x = gg_cart ? 6 : 1;
	ld	a,b
	or	a, a
	jr	Z,00139$
	ld	a,#0x06
	jr	00140$
00139$:
	ld	a,#0x01
00140$:
	ld	-19 (ix),a
;sys_sms.c:335: u8 ful_name_y = y + SYS_BR_ROWS + 3;
	ld	a,e
	ld	hl,#_SYS_BR_ROWS
	add	a, (hl)
	add	a, #0x03
	ld	-20 (ix),a
;sys_sms.c:336: u8 scr_w = gScreenW();
	push	bc
	push	de
	call	_gScreenW
	pop	de
	pop	bc
	ld	d,l
;sys_sms.c:337: u8 max_name_len = gg_cart ? 20 : COVER_X - x - 1;
	ld	a,b
	or	a, a
	jr	Z,00141$
	ld	a,#0x14
	jr	00142$
00141$:
	ld	a,#0x11
	sub	a, -19 (ix)
00142$:
	ld	-22 (ix),a
;sys_sms.c:340: rec = osMallocRam(sizeof (FatFullRecord));
	push	de
	ld	hl,#0x00E5
	push	hl
	call	_osMallocRam
	pop	af
	pop	de
	ld	-14 (ix),l
	ld	-13 (ix),h
;sys_sms.c:343: if (full_repaint) {
	ld	a,4 (ix)
	or	a, a
	jr	Z,00102$
;sys_sms.c:344: gCleanScreen();
	push	de
	call	_gCleanScreen
	pop	de
00102$:
;sys_sms.c:346: if (full_repaint == 2) {
	ld	a,4 (ix)
	sub	a, #0x02
	jr	NZ,00104$
;sys_sms.c:347: guiResetCoverCache();
	push	de
	call	_guiResetCoverCache
	pop	de
00104$:
;sys_sms.c:351: gSetPal(1);
	push	de
	ld	hl,#0x0001
	push	hl
	call	_gSetPal
	pop	af
	pop	de
;sys_sms.c:352: if (full_repaint) {
	ld	a,4 (ix)
	or	a, a
	jr	Z,00106$
;sys_sms.c:353: gFillRect(0, 0, y, scr_w, 1);
	push	de
	ld	a,#0x01
	push	af
	inc	sp
	push	de
	inc	sp
	ld	a,e
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl,#0x0000
	push	hl
	call	_gFillRect
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	pop	de
00106$:
;sys_sms.c:356: gFillRect(0, 0, ful_name_y, scr_w, 2);
	push	de
	ld	a,#0x02
	push	af
	inc	sp
	push	de
	inc	sp
	ld	a,-20 (ix)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl,#0x0000
	push	hl
	call	_gFillRect
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	pop	de
;sys_sms.c:359: gDrawString("Pagina ", x, y);
	ld	bc,#__str_3
	push	de
	ld	a,e
	push	af
	inc	sp
	ld	a,-19 (ix)
	push	af
	inc	sp
	push	bc
	call	_gDrawString
	pop	af
	pop	af
	pop	de
;sys_sms.c:360: gAppendNum(page / SYS_BR_ROWS + 1);
	ld	iy,#_SYS_BR_ROWS
	ld	l,0 (iy)
	ld	h,#0x00
	push	de
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	pop	de
	inc	hl
	ld	bc,#0x0000
	push	de
	push	bc
	push	hl
	call	_gAppendNum
	pop	af
	pop	af
	pop	de
;sys_sms.c:361: gAppendString(" de ");
	ld	hl,#__str_4
	push	de
	push	hl
	call	_gAppendString
	pop	af
	pop	de
;sys_sms.c:362: i = fat_dir_size / SYS_BR_ROWS;
	ld	a,(#_SYS_BR_ROWS + 0)
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	push	de
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	push	hl
	ld	hl,(_fat_dir_size)
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	pop	de
;sys_sms.c:363: if (fat_dir_size % SYS_BR_ROWS != 0)i++;
	push	hl
	push	de
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	push	hl
	ld	hl,(_fat_dir_size)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	pop	de
	pop	bc
	ld	a,h
	or	a,l
	jr	Z,00108$
	inc	bc
00108$:
;sys_sms.c:364: gAppendNum(i);
	ld	hl,#0x0000
	push	de
	push	hl
	push	bc
	call	_gAppendNum
	pop	af
	pop	af
	pop	de
;sys_sms.c:365: gDrawString("Instagram: @tavinho.games", 1, y + 1);
	ld	h,e
	inc	h
	ld	bc,#__str_5
	push	de
	push	hl
	inc	sp
	ld	a,#0x01
	push	af
	inc	sp
	push	bc
	call	_gDrawString
	pop	af
	pop	af
	pop	de
;sys_sms.c:366: y += 2;
	inc	e
	inc	e
;sys_sms.c:368: resp = 0;
	ld	-21 (ix),#0x00
;sys_sms.c:369: if (fat_dir_size == 0) {
	ld	a,(#_fat_dir_size + 1)
	ld	hl,#_fat_dir_size + 0
	or	a,(hl)
	jr	NZ,00110$
;sys_sms.c:370: gSetPal(0);
	push	de
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
	pop	de
;sys_sms.c:371: gDrawStringCx("There are no files", 11);
	ld	bc,#__str_6
	push	de
	ld	a,#0x0B
	push	af
	inc	sp
	push	bc
	call	_gDrawStringCx
	pop	af
	inc	sp
	call	_guiClearCover
	pop	de
00110$:
;sys_sms.c:374: if (full_repaint && fat_dir_size > 4)gRepaint();
	ld	a,4 (ix)
	or	a, a
	jr	Z,00168$
	ld	a,#0x04
	ld	iy,#_fat_dir_size
	cp	a, 0 (iy)
	ld	a,#0x00
	ld	iy,#_fat_dir_size
	sbc	a, 1 (iy)
	jr	NC,00168$
	push	de
	call	_gRepaint
	pop	de
;sys_sms.c:376: for (i = page; i < page + SYS_BR_ROWS && i < fat_dir_size; i++, y++) {
00168$:
	ld	a,-14 (ix)
	add	a, #0xE4
	ld	-7 (ix),a
	ld	a,-13 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
	ld	a,-20 (ix)
	inc	a
	ld	-11 (ix),a
	ld	a,-7 (ix)
	ld	-9 (ix),a
	ld	a,-6 (ix)
	ld	-8 (ix),a
	ld	a,-19 (ix)
	add	a, #0x02
	ld	-12 (ix),a
	ld	a,-18 (ix)
	ld	-16 (ix),a
	ld	a,-17 (ix)
	ld	-15 (ix),a
	ld	-10 (ix),e
00134$:
	ld	iy,#_SYS_BR_ROWS
	ld	l,0 (iy)
	ld	h,#0x00
	ld	e,-18 (ix)
	ld	d,-17 (ix)
	add	hl,de
	ld	a,-16 (ix)
	sub	a, l
	ld	a,-15 (ix)
	sbc	a, h
	jp	NC,00131$
	ld	hl,#_fat_dir_size
	ld	a,-16 (ix)
	sub	a, (hl)
	ld	a,-15 (ix)
	inc	hl
	sbc	a, (hl)
	jp	NC,00131$
;sys_sms.c:378: if (i != selector && i != old_selector && !full_repaint)continue;
	ld	a,5 (ix)
	sub	a, -16 (ix)
	jr	NZ,00216$
	ld	a,6 (ix)
	sub	a, -15 (ix)
	jr	NZ,00216$
	ld	a,#0x01
	jr	00217$
00216$:
	xor	a,a
00217$:
	ld	-1 (ix), a
	or	a, a
	jr	NZ,00115$
	ld	a,(#_guiDrawBrowser_old_selector_1_123 + 0)
	sub	a, -16 (ix)
	jr	NZ,00218$
	ld	a,(#_guiDrawBrowser_old_selector_1_123 + 1)
	sub	a, -15 (ix)
	jr	Z,00115$
00218$:
	ld	a,4 (ix)
	or	a, a
	jp	Z,00130$
00115$:
;sys_sms.c:379: resp = fat_get_full_record(fat_dir[i], rec);
	ld	e,-16 (ix)
	ld	d,-15 (ix)
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a,(#_fat_dir + 0)
	add	a, e
	ld	e,a
	ld	a,(#_fat_dir + 1)
	adc	a, d
	ld	d,a
	ex	de,hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	l,(hl)
	ld	h,a
	ld	c,-14 (ix)
	ld	b,-13 (ix)
	push	bc
	push	hl
	push	de
	call	_fat_get_full_record
	pop	af
	pop	af
	pop	af
;sys_sms.c:380: if (resp)break;
	ld	-21 (ix), l
	ld	a, l
	or	a, a
	jp	NZ,00131$
;sys_sms.c:387: gDrawStringMl(rec->name, x, ful_name_y, max_name_len);
	ld	a,-22 (ix)
	ld	-3 (ix),a
	ld	-2 (ix),#0x00
;sys_sms.c:383: if (selector == i) {
	ld	a,-1 (ix)
	or	a, a
	jp	Z,00123$
;sys_sms.c:385: pal = rec->is_dir ? 4 : 1;
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	or	a, a
	jr	Z,00143$
	ld	-23 (ix),#0x04
	jr	00144$
00143$:
	ld	-23 (ix),#0x01
00144$:
;sys_sms.c:386: gSetPal(pal);
	ld	l,-23 (ix)
	ld	h,#0x00
	push	hl
	call	_gSetPal
	pop	af
;sys_sms.c:387: gDrawStringMl(rec->name, x, ful_name_y, max_name_len);
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	ld	h,-20 (ix)
	ld	l,-19 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_gDrawStringMl
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys_sms.c:389: if (str_length(rec->name) > max_name_len) {
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_str_length
	pop	af
	ld	a,-22 (ix)
	sub	a, l
	jr	NC,00121$
;sys_sms.c:390: gDrawStringMl(&rec->name[max_name_len], x, ful_name_y + 1, max_name_len);
	ld	a,-14 (ix)
	add	a, -22 (ix)
	ld	e,a
	ld	a,-13 (ix)
	adc	a, #0x00
	ld	d,a
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	ld	h,-11 (ix)
	ld	l,-19 (ix)
	push	hl
	push	de
	call	_gDrawStringMl
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
00121$:
;sys_sms.c:392: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
	jr	00124$
00123$:
;sys_sms.c:395: pal = rec->is_dir ? 4 : 2;
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	or	a, a
	jr	Z,00145$
	ld	a,#0x04
	jr	00146$
00145$:
	ld	a,#0x02
00146$:
;sys_sms.c:396: gSetPal(pal);
	ld	-23 (ix), a
	ld	l, a
	ld	h,#0x00
	push	hl
	call	_gSetPal
	pop	af
00124$:
;sys_sms.c:399: gFillRect(0, x, y, max_name_len, 1);
	ld	a,#0x01
	push	af
	inc	sp
	ld	h,-22 (ix)
	ld	l,-10 (ix)
	push	hl
	ld	a,-19 (ix)
	push	af
	inc	sp
	ld	hl,#0x0000
	push	hl
	call	_gFillRect
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys_sms.c:400: if (selector == i) {
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00126$
;sys_sms.c:401: gDrawString(">", x, y);
	ld	de,#__str_7
	ld	h,-10 (ix)
	ld	l,-19 (ix)
	push	hl
	push	de
	call	_gDrawString
	pop	af
	pop	af
;sys_sms.c:402: gDrawStringMl(rec->name, x + 2, y, max_name_len - 2);
	ld	a,-22 (ix)
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	dec	hl
	dec	hl
	ld	-5 (ix),l
	ld	-4 (ix),h
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	push	hl
	ld	h,-10 (ix)
	ld	l,-12 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_gDrawStringMl
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	jr	00127$
00126$:
;sys_sms.c:404: gDrawStringMl(rec->name, x, y, max_name_len);
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	ld	h,-10 (ix)
	ld	l,-19 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_gDrawStringMl
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
00127$:
;sys_sms.c:406: if (selector == i)guiDrawCover(rec, selector, full_repaint);
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00130$
	ld	a,4 (ix)
	push	af
	inc	sp
	ld	l,5 (ix)
	ld	h,6 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_guiDrawCover
	pop	af
	pop	af
	inc	sp
00130$:
;sys_sms.c:376: for (i = page; i < page + SYS_BR_ROWS && i < fat_dir_size; i++, y++) {
	inc	-16 (ix)
	jr	NZ,00221$
	inc	-15 (ix)
00221$:
	inc	-10 (ix)
	jp	00134$
00131$:
;sys_sms.c:412: osReleaseRam(sizeof (FatFullRecord));
	ld	hl,#0x00E5
	push	hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:413: old_selector = selector;
	ld	l,5 (ix)
	ld	h,6 (ix)
	ld	(_guiDrawBrowser_old_selector_1_123),hl
;sys_sms.c:414: gRepaint();
	call	_gRepaint
;sys_sms.c:416: return resp;
	ld	l,-21 (ix)
	ld	sp,ix
	pop	ix
	ret
_guiDrawBrowser_end::
__str_3:
	.ascii "Pagina "
	.db 0x00
__str_4:
	.ascii " de "
	.db 0x00
__str_5:
	.ascii "Instagram: @tavinho.games"
	.db 0x00
__str_6:
	.ascii "There are no files"
	.db 0x00
__str_7:
	.ascii ">"
	.db 0x00
;sys_sms.c:419: void guiDrawCover(FatFullRecord *rec, u16 selector, u8 full_repaint) {
;	---------------------------------
; Function guiDrawCover
; ---------------------------------
_guiDrawCover_start::
_guiDrawCover:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-5
	add	hl,sp
	ld	sp,hl
;sys_sms.c:426: if (bi_is_gg_cart())return;
	call	_bi_is_gg_cart
	ld	a, l
	or	a, a
	jp	NZ,00122$
;sys_sms.c:427: if (str_extension(".cov", rec->name)) {
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
	ld	hl,#__str_8
	ld	c,-2 (ix)
	ld	b,-1 (ix)
	push	bc
	push	hl
	call	_str_extension
	pop	af
	pop	af
;sys_sms.c:429: old_selector = selector;
	ld	a,6 (ix)
	ld	-4 (ix),a
	ld	a,7 (ix)
	ld	-3 (ix),a
;sys_sms.c:427: if (str_extension(".cov", rec->name)) {
	ld	a,l
	or	a, a
	jr	Z,00104$
;sys_sms.c:428: guiClearCover();
	call	_guiClearCover
;sys_sms.c:429: old_selector = selector;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(_guiDrawCover_old_selector_1_135),hl
;sys_sms.c:430: old_found = 0;
	ld	hl,#_guiDrawCover_old_found_1_135 + 0
	ld	(hl), #0x00
;sys_sms.c:431: return;
	jp	00122$
00104$:
;sys_sms.c:433: if (rec->is_dir) {
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	de, #0x00E4
	add	hl, de
	ld	a,(hl)
	or	a, a
	jr	Z,00106$
;sys_sms.c:434: guiClearCover();
	call	_guiClearCover
;sys_sms.c:435: old_selector = selector;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(_guiDrawCover_old_selector_1_135),hl
;sys_sms.c:436: old_found = 0;
	ld	hl,#_guiDrawCover_old_found_1_135 + 0
	ld	(hl), #0x00
;sys_sms.c:437: return;
	jp	00122$
00106$:
;sys_sms.c:439: if (fat_cov_dir_size == 0) {
	ld	a,(#_fat_cov_dir_size + 1)
	ld	hl,#_fat_cov_dir_size + 0
	or	a,(hl)
	jr	NZ,00108$
;sys_sms.c:440: guiClearCover();
	call	_guiClearCover
;sys_sms.c:441: old_selector = selector;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(_guiDrawCover_old_selector_1_135),hl
;sys_sms.c:442: old_found = 0;
	ld	hl,#_guiDrawCover_old_found_1_135 + 0
	ld	(hl), #0x00
;sys_sms.c:443: old_valid = 1;
	ld	hl,#_guiDrawCover_old_valid_1_135 + 0
	ld	(hl), #0x01
;sys_sms.c:444: return;
	jp	00122$
00108$:
;sys_sms.c:446: if (guiGetCoverMiss(selector)) {
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_guiGetCoverMiss
	pop	af
	ld	a,l
	or	a, a
	jr	Z,00110$
;sys_sms.c:447: guiClearCover();
	call	_guiClearCover
;sys_sms.c:448: old_selector = selector;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(_guiDrawCover_old_selector_1_135),hl
;sys_sms.c:449: old_found = 0;
	ld	hl,#_guiDrawCover_old_found_1_135 + 0
	ld	(hl), #0x00
;sys_sms.c:450: old_valid = 1;
	ld	hl,#_guiDrawCover_old_valid_1_135 + 0
	ld	(hl), #0x01
;sys_sms.c:451: return;
	jp	00122$
00110$:
;sys_sms.c:453: if (old_valid && !full_repaint && selector == old_selector) {
	ld	a,(#_guiDrawCover_old_valid_1_135 + 0)
	or	a, a
	jr	Z,00114$
	ld	a,8 (ix)
	or	a, a
	jr	NZ,00114$
	ld	a,6 (ix)
	ld	iy,#_guiDrawCover_old_selector_1_135
	sub	a, 0 (iy)
	jr	NZ,00114$
	ld	a,7 (ix)
	ld	iy,#_guiDrawCover_old_selector_1_135
	sub	a, 1 (iy)
	jr	NZ,00114$
;sys_sms.c:454: if (old_found)guiPutCoverMap();
	ld	a,(#_guiDrawCover_old_found_1_135 + 0)
	or	a, a
	jr	Z,00122$
	call	_guiPutCoverMap
;sys_sms.c:455: return;
	jr	00122$
00114$:
;sys_sms.c:458: guiClearCover();
	call	_guiClearCover
;sys_sms.c:459: old_selector = selector;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(_guiDrawCover_old_selector_1_135),hl
;sys_sms.c:460: old_valid = 1;
	ld	hl,#_guiDrawCover_old_valid_1_135 + 0
	ld	(hl), #0x01
;sys_sms.c:461: old_found = 0;
	ld	hl,#_guiDrawCover_old_found_1_135 + 0
	ld	(hl), #0x00
;sys_sms.c:463: guiMakeCoverName(rec->name, cover_name);
	ld	hl,#_cover_name
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_guiMakeCoverName
	pop	af
	pop	af
;sys_sms.c:464: resp = guiFindCover(cover_name, rec);
	ld	hl,#_cover_name
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	push	hl
	call	_guiFindCover
	pop	af
	pop	af
;sys_sms.c:465: if (!resp) {
	ld	-5 (ix), l
	ld	a, l
	or	a, a
	jr	NZ,00120$
;sys_sms.c:466: resp = guiLoadCover(rec);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_guiLoadCover
	pop	af
;sys_sms.c:467: if (!resp) {
	ld	-5 (ix), l
	ld	a, l
	or	a, a
	jr	NZ,00122$
;sys_sms.c:468: old_found = 1;
	ld	hl,#_guiDrawCover_old_found_1_135 + 0
	ld	(hl), #0x01
;sys_sms.c:469: guiPutCoverMap();
	call	_guiPutCoverMap
	jr	00122$
00120$:
;sys_sms.c:472: guiSetCoverMiss(selector);
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_guiSetCoverMiss
	pop	af
00122$:
	ld	sp,ix
	pop	ix
	ret
_guiDrawCover_end::
__str_8:
	.ascii ".cov"
	.db 0x00
;sys_sms.c:476: void guiMakeCoverName(u8 *src, u8 *dst) {
;	---------------------------------
; Function guiMakeCoverName
; ---------------------------------
_guiMakeCoverName_start::
_guiMakeCoverName:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;sys_sms.c:478: u8 *dot = 0;
	ld	-4 (ix),#0x00
	ld	-3 (ix),#0x00
;sys_sms.c:481: ptr = dst;
	ld	a,6 (ix)
	ld	-6 (ix),a
	ld	a,7 (ix)
	ld	-5 (ix),a
;sys_sms.c:482: while (*src != 0) {
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
00103$:
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	d,(hl)
	ld	a,d
	or	a, a
	jr	Z,00105$
;sys_sms.c:483: if (*src == (u8) '.')dot = ptr;
	ld	a,d
	sub	a, #0x2E
	jr	NZ,00102$
	ld	a,-6 (ix)
	ld	-4 (ix),a
	ld	a,-5 (ix)
	ld	-3 (ix),a
00102$:
;sys_sms.c:484: *ptr++ = *src++;
	inc	-2 (ix)
	jr	NZ,00125$
	inc	-1 (ix)
00125$:
	pop	hl
	push	hl
	ld	(hl),d
	inc	-6 (ix)
	jr	NZ,00103$
	inc	-5 (ix)
	jr	00103$
00105$:
;sys_sms.c:487: if (dot == 0)dot = ptr;
	ld	a,-3 (ix)
	or	a,-4 (ix)
	jr	NZ,00107$
	ld	a,-6 (ix)
	ld	-4 (ix),a
	ld	a,-5 (ix)
	ld	-3 (ix),a
00107$:
;sys_sms.c:488: *dot++ = '.';
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),#0x2E
	inc	-4 (ix)
	jr	NZ,00127$
	inc	-3 (ix)
00127$:
;sys_sms.c:489: *dot++ = 'c';
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),#0x63
	inc	-4 (ix)
	jr	NZ,00128$
	inc	-3 (ix)
00128$:
;sys_sms.c:490: *dot++ = 'o';
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),#0x6F
	inc	-4 (ix)
	jr	NZ,00129$
	inc	-3 (ix)
00129$:
;sys_sms.c:491: *dot++ = 'v';
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),#0x76
	inc	-4 (ix)
	jr	NZ,00130$
	inc	-3 (ix)
00130$:
;sys_sms.c:492: *dot = 0;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),#0x00
	ld	sp,ix
	pop	ix
	ret
_guiMakeCoverName_end::
;sys_sms.c:495: u8 guiFindCover(u8 *name, FatFullRecord *rec) {
;	---------------------------------
; Function guiFindCover
; ---------------------------------
_guiFindCover_start::
_guiFindCover:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;sys_sms.c:500: for (i = 0; i < fat_cov_dir_size; i++) {
	ld	bc,#0x0000
00107$:
	ld	hl,#_fat_cov_dir_size
	ld	a,c
	sub	a, (hl)
	ld	a,b
	inc	hl
	sbc	a, (hl)
	jr	NC,00105$
;sys_sms.c:501: resp = fat_get_full_record(fat_cov_dir[i], rec);
	ld	e, c
	ld	d, b
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a,(#_fat_cov_dir + 0)
	add	a, e
	ld	e,a
	ld	iy,#_fat_cov_dir
	ld	a,1 (iy)
	adc	a, d
	ld	d,a
	push	bc
	ld	hl, #0x0002
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_fat_get_full_record
	pop	af
	pop	af
	pop	af
	pop	bc
;sys_sms.c:502: if (resp)return resp;
	ld	a,l
	or	a, a
	jr	NZ,00109$
;sys_sms.c:503: if (str_eq_ncase(name, rec->name))return 0;
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	bc
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_str_eq_ncase
	pop	af
	pop	af
	ld	a,l
	pop	bc
	or	a, a
	jr	Z,00108$
	ld	l,#0x00
	jr	00109$
00108$:
;sys_sms.c:500: for (i = 0; i < fat_cov_dir_size; i++) {
	inc	bc
	jr	00107$
00105$:
;sys_sms.c:506: return 1;
	ld	l,#0x01
00109$:
	ld	sp,ix
	pop	ix
	ret
_guiFindCover_end::
;sys_sms.c:509: u8 guiLoadCover(FatFullRecord *rec) {
;	---------------------------------
; Function guiLoadCover
; ---------------------------------
_guiLoadCover_start::
_guiLoadCover:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-18
	add	hl,sp
	ld	sp,hl
;sys_sms.c:520: buff = osMallocRam(512);
	ld	hl,#0x0200
	push	hl
	call	_osMallocRam
	pop	af
	ld	-11 (ix),l
	ld	-10 (ix),h
;sys_sms.c:521: resp = fat_open_file(rec, 0);
	ld	hl,#0x0000
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_open_file
	pop	af
	pop	af
;sys_sms.c:522: if (resp) {
	ld	-14 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
;sys_sms.c:523: osReleaseRam(512);
	ld	hl,#0x0200
	push	hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:524: return resp;
	ld	l,-14 (ix)
	jp	00141$
00102$:
;sys_sms.c:526: if (file.sec_available == 0) {
	ld	hl, #(_file + 0x000c) + 0
	ld	a,(hl)
	ld	-3 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-2 (ix), a
	or	a,-3 (ix)
	jr	NZ,00104$
;sys_sms.c:527: osReleaseRam(512);
	ld	hl,#0x0200
	push	hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:528: return 1;
	ld	l,#0x01
	jp	00141$
00104$:
;sys_sms.c:531: resp = fat_read(buff, 1, RAM);
	ld	a,#0x01
	push	af
	inc	sp
	ld	hl,#0x0001
	push	hl
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	_fat_read
	pop	af
	pop	af
	inc	sp
;sys_sms.c:532: if (resp) {
	ld	-14 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00106$
;sys_sms.c:533: osReleaseRam(512);
	ld	hl,#0x0200
	push	hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:534: return resp;
	ld	l,-14 (ix)
	jp	00141$
00106$:
;sys_sms.c:537: if (buff[0] != COVER_MAGIC_0)resp = 1;
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	sub	a, #0x43
	jr	Z,00108$
	ld	-14 (ix),#0x01
00108$:
;sys_sms.c:538: if (buff[1] != COVER_MAGIC_1)resp = 1;
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	inc	hl
	ld	a,(hl)
	sub	a, #0x4F
	jr	Z,00110$
	ld	-14 (ix),#0x01
00110$:
;sys_sms.c:539: if (buff[2] != COVER_MAGIC_2)resp = 1;
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	inc	hl
	inc	hl
	ld	a,(hl)
	sub	a, #0x56
	jr	Z,00112$
	ld	-14 (ix),#0x01
00112$:
;sys_sms.c:540: if (buff[3] != COVER_MAGIC_3)resp = 1;
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	sub	a, #0x31
	jr	Z,00114$
	ld	-14 (ix),#0x01
00114$:
;sys_sms.c:541: if (buff[4] == 0 || buff[4] > COVER_MAX_W)resp = 1;
	ld	c,-11 (ix)
	ld	b,-10 (ix)
	push	bc
	pop	iy
	ld	a,4 (iy)
	ld	-3 (ix), a
	or	a, a
	jr	Z,00115$
	ld	a,#0x0E
	sub	a, -3 (ix)
	jr	NC,00116$
00115$:
	ld	-14 (ix),#0x01
00116$:
;sys_sms.c:542: if (buff[5] == 0 || buff[5] > COVER_MAX_H)resp = 1;
	ld	iy,#0x0005
	ld	e,-11 (ix)
	ld	d,-10 (ix)
	add	iy, de
	ld	a, 0 (iy)
	ld	-1 (ix), a
	or	a, a
	jr	Z,00118$
	ld	a,#0x12
	sub	a, -1 (ix)
	jr	NC,00119$
00118$:
	ld	-14 (ix),#0x01
00119$:
;sys_sms.c:543: if (resp) {
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00122$
;sys_sms.c:544: osReleaseRam(512);
	ld	hl,#0x0200
	push	hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:545: return resp;
	ld	l,-14 (ix)
	jp	00141$
00122$:
;sys_sms.c:548: cover_loaded_w = buff[4];
	ld	a,-3 (ix)
	ld	(#_cover_loaded_w + 0),a
;sys_sms.c:549: cover_loaded_h = buff[5];
	ld	a,-1 (ix)
	ld	(#_cover_loaded_h + 0),a
;sys_sms.c:550: tile_bytes = (u16) cover_loaded_w * cover_loaded_h * 32;
	ld	hl,#_cover_loaded_w + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	iy,#_cover_loaded_h
	ld	l,0 (iy)
	ld	h,#0x00
	push	hl
	push	de
	call	__mulint_rrx_s
	pop	af
	pop	af
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	(sp), hl
;sys_sms.c:551: bytes_left = tile_bytes;
	ld	a,-18 (ix)
	ld	-13 (ix),a
	ld	a,-17 (ix)
	ld	-12 (ix),a
;sys_sms.c:555: g_set_vdp_reg(VDP_REG_MODE2, 0);
	ld	hl,#0x0001
	push	hl
	call	_g_set_vdp_reg
	pop	af
;sys_sms.c:557: chunk = 512 - src;
	ld	-9 (ix),#0xF0
	ld	-8 (ix),#0x01
;sys_sms.c:558: if (chunk > bytes_left)chunk = bytes_left;
	ld	a,-13 (ix)
	sub	a, #0xF0
	ld	a,-12 (ix)
	sbc	a, #0x01
	jr	NC,00124$
	ld	a,-13 (ix)
	ld	-9 (ix),a
	ld	a,-12 (ix)
	ld	-8 (ix),a
00124$:
;sys_sms.c:559: g_vram_wr(&buff[src], dst, chunk);
	ld	a,-11 (ix)
	add	a, #0x10
	ld	l,a
	ld	a,-10 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,-9 (ix)
	ld	b,-8 (ix)
	push	bc
	ld	bc,#0x1400
	push	bc
	push	hl
	call	_g_vram_wr
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys_sms.c:560: bytes_left -= chunk;
	ld	a,-13 (ix)
	sub	a, -9 (ix)
	ld	-13 (ix),a
	ld	a,-12 (ix)
	sbc	a, -8 (ix)
	ld	-12 (ix),a
;sys_sms.c:561: dst += chunk;
	ld	a,-9 (ix)
	add	a, #0x00
	ld	-16 (ix),a
	ld	a,-8 (ix)
	adc	a, #0x14
	ld	-15 (ix),a
;sys_sms.c:563: while (bytes_left) {
00129$:
	ld	a,-12 (ix)
	or	a,-13 (ix)
	jp	Z,00131$
;sys_sms.c:564: if (file.sec_available == 0) {
	ld	hl, (#(_file + 0x000c) + 0)
	ld	a,h
	or	a,l
	jr	NZ,00126$
;sys_sms.c:565: g_set_vdp_reg(VDP_REG_MODE2, VDP_MOD2_BLK);
	ld	hl,#0x4001
	push	hl
	call	_g_set_vdp_reg
;sys_sms.c:566: osReleaseRam(512);
	ld	hl, #0x0200
	ex	(sp),hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:567: return 1;
	ld	l,#0x01
	jp	00141$
00126$:
;sys_sms.c:569: resp = fat_read(buff, 1, RAM);
	ld	a,#0x01
	push	af
	inc	sp
	ld	hl,#0x0001
	push	hl
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	_fat_read
	pop	af
	pop	af
	inc	sp
;sys_sms.c:570: if (resp) {
	ld	-14 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00128$
;sys_sms.c:571: g_set_vdp_reg(VDP_REG_MODE2, VDP_MOD2_BLK);
	ld	hl,#0x4001
	push	hl
	call	_g_set_vdp_reg
;sys_sms.c:572: osReleaseRam(512);
	ld	hl, #0x0200
	ex	(sp),hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:573: return resp;
	ld	l,-14 (ix)
	jp	00141$
00128$:
;sys_sms.c:575: chunk = bytes_left > 512 ? 512 : bytes_left;
	xor	a, a
	cp	a, -13 (ix)
	ld	a,#0x02
	sbc	a, -12 (ix)
	jr	NC,00143$
	ld	-3 (ix),#0x00
	ld	-2 (ix),#0x02
	jr	00144$
00143$:
	ld	a,-13 (ix)
	ld	-3 (ix),a
	ld	a,-12 (ix)
	ld	-2 (ix),a
00144$:
	ld	a,-3 (ix)
	ld	-9 (ix),a
	ld	a,-2 (ix)
	ld	-8 (ix),a
;sys_sms.c:576: g_vram_wr(buff, dst, chunk);
	ld	a,-11 (ix)
	ld	-3 (ix),a
	ld	a,-10 (ix)
	ld	-2 (ix),a
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	call	_g_vram_wr
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys_sms.c:577: bytes_left -= chunk;
	ld	a,-13 (ix)
	sub	a, -9 (ix)
	ld	-13 (ix),a
	ld	a,-12 (ix)
	sbc	a, -8 (ix)
	ld	-12 (ix),a
;sys_sms.c:578: dst += chunk;
	ld	a,-16 (ix)
	add	a, -9 (ix)
	ld	-16 (ix),a
	ld	a,-15 (ix)
	adc	a, -8 (ix)
	ld	-15 (ix),a
	jp	00129$
00131$:
;sys_sms.c:581: if (rec->size >= (u32) COVER_HDR_SIZE + tile_bytes + COVER_PAL_SIZE) {
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	de, #0x00E0
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,-18 (ix)
	ld	-7 (ix),a
	ld	a,-17 (ix)
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
	ld	-4 (ix),#0x00
	ld	a,-7 (ix)
	add	a, #0x20
	ld	-7 (ix),a
	ld	a,-6 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-5 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x00
	ld	-4 (ix),a
	ld	a,e
	sub	a, -7 (ix)
	ld	a,d
	sbc	a, -6 (ix)
	ld	a,c
	sbc	a, -5 (ix)
	ld	a,b
	sbc	a, -4 (ix)
	jr	C,00139$
;sys_sms.c:582: pal_pos = (COVER_HDR_SIZE + tile_bytes) & 511;
	ld	a,-18 (ix)
	add	a, #0x10
	ld	e,a
	ld	a,-17 (ix)
	adc	a, #0x00
	and	a, #0x01
;sys_sms.c:583: if (pal_pos == 0) {
	ld	d,a
	or	a,e
	jr	NZ,00137$
;sys_sms.c:584: if (file.sec_available == 0) {
	ld	hl, (#(_file + 0x000c) + 0)
	ld	a,h
	or	a,l
	jr	NZ,00133$
;sys_sms.c:585: g_set_vdp_reg(VDP_REG_MODE2, VDP_MOD2_BLK);
	ld	hl,#0x4001
	push	hl
	call	_g_set_vdp_reg
;sys_sms.c:586: osReleaseRam(512);
	ld	hl, #0x0200
	ex	(sp),hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:587: return 1;
	ld	l,#0x01
	jr	00141$
00133$:
;sys_sms.c:589: resp = fat_read(buff, 1, RAM);
	push	de
	ld	a,#0x01
	push	af
	inc	sp
	ld	hl,#0x0001
	push	hl
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	_fat_read
	pop	af
	pop	af
	inc	sp
	pop	de
;sys_sms.c:590: if (resp) {
	ld	-14 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00137$
;sys_sms.c:591: g_set_vdp_reg(VDP_REG_MODE2, VDP_MOD2_BLK);
	ld	hl,#0x4001
	push	hl
	call	_g_set_vdp_reg
;sys_sms.c:592: osReleaseRam(512);
	ld	hl, #0x0200
	ex	(sp),hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:593: return resp;
	ld	l,-14 (ix)
	jr	00141$
00137$:
;sys_sms.c:596: g_set_pal(&buff[pal_pos], 0, COVER_PAL_SIZE);
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	add	hl,de
	ex	de,hl
	ld	hl,#0x1000
	push	hl
	push	de
	call	_g_set_pal
	pop	af
	pop	af
	jr	00140$
00139$:
;sys_sms.c:598: g_set_pal(pal_sms, 0, COVER_PAL_SIZE);
	ld	de,#_pal_sms
	ld	hl,#0x1000
	push	hl
	push	de
	call	_g_set_pal
	pop	af
	pop	af
00140$:
;sys_sms.c:601: g_set_vdp_reg(VDP_REG_MODE2, VDP_MOD2_BLK);
	ld	hl,#0x4001
	push	hl
	call	_g_set_vdp_reg
;sys_sms.c:602: osReleaseRam(512);
	ld	hl, #0x0200
	ex	(sp),hl
	call	_osReleaseRam
	pop	af
;sys_sms.c:603: return 0;
	ld	l,#0x00
00141$:
	ld	sp,ix
	pop	ix
	ret
_guiLoadCover_end::
;sys_sms.c:606: void guiClearCover() {
;	---------------------------------
; Function guiClearCover
; ---------------------------------
_guiClearCover_start::
_guiClearCover:
;sys_sms.c:608: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
;sys_sms.c:609: gFillRect(0, COVER_X, COVER_Y, COVER_MAX_W, COVER_MAX_H);
	ld	hl, #0x120E
	ex	(sp),hl
	ld	hl,#0x0312
	push	hl
	ld	hl,#0x0000
	push	hl
	call	_gFillRect
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;sys_sms.c:610: cover_loaded_w = 0;
	ld	hl,#_cover_loaded_w + 0
	ld	(hl), #0x00
;sys_sms.c:611: cover_loaded_h = 0;
	ld	hl,#_cover_loaded_h + 0
	ld	(hl), #0x00
	ret
_guiClearCover_end::
;sys_sms.c:614: void guiPutCoverMap() {
;	---------------------------------
; Function guiPutCoverMap
; ---------------------------------
_guiPutCoverMap_start::
_guiPutCoverMap:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-5
	add	hl,sp
	ld	sp,hl
;sys_sms.c:621: if (cover_loaded_w == 0 || cover_loaded_h == 0)return;
	ld	a,(#_cover_loaded_w + 0)
	or	a, a
	jp	Z,00112$
	ld	a,(#_cover_loaded_h + 0)
	or	a, a
	jp	Z,00112$
;sys_sms.c:623: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
;sys_sms.c:624: tile = COVER_TILE_BASE;
	ld	bc,#0x00A0
;sys_sms.c:625: for (y = 0; y < cover_loaded_h; y++) {
	ld	-5 (ix),#0x00
00110$:
	ld	hl,#_cover_loaded_h
	ld	a,-5 (ix)
	sub	a, (hl)
	jr	NC,00112$
;sys_sms.c:626: gSetXY(COVER_X, COVER_Y + y);
	ld	a,-5 (ix)
	add	a, #0x03
	push	bc
	ld	d,a
	ld	e,#0x12
	push	de
	call	_gSetXY
	pop	af
	pop	bc
;sys_sms.c:627: ptr = (u16 *) & gfx_buff[g_ptr];
	ld	hl,(_g_ptr)
	add	hl, hl
	ld	de,#_gfx_buff
	add	hl,de
	ld	-4 (ix),l
	ld	-3 (ix),h
;sys_sms.c:628: for (x = 0; x < cover_loaded_w; x++) {
	ld	-2 (ix),c
	ld	-1 (ix),b
	ld	d,#0x00
00107$:
	ld	hl,#_cover_loaded_w
	ld	a,d
	sub	a, (hl)
	jr	NC,00119$
;sys_sms.c:629: *ptr++ = tile++ | g_current_pal;
	ld	e,-2 (ix)
	ld	b,-1 (ix)
	inc	-2 (ix)
	jr	NZ,00131$
	inc	-1 (ix)
00131$:
	ld	a,e
	ld	hl,#_g_current_pal + 0
	or	a,(hl)
	ld	e,a
	ld	a,b
	ld	hl,#_g_current_pal + 1
	or	a,(hl)
	ld	b,a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),b
	ld	a,-4 (ix)
	add	a, #0x02
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
;sys_sms.c:628: for (x = 0; x < cover_loaded_w; x++) {
	inc	d
	jr	00107$
00119$:
	ld	c,-2 (ix)
	ld	b,-1 (ix)
;sys_sms.c:625: for (y = 0; y < cover_loaded_h; y++) {
	inc	-5 (ix)
	jr	00110$
00112$:
	ld	sp,ix
	pop	ix
	ret
_guiPutCoverMap_end::
;sys_sms.c:634: void guiResetCoverCache() {
;	---------------------------------
; Function guiResetCoverCache
; ---------------------------------
_guiResetCoverCache_start::
_guiResetCoverCache:
;sys_sms.c:636: sysMemSet(cover_miss, 0, (OS_MAX_DIR_SIZE + 7) / 8);
	ld	de,#_cover_miss
	ld	hl,#0x0040
	push	hl
	xor	a, a
	push	af
	inc	sp
	push	de
	call	_sysMemSet
	pop	af
	pop	af
	inc	sp
	ret
_guiResetCoverCache_end::
;sys_sms.c:639: u8 guiGetCoverMiss(u16 selector) {
;	---------------------------------
; Function guiGetCoverMiss
; ---------------------------------
_guiGetCoverMiss_start::
_guiGetCoverMiss:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys_sms.c:641: if (selector >= OS_MAX_DIR_SIZE)return 0;
	ld	a,5 (ix)
	and	a, #0xFE
	jr	Z,00102$
	ld	l,#0x00
	jr	00103$
00102$:
;sys_sms.c:642: return cover_miss[selector >> 3] & (1 << (selector & 7));
	ld	hl,#_cover_miss
	ld	e,4 (ix)
	ld	d,5 (ix)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	add	hl,de
	ld	e,(hl)
	ld	a,4 (ix)
	and	a, #0x07
	ld	b, a
	push	af
	ld	hl,#0x0001
	pop	af
	inc	b
	jr	00110$
00109$:
	add	hl, hl
00110$:
	djnz	00109$
	ld	a,l
	and	a, e
	ld	l,a
00103$:
	pop	ix
	ret
_guiGetCoverMiss_end::
;sys_sms.c:645: void guiSetCoverMiss(u16 selector) {
;	---------------------------------
; Function guiSetCoverMiss
; ---------------------------------
_guiSetCoverMiss_start::
_guiSetCoverMiss:
	push	ix
	ld	ix,#0
	add	ix,sp
;sys_sms.c:647: if (selector >= OS_MAX_DIR_SIZE)return;
	ld	a,5 (ix)
	and	a, #0xFE
	jr	NZ,00103$
;sys_sms.c:648: cover_miss[selector >> 3] |= 1 << (selector & 7);
	ld	l,4 (ix)
	ld	h,5 (ix)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	de,#_cover_miss
	add	hl,de
	ld	e,(hl)
	ld	a,4 (ix)
	and	a, #0x07
	ld	b,a
	push	af
	ld	c,#0x01
	ld	d,#0x00
	pop	af
	inc	b
	jr	00110$
00109$:
	sla	c
	rl	d
00110$:
	djnz	00109$
	ld	a,c
	or	a, e
	ld	(hl),a
00103$:
	pop	ix
	ret
_guiSetCoverMiss_end::
;sys_sms.c:651: u8 guiDrawMenu(u8 *str[], u16 def_select) {
;	---------------------------------
; Function guiDrawMenu
; ---------------------------------
_guiDrawMenu_start::
_guiDrawMenu:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-21
	add	hl,sp
	ld	sp,hl
;sys_sms.c:658: u16 selector = def_select;
	ld	a,6 (ix)
	ld	-17 (ix),a
	ld	a,7 (ix)
	ld	-16 (ix),a
;sys_sms.c:661: while (str[items] != 0)items++;
	ld	bc,#0x0000
00101$:
	ld	l, c
	ld	h, b
	add	hl, hl
	ld	e,4 (ix)
	ld	d,5 (ix)
	add	hl,de
	ld	d,(hl)
	inc	hl
	ld	a, (hl)
	or	a,d
	jr	Z,00103$
	inc	bc
	jr	00101$
00103$:
;sys_sms.c:662: items--;
	ld	a,c
	add	a,#0xFF
	ld	-19 (ix),a
	ld	a,b
	adc	a,#0xFF
	ld	-18 (ix),a
;sys_sms.c:664: w = 0;
	ld	-15 (ix),#0x00
	ld	-14 (ix),#0x00
;sys_sms.c:665: for (i = 0; i < items + 1; i++) {
	ld	a,-19 (ix)
	add	a, #0x01
	ld	-6 (ix),a
	ld	a,-18 (ix)
	adc	a, #0x00
	ld	-5 (ix),a
	ld	-13 (ix),#0x00
	ld	-12 (ix),#0x00
00121$:
	ld	a,-13 (ix)
	sub	a, -6 (ix)
	ld	a,-12 (ix)
	sbc	a, -5 (ix)
	jr	NC,00106$
;sys_sms.c:667: h = str_length(str[i]);
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	add	hl, hl
	ld	e,4 (ix)
	ld	d,5 (ix)
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	call	_str_length
	pop	af
	ld	-21 (ix),l
	ld	-20 (ix),#0x00
;sys_sms.c:668: if (h > w)w = h;
	ld	a,-15 (ix)
	sub	a, -21 (ix)
	ld	a,-14 (ix)
	sbc	a, -20 (ix)
	jr	NC,00122$
	ld	a,-21 (ix)
	ld	-15 (ix),a
	ld	a,-20 (ix)
	ld	-14 (ix),a
00122$:
;sys_sms.c:665: for (i = 0; i < items + 1; i++) {
	inc	-13 (ix)
	jr	NZ,00121$
	inc	-12 (ix)
	jr	00121$
00106$:
;sys_sms.c:671: h = items * 2 + 1;
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	inc	hl
	ex	(sp), hl
;sys_sms.c:672: x = (gScreenW() - w) / 2;
	call	_gScreenW
	ld	h,#0x00
	ld	a,l
	sub	a, -15 (ix)
	ld	e,a
	ld	a,h
	sbc	a, -14 (ix)
	ld	d,a
	srl	d
	rr	e
;sys_sms.c:673: y = (gScreenH() - h) / 2 - 1;
	push	de
	call	_gScreenH
	pop	de
	ld	h,#0x00
	ld	a,l
	sub	a, -21 (ix)
	ld	l,a
	ld	a,h
	sbc	a, -20 (ix)
	ld	h,a
	srl	h
	rr	l
	dec	hl
;sys_sms.c:675: guiDrawForm(x, y, w, h);
	push	hl
	ld	c,-21 (ix)
	ld	b,-20 (ix)
	push	bc
	ld	c,-15 (ix)
	ld	b,-14 (ix)
	push	bc
	push	hl
	push	de
	call	_guiDrawForm
	ld	hl,#0x0008
	add	hl,sp
	ld	sp,hl
	ld	bc,#0x0003
	push	bc
	call	_gSetPal
	pop	af
	pop	hl
;sys_sms.c:679: gDrawStringCx(str[0], y - 1);
	ld	-6 (ix), l
	ld	d, l
	dec	d
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	de
	inc	sp
	push	bc
	call	_gDrawStringCx
	pop	af
	inc	sp
	ld	a,-19 (ix)
	add	a,#0xFF
	ld	-2 (ix),a
	ld	a,-18 (ix)
	adc	a,#0xFF
	ld	-1 (ix),a
00126$:
;sys_sms.c:683: for (i = 0; i < items; i++) {
	ld	-13 (ix),#0x00
	ld	-12 (ix),#0x00
00124$:
	ld	a,-13 (ix)
	sub	a, -19 (ix)
	ld	a,-12 (ix)
	sbc	a, -18 (ix)
	jp	NC,00110$
;sys_sms.c:685: if (selector == i) {
	ld	a,-17 (ix)
	sub	a, -13 (ix)
	jr	NZ,00108$
	ld	a,-16 (ix)
	sub	a, -12 (ix)
	jr	NZ,00108$
;sys_sms.c:686: gSetPal(2);
	ld	hl,#0x0002
	push	hl
	call	_gSetPal
	pop	af
	jr	00109$
00108$:
;sys_sms.c:688: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
00109$:
;sys_sms.c:690: gDrawStringCx(str[i + 1], i * 2 + 2 + y);
	ld	a,-13 (ix)
	add	a, a
	ld	h,a
	inc	h
	inc	h
	ld	a,h
	add	a, -6 (ix)
	ld	-7 (ix),a
	ld	a,-13 (ix)
	add	a, #0x01
	ld	-9 (ix),a
	ld	a,-12 (ix)
	adc	a, #0x00
	ld	-8 (ix),a
	ld	a,-9 (ix)
	ld	-11 (ix),a
	ld	a,-8 (ix)
	ld	-10 (ix),a
	sla	-11 (ix)
	rl	-10 (ix)
	ld	a,-4 (ix)
	add	a, -11 (ix)
	ld	-11 (ix),a
	ld	a,-3 (ix)
	adc	a, -10 (ix)
	ld	-10 (ix),a
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	ld	-11 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-10 (ix),a
	ld	a,-7 (ix)
	push	af
	inc	sp
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	_gDrawStringCx
	pop	af
	inc	sp
;sys_sms.c:683: for (i = 0; i < items; i++) {
	ld	h,-9 (ix)
	ld	l,-8 (ix)
	ld	-13 (ix),h
	ld	-12 (ix),l
	jp	00124$
00110$:
;sys_sms.c:693: gRepaint();
	call	_gRepaint
;sys_sms.c:695: sysJoyWait();
	call	_sysJoyWait
;sys_sms.c:697: if (joy & JOY_U) {
	ld	hl,#_joy+0
	bit	0, (hl)
	jr	Z,00112$
;sys_sms.c:698: selector = selector == 0 ? items - 1 : selector - 1;
	ld	a,-16 (ix)
	or	a, -17 (ix)
	sub	a,#0x01
	ld	a,#0x00
	rla
	or	a, a
	jr	Z,00130$
	ld	a,-2 (ix)
	ld	-11 (ix),a
	ld	a,-1 (ix)
	ld	-10 (ix),a
	jr	00131$
00130$:
	ld	a,-17 (ix)
	add	a,#0xFF
	ld	-11 (ix),a
	ld	a,-16 (ix)
	adc	a,#0xFF
	ld	-10 (ix),a
00131$:
	ld	a,-11 (ix)
	ld	-17 (ix),a
	ld	a,-10 (ix)
	ld	-16 (ix),a
00112$:
;sys_sms.c:701: if (joy & JOY_D) {
	ld	hl,#_joy+0
	bit	1, (hl)
	jr	Z,00114$
;sys_sms.c:702: selector = selector == items - 1 ? 0 : selector + 1;
	ld	a,-2 (ix)
	sub	a, -17 (ix)
	jr	NZ,00132$
	ld	a,-1 (ix)
	sub	a, -16 (ix)
	jr	NZ,00132$
	ld	-11 (ix),#0x00
	ld	-10 (ix),#0x00
	jr	00133$
00132$:
	ld	a,-17 (ix)
	add	a, #0x01
	ld	-11 (ix),a
	ld	a,-16 (ix)
	adc	a, #0x00
	ld	-10 (ix),a
00133$:
	ld	a,-11 (ix)
	ld	-17 (ix),a
	ld	a,-10 (ix)
	ld	-16 (ix),a
00114$:
;sys_sms.c:705: if ((joy & JOY_A)) {
	ld	hl,#_joy+0
	bit	5, (hl)
	jr	Z,00116$
;sys_sms.c:706: return 0xff;
	ld	l,#0xFF
	jr	00128$
00116$:
;sys_sms.c:709: if ((joy & JOY_B)) {
	ld	hl,#_joy+0
	bit	4, (hl)
	jp	Z,00126$
;sys_sms.c:710: return selector;
	ld	l,-17 (ix)
00128$:
	ld	sp,ix
	pop	ix
	ret
_guiDrawMenu_end::
;sys_sms.c:717: void guiDrawForm(u16 x, u16 y, u16 w, u16 h) {
;	---------------------------------
; Function guiDrawForm
; ---------------------------------
_guiDrawForm_start::
_guiDrawForm:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;sys_sms.c:719: gSetPal(1);
	ld	hl,#0x0001
	push	hl
	call	_gSetPal
	pop	af
;sys_sms.c:720: gFillRect(2, x - 1, y - 1, w + 2, h + 2);
	ld	a,10 (ix)
	add	a, #0x02
	ld	-1 (ix),a
	ld	b,8 (ix)
	inc	b
	inc	b
	ld	e,6 (ix)
	ld	c,e
	dec	c
	ld	d, 4 (ix)
	dec	d
	push	bc
	push	de
	ld	a,-1 (ix)
	push	af
	inc	sp
	push	bc
	push	de
	inc	sp
	ld	hl,#0x0002
	push	hl
	call	_gFillRect
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	pop	de
	pop	bc
;sys_sms.c:723: gFillRect('-', x - 1, y, w + 2, 1);
	ld	a,#0x01
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a,e
	push	af
	inc	sp
	push	de
	inc	sp
	ld	hl,#0x002D
	push	hl
	call	_gFillRect
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	inc	sp
	pop	ix
	ret
_guiDrawForm_end::
;sys_sms.c:727: u8 guiHexView(FatFullRecord *rec) {
;	---------------------------------
; Function guiHexView
; ---------------------------------
_guiHexView_start::
_guiHexView:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-583
	add	hl,sp
	ld	sp,hl
;sys_sms.c:733: u32 ptr = 0;
	xor	a, a
	ld	iy,#8
	add	iy,sp
	ld	0 (iy),a
	ld	1 (iy),a
	ld	2 (iy),a
	ld	3 (iy),a
;sys_sms.c:741: u32 old_sec = 0;
	xor	a, a
	ld	-53 (ix),a
	ld	-52 (ix),a
	ld	-51 (ix),a
	ld	-50 (ix),a
;sys_sms.c:742: u16 repaint = 1;
	ld	bc,#0x0001
;sys_sms.c:744: u16 timer = 0;
	ld	hl,#0x0000
	ex	(sp), hl
;sys_sms.c:748: gCleanScreen();
	push	bc
	call	_gCleanScreen
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
	pop	bc
;sys_sms.c:753: sector = fat_cluster_to_sector(rec->data_clsut);
	ld	a,4 (ix)
	ld	-14 (ix),a
	ld	a,5 (ix)
	ld	-13 (ix),a
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	ld	de, #0x00DC
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
	push	bc
	push	hl
	push	de
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	pop	bc
	ld	iy,#12
	add	iy,sp
	ld	0 (iy),l
	ld	1 (iy),h
	ld	2 (iy),e
	ld	3 (iy),d
;sys_sms.c:754: size = rec->size;
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	ld	de, #0x00E0
	add	hl, de
	ld	a,(hl)
	ld	iy,#4
	add	iy,sp
	ld	0 (iy),a
	inc	hl
	ld	a,(hl)
	ld	1 (iy),a
	inc	hl
	ld	a,(hl)
	ld	2 (iy),a
	inc	hl
	ld	a,(hl)
	ld	3 (iy),a
;sys_sms.c:755: str_buff[32] = 0;
	ld	hl,#0x0216
	add	hl,sp
	ld	-14 (ix),l
	ld	-13 (ix),h
	ld	a,-14 (ix)
	add	a, #0x20
	ld	e,a
	ld	a,-13 (ix)
	adc	a, #0x00
	ld	d,a
	xor	a, a
	ld	(de),a
;sys_sms.c:757: if (size % 512 != 0)size = size / 512 * 512 + 512;
	ld	a,0 (iy)
	or	a, a
	jr	NZ,00227$
	ld	a,1 (iy)
	rrca
	jr	NC,00169$
00227$:
	push	af
	ld	iy,#6
	add	iy,sp
	ld	l,0 (iy)
	ld	h,1 (iy)
	ld	e,2 (iy)
	ld	d,3 (iy)
	pop	af
	ld	a,#0x09
00228$:
	srl	d
	rr	e
	rr	h
	rr	l
	dec	a
	jr	NZ,00228$
	push	af
	ld	-8 (ix),l
	ld	-7 (ix),h
	ld	-6 (ix),e
	ld	-5 (ix),d
	pop	af
	ld	a,#0x09
00230$:
	sla	-8 (ix)
	rl	-7 (ix)
	rl	-6 (ix)
	rl	-5 (ix)
	dec	a
	jr	NZ,00230$
	ld	a,-8 (ix)
	ld	hl,#4
	add	hl,sp
	add	a, #0x00
	ld	(hl),a
	ld	a,-7 (ix)
	adc	a, #0x02
	inc	hl
	ld	(hl),a
	ld	a,-6 (ix)
	adc	a, #0x00
	inc	hl
	ld	(hl),a
	ld	a,-5 (ix)
	adc	a, #0x00
	inc	hl
	ld	(hl),a
00169$:
	ld	hl,#0x0010
	add	hl,sp
	ld	-8 (ix),l
	ld	-7 (ix),h
	ld	a,-14 (ix)
	ld	-16 (ix),a
	ld	a,-13 (ix)
	ld	-15 (ix),a
	ld	iy,#4
	add	iy,sp
	ld	a,0 (iy)
	add	a,#0x00
	ld	-12 (ix),a
	ld	a,1 (iy)
	adc	a,#0xFF
	ld	-11 (ix),a
	ld	a,2 (iy)
	adc	a,#0xFF
	ld	-10 (ix),a
	ld	a,3 (iy)
	adc	a,#0xFF
	ld	-9 (ix),a
00139$:
;sys_sms.c:761: if (old_sec != sector + ptr / 512) {
	push	af
	ld	iy,#10
	add	iy,sp
	ld	a,0 (iy)
	ld	-4 (ix),a
	ld	a,1 (iy)
	ld	-3 (ix),a
	ld	a,2 (iy)
	ld	-2 (ix),a
	ld	a,3 (iy)
	ld	-1 (ix),a
	pop	af
	ld	a,#0x09
00232$:
	srl	-1 (ix)
	rr	-2 (ix)
	rr	-3 (ix)
	rr	-4 (ix)
	dec	a
	jr	NZ,00232$
	ld	iy,#12
	add	iy,sp
	ld	a,0 (iy)
	add	a, -4 (ix)
	ld	-4 (ix),a
	ld	a,1 (iy)
	adc	a, -3 (ix)
	ld	-3 (ix),a
	ld	a,2 (iy)
	adc	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,3 (iy)
	adc	a, -1 (ix)
	ld	-1 (ix),a
	ld	a,-53 (ix)
	sub	a, -4 (ix)
	jr	NZ,00234$
	ld	a,-52 (ix)
	sub	a, -3 (ix)
	jr	NZ,00234$
	ld	a,-51 (ix)
	sub	a, -2 (ix)
	jr	NZ,00234$
	ld	a,-50 (ix)
	sub	a, -1 (ix)
	jr	Z,00106$
00234$:
;sys_sms.c:762: old_sec = sector + ptr / 512;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	ld	-53 (ix),l
	ld	-52 (ix),h
	ld	-51 (ix),e
	ld	-50 (ix),d
;sys_sms.c:763: resp = diskReadToRam(old_sec, buff, 1);
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	bc
	ld	de,#0x0001
	push	de
	push	hl
	ld	l,-51 (ix)
	ld	h,-50 (ix)
	push	hl
	ld	l,-53 (ix)
	ld	h,-52 (ix)
	push	hl
	call	_diskReadToRam
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
;sys_sms.c:765: if (resp)return resp;
	ld	a, #0x00
	or	a,l
	jp	NZ,00141$
00106$:
;sys_sms.c:769: if (repaint) {
	ld	a,b
	or	a,c
	jp	Z,00114$
;sys_sms.c:771: gSetPal(4);
	ld	hl,#0x0004
	push	hl
	call	_gSetPal
	pop	af
;sys_sms.c:772: gDrawString("Offset: ", x, y - 1);
	ld	de,#__str_9
	ld	hl,#0x0100
	push	hl
	push	de
	call	_gDrawString
	pop	af
	pop	af
;sys_sms.c:773: gAppendHex32(ptr);
	ld	iy,#8
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	call	_gAppendHex32
	pop	af
	pop	af
;sys_sms.c:775: ptr16 = (u16*) & buff[ptr % 512];
	ld	iy,#8
	add	iy,sp
	ld	d,0 (iy)
	ld	a,1 (iy)
	and	a, #0x01
	ld	e,a
	ld	a,-8 (ix)
	add	a, d
	ld	-4 (ix),a
	ld	a,-7 (ix)
	adc	a, e
	ld	-3 (ix),a
	ld	c,-4 (ix)
	ld	b,-3 (ix)
;sys_sms.c:776: for (i = 0; i < 16; i++) {
	ld	de,#0x0000
00133$:
;sys_sms.c:782: gSetXY(x, y + i);
	ld	h,e
	inc	h
	inc	h
	push	bc
	push	de
	push	hl
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gSetXY
	pop	af
	pop	de
	pop	bc
;sys_sms.c:783: for (u = 0; u < 4; u++) {
	ld	hl, #2
	add	hl, sp
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
00131$:
;sys_sms.c:784: gSetPal(2);
	push	bc
	push	de
	ld	hl,#0x0002
	push	hl
	call	_gSetPal
	pop	af
	pop	de
	pop	bc
;sys_sms.c:785: gAppendHex16SW(*ptr16++);
	ld	l, c
	ld	h, b
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	inc	bc
	inc	bc
	push	bc
	push	de
	push	hl
	call	_gAppendHex16SW
	ld	hl, #0x0000
	ex	(sp),hl
	call	_gSetPal
	pop	af
	pop	de
	pop	bc
;sys_sms.c:787: gAppendHex16SW(*ptr16++);
	ld	l, c
	ld	h, b
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	inc	bc
	inc	bc
	push	bc
	push	de
	push	hl
	call	_gAppendHex16SW
	pop	af
	pop	de
	pop	bc
;sys_sms.c:783: for (u = 0; u < 4; u++) {
	ld	iy,#2
	add	iy,sp
	inc	0 (iy)
	jr	NZ,00235$
	inc	1 (iy)
00235$:
	ld	a,0 (iy)
	sub	a, #0x04
	ld	a,1 (iy)
	sbc	a, #0x00
	jr	C,00131$
;sys_sms.c:776: for (i = 0; i < 16; i++) {
	inc	de
	ld	a,e
	sub	a, #0x10
	ld	a,d
	sbc	a, #0x00
	jr	C,00133$
;sys_sms.c:793: gSetPal(0);
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
;sys_sms.c:794: gDrawString("--------------------------------", x, y + 16);
	ld	de,#__str_10
	ld	hl,#0x1200
	push	hl
	push	de
	call	_gDrawString
	pop	af
	pop	af
;sys_sms.c:796: ptr8 = (u8*) & buff[ptr % 512];
	ld	c,-4 (ix)
	ld	b,-3 (ix)
;sys_sms.c:797: for (i = 0; i < 8; i++) {
	ld	-55 (ix),#0x00
	ld	-54 (ix),#0x00
00137$:
;sys_sms.c:799: gSetPal(0);
	push	bc
	ld	hl,#0x0000
	push	hl
	call	_gSetPal
	pop	af
	pop	bc
;sys_sms.c:800: for (u = 0; u < 32; u++) {
	ld	hl, #2
	add	hl, sp
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	ld	-4 (ix),c
	ld	-3 (ix),b
00135$:
;sys_sms.c:801: str_buff[u] = *ptr8++;
	ld	a,-14 (ix)
	ld	hl,#2
	add	hl,sp
	add	a, (hl)
	ld	e,a
	ld	a,-13 (ix)
	inc	hl
	adc	a, (hl)
	ld	d,a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	inc	-4 (ix)
	jr	NZ,00236$
	inc	-3 (ix)
00236$:
	ld	(de),a
;sys_sms.c:802: if (str_buff[u] == 0)str_buff[u] = ' ';
	or	a, a
	jr	NZ,00136$
	ld	a,#0x20
	ld	(de),a
00136$:
;sys_sms.c:800: for (u = 0; u < 32; u++) {
	ld	iy,#2
	add	iy,sp
	inc	0 (iy)
	jr	NZ,00237$
	inc	1 (iy)
00237$:
	ld	a,0 (iy)
	sub	a, #0x20
	ld	a,1 (iy)
	sbc	a, #0x00
	jr	C,00135$
;sys_sms.c:805: gDrawString(str_buff, x, y + i + 17);
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	ld	a, -55 (ix)
	add	a, #0x02
	add	a, #0x11
	ld	h,a
	ld	e,-16 (ix)
	ld	d,-15 (ix)
	push	bc
	push	hl
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	de
	call	_gDrawString
	pop	af
	pop	af
	pop	bc
;sys_sms.c:797: for (i = 0; i < 8; i++) {
	inc	-55 (ix)
	jr	NZ,00238$
	inc	-54 (ix)
00238$:
	ld	a,-55 (ix)
	sub	a, #0x08
	ld	a,-54 (ix)
	sbc	a, #0x00
	jp	C,00137$
;sys_sms.c:809: repaint = 0;
	ld	bc,#0x0000
00114$:
;sys_sms.c:815: gRepaint();
	push	bc
	call	_gRepaint
	call	_sysJoyRead
	pop	bc
;sys_sms.c:818: while (joy != 0 && timer < 40) {
	pop	de
	push	de
00116$:
	ld	a,(#_joy + 1)
	ld	hl,#_joy + 0
	or	a,(hl)
	jr	Z,00174$
	ld	a,e
	sub	a, #0x28
	ld	a,d
	sbc	a, #0x00
	jr	NC,00174$
;sys_sms.c:819: timer++;
	inc	de
;sys_sms.c:820: sysJoyRead();
	push	bc
	push	de
	call	_sysJoyRead
	pop	de
	pop	bc
	jr	00116$
;sys_sms.c:822: while (joy == 0) {
00174$:
	inc	sp
	inc	sp
	push	de
00119$:
	ld	a,(#_joy + 1)
	ld	iy,#_joy
	or	a,0 (iy)
	jr	NZ,00121$
;sys_sms.c:823: timer = 0;
	ld	hl,#0x0000
	ex	(sp), hl
;sys_sms.c:824: sysJoyRead();
	push	bc
	call	_sysJoyRead
	pop	bc
	jr	00119$
00121$:
;sys_sms.c:827: if (timer >= 20)timer -= 3;
	ld	iy,#0
	add	iy,sp
	ld	a,0 (iy)
	sub	a, #0x14
	ld	a,1 (iy)
	sbc	a, #0x00
	jr	C,00123$
	ld	hl,#0
	add	hl,sp
	ld	a,(hl)
	add	a,#0xFD
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a,#0xFF
	ld	(hl),a
00123$:
;sys_sms.c:829: if ((joy & JOY_A))return 0;
	ld	hl,#_joy+0
	bit	5, (hl)
	jr	Z,00125$
	ld	l,#0x00
	jp	00141$
00125$:
;sys_sms.c:831: if ((joy & JOY_U)) {
	ld	hl,#_joy+0
	bit	0, (hl)
	jr	Z,00127$
;sys_sms.c:832: ptr = ptr == 0 ? size - 256 : ptr - 256;
	ld	iy,#8
	add	iy,sp
	ld	a,3 (iy)
	or	a, 2 (iy)
	or	a, 1 (iy)
	or	a, 0 (iy)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	or	a, a
	jr	Z,00143$
	ld	hl, #579
	add	hl, sp
	ex	de, hl
	ld	hl, #571
	add	hl, sp
	ld	bc, #4
	ldir
	jr	00144$
00143$:
	ld	iy,#8
	add	iy,sp
	ld	a,0 (iy)
	add	a,#0x00
	ld	-4 (ix),a
	ld	a,1 (iy)
	adc	a,#0xFF
	ld	-3 (ix),a
	ld	a,2 (iy)
	adc	a,#0xFF
	ld	-2 (ix),a
	ld	a,3 (iy)
	adc	a,#0xFF
	ld	-1 (ix),a
00144$:
	ld	hl, #8
	add	hl, sp
	ex	de, hl
	ld	hl, #579
	add	hl, sp
	ld	bc, #4
	ldir
;sys_sms.c:833: repaint = 1;
	ld	bc,#0x0001
00127$:
;sys_sms.c:836: if ((joy & JOY_D)) {
	ld	hl,#_joy+0
	bit	1, (hl)
	jp	Z,00139$
;sys_sms.c:837: ptr = ptr + 256 >= size ? 0 : ptr + 256;
	ld	iy,#8
	add	iy,sp
	ld	a,0 (iy)
	add	a, #0x00
	ld	c,a
	ld	a,1 (iy)
	adc	a, #0x01
	ld	b,a
	ld	a,2 (iy)
	adc	a, #0x00
	ld	e,a
	ld	a,3 (iy)
	adc	a, #0x00
	ld	d,a
	ld	hl,#4
	add	hl,sp
	ld	a,c
	sub	a, (hl)
	ld	a,b
	inc	hl
	sbc	a, (hl)
	ld	a,e
	inc	hl
	sbc	a, (hl)
	ld	a,d
	inc	hl
	sbc	a, (hl)
	ld	a,#0x00
	rla
	ld	-4 (ix), a
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	-4 (ix), a
	or	a, a
	jr	Z,00145$
	ld	bc,#0x0000
	ld	de,#0x0000
00145$:
	ld	iy,#8
	add	iy,sp
	ld	0 (iy),c
	ld	1 (iy),b
	ld	2 (iy),e
	ld	3 (iy),d
;sys_sms.c:838: repaint = 1;
	ld	bc,#0x0001
	jp	00139$
00141$:
	ld	sp,ix
	pop	ix
	ret
_guiHexView_end::
__str_9:
	.ascii "Offset: "
	.db 0x00
__str_10:
	.ascii "--------------------------------"
	.db 0x00
;sys_sms.c:847: u8 guiGetMaxRows() {
;	---------------------------------
; Function guiGetMaxRows
; ---------------------------------
_guiGetMaxRows_start::
_guiGetMaxRows:
;sys_sms.c:848: return SYS_BR_ROWS;
	ld	iy,#_SYS_BR_ROWS
	ld	l,0 (iy)
	ret
_guiGetMaxRows_end::
;sys_sms.c:851: u8 sysGetRomRegion(u8 *rom_hdr) {
;	---------------------------------
; Function sysGetRomRegion
; ---------------------------------
_sysGetRomRegion_start::
_sysGetRomRegion:
;sys_sms.c:853: return 0;
	ld	l,#0x00
	ret
_sysGetRomRegion_end::
;sys_sms.c:856: u8 gScreenW() {
;	---------------------------------
; Function gScreenW
; ---------------------------------
_gScreenW_start::
_gScreenW:
;sys_sms.c:857: return G_SCREEN_W;
	ld	l,#0x20
	ret
_gScreenW_end::
;sys_sms.c:860: u8 gScreenH() {
;	---------------------------------
; Function gScreenH
; ---------------------------------
_gScreenH_start::
_gScreenH:
;sys_sms.c:861: return G_SCREEN_H;
	ld	l,#0x1C
	ret
_gScreenH_end::
;sys_sms.c:864: void gSetPal(u16 pal) {
;	---------------------------------
; Function gSetPal
; ---------------------------------
_gSetPal_start::
_gSetPal:
;sys_sms.c:866: if (pal == 2 || pal == 4) {
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	sub	a, #0x02
	jr	NZ,00110$
	ld	a,1 (iy)
	or	a, a
	jr	Z,00101$
00110$:
	ld	a,0 (iy)
	sub	a, #0x04
	jr	NZ,00102$
	ld	a,1 (iy)
	or	a, a
	jr	NZ,00102$
00101$:
;sys_sms.c:867: g_current_pal = 1 << 11;
	ld	hl,#_g_current_pal + 0
	ld	(hl), #0x00
	ld	hl,#_g_current_pal + 1
	ld	(hl), #0x08
	ret
00102$:
;sys_sms.c:869: g_current_pal = 0;
	ld	hl,#_g_current_pal + 0
	ld	(hl), #0x00
	ld	hl,#_g_current_pal + 1
	ld	(hl), #0x00
	ret
_gSetPal_end::
;sys_sms.c:874: void gAppendStringMl(u8 *str, u16 len) {
;	---------------------------------
; Function gAppendStringMl
; ---------------------------------
_gAppendStringMl_start::
_gAppendStringMl:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;sys_sms.c:877: u16 *ptr = (u16 *) & gfx_buff[g_ptr];
	ld	hl,(_g_ptr)
	add	hl, hl
	ld	de,#_gfx_buff
	add	hl,de
	ld	c, l
	ld	b, h
;sys_sms.c:880: while (*str != 0 && len != 0) {
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	-6 (ix),#0x00
	ld	a,6 (ix)
	ld	-5 (ix),a
	ld	a,7 (ix)
	ld	-4 (ix),a
00102$:
	ld	a,(de)
	ld	-3 (ix), a
	or	a, a
	jr	Z,00104$
	ld	a,-4 (ix)
	or	a,-5 (ix)
	jr	Z,00104$
;sys_sms.c:881: *ptr++ = *str++ | g_current_pal;
	ld	a,-3 (ix)
	inc	de
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	a,-2 (ix)
	ld	hl,#_g_current_pal + 0
	or	a,(hl)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	ld	hl,#_g_current_pal + 1
	or	a,(hl)
	ld	-1 (ix),a
	ld	l, c
	ld	h, b
	ld	a,-2 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-1 (ix)
	ld	(hl),a
	inc	bc
	inc	bc
;sys_sms.c:882: str_len++;
	inc	-6 (ix)
;sys_sms.c:883: len--;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	dec	hl
	ld	-5 (ix),l
	ld	-4 (ix),h
	jr	00102$
00104$:
;sys_sms.c:885: g_ptr += str_len;
	ld	d,-6 (ix)
	ld	e,#0x00
	ld	hl,#_g_ptr
	ld	a,(hl)
	add	a, d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, e
	ld	(hl),a
	ld	sp,ix
	pop	ix
	ret
_gAppendStringMl_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
