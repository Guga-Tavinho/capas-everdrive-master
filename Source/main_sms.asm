;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:41 2026
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _in
	.globl _hb
	.globl _vb
	.globl _main
	.globl _browser
	.globl _guiPrintError
	.globl _osUsbListener
	.globl _osInit
	.globl _tmp
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_tmp::
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
;main.c:108: int main() {
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
;main.c:115: resp = osInit();
	push	de
	call	_osInit
	pop	de
	ld	d,l
;main.c:123: if (resp) {
	ld	a,d
	or	a, a
	jr	Z,00107$
;main.c:124: guiPrintError(resp);
	push	de
	push	de
	inc	sp
	call	_guiPrintError
	inc	sp
	pop	de
00105$:
;main.c:125: for (;;)osUsbListener();
	push	de
	call	_osUsbListener
	pop	de
	jr	00105$
00107$:
;main.c:130: resp = browser();
	push	de
	call	_browser
	pop	de
	ld	d,l
;main.c:131: guiPrintError(resp);
	push	de
	push	de
	inc	sp
	call	_guiPrintError
	inc	sp
	pop	de
	jr	00107$
_main_end::
;main.c:137: void vb() {
;	---------------------------------
; Function vb
; ---------------------------------
_vb_start::
_vb:
;main.c:138: }
	ret
_vb_end::
;main.c:140: void hb() {
;	---------------------------------
; Function hb
; ---------------------------------
_hb_start::
_hb:
;main.c:141: }
	ret
_hb_end::
;main.c:143: void in() {
;	---------------------------------
; Function in
; ---------------------------------
_in_start::
_in:
;main.c:144: }
	ret
_in_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
