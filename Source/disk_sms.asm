;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:36 2026
;--------------------------------------------------------
	.module disk
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _diskOpenWrite
	.globl _diskCmd
	.globl _diskCrc7
	.globl _bi_ram_to_spi
	.globl _bi_spi_speed_on
	.globl _bi_ss_off
	.globl _bi_ss_on
	.globl _bi_spi_to_rom
	.globl _bi_spi_to_ram
	.globl _bi_spi_qq
	.globl _bi_spi_q
	.globl _bi_spi
	.globl _disk_init_ok
	.globl _disk_addr
	.globl _diskCmdFast
	.globl _diskInit
	.globl _diskOpenRead
	.globl _diskReadToRam
	.globl _diskReadToRom
	.globl _diskCloseRW
	.globl _diskWrite
	.globl _diskStop
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_disk_addr::
	.ds 4
_disk_init_ok::
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
;disk.c:37: u8 diskCrc7(u8 *buff) {
;	---------------------------------
; Function diskCrc7
; ---------------------------------
_diskCrc7_start::
_diskCrc7:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;disk.c:40: u16 crc = 0;
	ld	-7 (ix),#0x00
	ld	-6 (ix),#0x00
;disk.c:43: while (len--) {
	ld	a,4 (ix)
	ld	-3 (ix),a
	ld	a,5 (ix)
	ld	-2 (ix),a
	ld	-10 (ix),#0x05
00106$:
	ld	a,-10 (ix)
	ld	-1 (ix),a
	dec	-10 (ix)
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00108$
;disk.c:44: crc ^= *buff++;
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,(hl)
	ld	-1 (ix),a
	inc	-3 (ix)
	jr	NZ,00128$
	inc	-2 (ix)
00128$:
	ld	a,-1 (ix)
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
	ld	a,-7 (ix)
	xor	a, -5 (ix)
	ld	-7 (ix),a
	ld	a,-6 (ix)
	xor	a, -4 (ix)
	ld	-6 (ix),a
;disk.c:46: do {
	ld	-9 (ix),#0x08
	ld	-8 (ix),#0x00
00103$:
;disk.c:47: crc <<= 1;
	sla	-7 (ix)
	rl	-6 (ix)
;disk.c:48: if (crc & (1 << 8)) crc ^= 0x12;
	bit	0, -6 (ix)
	jr	Z,00104$
	ld	a,-7 (ix)
	xor	a, #0x12
	ld	-7 (ix),a
00104$:
;disk.c:49: } while (--a);
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	dec	hl
	ld	-9 (ix),l
	ld	-8 (ix), h
	ld	a, h
	or	a,-9 (ix)
	jr	NZ,00103$
	jr	00106$
00108$:
;disk.c:51: return (crc & 0xfe);
	ld	l,-7 (ix)
	res	0, l
	ld	sp,ix
	pop	ix
	ret
_diskCrc7_end::
;disk.c:54: u8 diskCmd(u8 cmd, u32 arg) {
;	---------------------------------
; Function diskCmd
; ---------------------------------
_diskCmd_start::
_diskCmd:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-20
	add	hl,sp
	ld	sp,hl
;disk.c:61: buff[0] = cmd;
	ld	hl,#0x0000
	add	hl,sp
	ex	de,hl
	ld	a,4 (ix)
	ld	(de),a
;disk.c:62: buff[1] = (arg >> 24) & 0xff;
	ld	l, e
	ld	h, d
	inc	hl
	push	af
	ld	a,5 (ix)
	ld	-4 (ix),a
	ld	a,6 (ix)
	ld	-3 (ix),a
	ld	a,7 (ix)
	ld	-2 (ix),a
	ld	a,8 (ix)
	ld	-1 (ix),a
	pop	af
	ld	b,#0x18
00115$:
	srl	-1 (ix)
	rr	-2 (ix)
	rr	-3 (ix)
	rr	-4 (ix)
	djnz	00115$
	ld	a,-4 (ix)
	ld	-8 (ix),a
	ld	-7 (ix),#0x00
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x00
	ld	a,-8 (ix)
	ld	(hl),a
;disk.c:63: buff[2] = (arg >> 16) & 0xff;
	push	de
	pop	iy
	inc	iy
	inc	iy
	push	af
	ld	a,5 (ix)
	ld	-8 (ix),a
	ld	a,6 (ix)
	ld	-7 (ix),a
	ld	a,7 (ix)
	ld	-6 (ix),a
	ld	a,8 (ix)
	ld	-5 (ix),a
	pop	af
	ld	b,#0x10
00117$:
	srl	-5 (ix)
	rr	-6 (ix)
	rr	-7 (ix)
	rr	-8 (ix)
	djnz	00117$
	ld	l,-8 (ix)
	ld	0 (iy), l
;disk.c:64: buff[3] = (arg >> 8) & 0xff;
	ld	hl,#0x0003
	add	hl,de
	ld	-14 (ix),l
	ld	-13 (ix),h
	push	af
	ld	a,5 (ix)
	ld	-12 (ix),a
	ld	a,6 (ix)
	ld	-11 (ix),a
	ld	a,7 (ix)
	ld	-10 (ix),a
	ld	a,8 (ix)
	ld	-9 (ix),a
	pop	af
	ld	b,#0x08
00119$:
	srl	-9 (ix)
	rr	-10 (ix)
	rr	-11 (ix)
	rr	-12 (ix)
	djnz	00119$
	ld	b,-12 (ix)
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	ld	(hl),b
;disk.c:65: buff[4] = (arg >> 0) & 0xff;
	ld	iy,#0x0004
	add	iy, de
	push	af
	ld	l,5 (ix)
	pop	af
	ld	0 (iy), l
;disk.c:66: crc = diskCrc7(buff) | 1;
	push	de
	call	_diskCrc7
	pop	af
	ld	a,l
	set	0, a
	ld	-15 (ix),a
;disk.c:68: bi_ss_on();
	call	_bi_ss_on
;disk.c:69: bi_spi(0xff);
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:70: bi_spi(cmd);
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:71: bi_spi(arg >> 24);
	ld	h,-4 (ix)
	push	hl
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:72: bi_spi(arg >> 16);
	ld	h,-8 (ix)
	push	hl
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:73: bi_spi(arg >> 8);
	ld	h,-12 (ix)
	push	hl
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:74: bi_spi(arg);
	ld	h,5 (ix)
	push	hl
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:75: bi_spi(crc);
	ld	a,-15 (ix)
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:76: bi_spi(0xff);
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:77: resp = bi_spi(0xff);
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
;disk.c:79: while (resp == 0xff) {
	ld	de,#0x0000
00103$:
	ld	a,l
	inc	a
	jr	NZ,00105$
;disk.c:80: resp = bi_spi(0xff);
	push	de
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
	pop	de
;disk.c:81: if (i++ == 2048)break;
	ld	h,e
	ld	b,d
	inc	de
	ld	a,h
	or	a, a
	jr	NZ,00103$
	ld	a,b
	sub	a, #0x08
	jr	NZ,00103$
00105$:
;disk.c:84: bi_ss_off();
	push	hl
	call	_bi_ss_off
	pop	hl
;disk.c:85: return resp;
	ld	sp,ix
	pop	ix
	ret
_diskCmd_end::
;disk.c:90: u8 diskCmdFast(u8 cmd, u32 arg) {
;	---------------------------------
; Function diskCmdFast
; ---------------------------------
_diskCmdFast_start::
_diskCmdFast:
;disk.c:96: bi_ss_on();
	call	_bi_ss_on
;disk.c:98: bi_spi_qq(0xff);
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:99: bi_spi_qq(cmd);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:100: bi_spi_qq(arg >> 24);
	push	af
	ld	iy,#5
	add	iy,sp
	ld	l,0 (iy)
	ld	h,1 (iy)
	ld	e,2 (iy)
	ld	d,3 (iy)
	pop	af
	ld	b,#0x18
00115$:
	srl	d
	rr	e
	rr	h
	rr	l
	djnz	00115$
	ld	h,l
	push	hl
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:101: bi_spi_qq(arg >> 16);
	push	af
	ld	iy,#5
	add	iy,sp
	ld	l,0 (iy)
	ld	h,1 (iy)
	ld	e,2 (iy)
	ld	d,3 (iy)
	pop	af
	ld	b,#0x10
00117$:
	srl	d
	rr	e
	rr	h
	rr	l
	djnz	00117$
	ld	h,l
	push	hl
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:102: bi_spi_qq(arg >> 8);
	push	af
	ld	iy,#5
	add	iy,sp
	ld	l,0 (iy)
	ld	h,1 (iy)
	ld	e,2 (iy)
	ld	d,3 (iy)
	pop	af
	ld	b,#0x08
00119$:
	srl	d
	rr	e
	rr	h
	rr	l
	djnz	00119$
	ld	h,l
	push	hl
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:103: bi_spi_qq(arg);
	ld	iy,#3
	add	iy,sp
	ld	h,0 (iy)
	push	hl
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:104: bi_spi_qq(0xff);
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:105: bi_spi_qq(0xff);
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi_qq
	inc	sp
;disk.c:106: resp = bi_spi_q(0xff);
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi_q
	inc	sp
;disk.c:108: while (resp == 0xff) {
	ld	de,#0x0000
00103$:
	ld	a,l
	inc	a
	jr	NZ,00105$
;disk.c:109: resp = bi_spi_q(0xff);
	push	de
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi_q
	inc	sp
	pop	de
;disk.c:110: if (i++ == WAIT_LEN)break;
	ld	c,e
	ld	h,d
	inc	de
	ld	a,c
	or	a, a
	jr	NZ,00103$
	ld	a,h
	sub	a, #0x08
	jr	NZ,00103$
00105$:
;disk.c:113: bi_ss_off();
	push	hl
	call	_bi_ss_off
	pop	hl
;disk.c:114: return resp;
	ret
_diskCmdFast_end::
;disk.c:117: u8 diskInit() {
;	---------------------------------
; Function diskInit
; ---------------------------------
_diskInit_start::
_diskInit:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;disk.c:134: disk_init_ok = 0;
	ld	hl,#_disk_init_ok + 0
	ld	(hl), #0x00
;disk.c:135: bi_card_type = 0;
	ld	hl,#_bi_card_type + 0
	ld	(hl), #0x00
;disk.c:136: bi_ss_off();
	push	de
	call	_bi_ss_off
	call	_diskCloseRW
	pop	de
;disk.c:140: for (i = 0; i < 32; i++)bi_spi(0xff);
	ld	hl,#0x0000
00150$:
	push	hl
	push	de
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
	pop	de
	pop	hl
	inc	hl
	ld	a,l
	sub	a, #0x20
	ld	a,h
	sbc	a, #0x00
	jr	C,00150$
;disk.c:149: resp = diskStop(1);
	push	de
	ld	a,#0x01
	push	af
	inc	sp
	call	_diskStop
	inc	sp
	pop	de
	ld	e,l
;disk.c:150: if (resp)return resp;
	ld	a,e
	or	a, a
	jr	Z,00103$
	ld	l,e
	jp	00158$
00103$:
;disk.c:152: resp = diskCmd(CMD8, 0x1aa);
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x01AA
	push	hl
	ld	a,#0x48
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	ld	e,l
;disk.c:153: for (i = 0; i < 5; i++)bi_spi(0xff);
	ld	hl,#0x0000
00152$:
	push	hl
	push	de
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
	pop	de
	pop	hl
	inc	hl
	ld	a,l
	sub	a, #0x05
	ld	a,h
	sbc	a, #0x00
	jr	C,00152$
;disk.c:154: if (resp == 0xff)return DISK_ERR_INIT + 1;
	ld	a,e
	inc	a
	jr	NZ,00106$
	ld	l,#0xC1
	jp	00158$
00106$:
;disk.c:155: if (resp != 5)bi_card_type |= SD_V2;
	ld	a,e
	sub	a, #0x05
	jr	Z,00108$
	ld	a,(#_bi_card_type + 0)
	set	1, a
	ld	(#_bi_card_type + 0),a
00108$:
;disk.c:157: if (bi_card_type == 2) {
	ld	iy,#_bi_card_type
	ld	a,0 (iy)
	sub	a, #0x02
	jp	NZ,00148$
;disk.c:159: for (i = 0; i < WAIT_LEN; i++) {
	ld	hl,#0x0000
	ex	(sp), hl
	ld	bc,#0x0000
00154$:
;disk.c:162: resp = diskCmd(CMD55, 0xffff);
	push	bc
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0xFFFF
	push	hl
	ld	a,#0x77
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	e,l
;disk.c:163: if (resp == 0xff)return DISK_ERR_INIT + 2;
	ld	a,e
	inc	a
	jr	NZ,00110$
	ld	l,#0xC2
	jp	00158$
00110$:
;disk.c:164: if (resp != 1)continue;
	ld	a,e
	dec	a
	jr	NZ,00117$
;disk.c:166: resp = diskCmd(CMD41, 0x40300000);
	push	bc
	push	de
	ld	hl,#0x4030
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x69
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	e,l
;disk.c:167: if (resp == 0xff)return DISK_ERR_INIT + 3;
	ld	a,e
	inc	a
	jr	NZ,00114$
	ld	l,#0xC3
	jp	00158$
00114$:
;disk.c:168: if (resp != 0)continue;
	ld	a,e
	or	a, a
	jr	Z,00118$
;disk.c:170: break;
00117$:
;disk.c:159: for (i = 0; i < WAIT_LEN; i++) {
	inc	bc
	inc	sp
	inc	sp
	push	bc
	ld	a,b
	and	a, #0xF8
	jr	Z,00154$
00118$:
;disk.c:172: if (i == WAIT_LEN)return DISK_ERR_INIT + 4;
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00120$
	ld	a,-1 (ix)
	sub	a, #0x08
	jr	NZ,00120$
	ld	l,#0xC4
	jp	00158$
00120$:
;disk.c:174: resp = diskCmd(CMD58, 0);
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x7A
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	ld	e,l
;disk.c:175: if (resp == 0xff)return DISK_ERR_INIT + 5;
	ld	a,e
	inc	a
	jr	NZ,00122$
	ld	l,#0xC5
	jp	00158$
00122$:
;disk.c:176: bi_ss_on();
	push	de
	call	_bi_ss_on
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
	pop	de
	ld	e,l
;disk.c:178: for (i = 0; i < 3; i++)bi_spi(0xff);
	ld	hl,#0x0000
00155$:
	push	hl
	push	de
	ld	a,#0xFF
	push	af
	inc	sp
	call	_bi_spi
	inc	sp
	pop	de
	pop	hl
	inc	hl
	ld	a,l
	sub	a, #0x03
	ld	a,h
	sbc	a, #0x00
	jr	C,00155$
;disk.c:179: if ((resp & 0x40))bi_card_type |= 1;
	bit	6, e
	jp	Z,00149$
	ld	a,(#_bi_card_type + 0)
	set	0, a
	ld	(#_bi_card_type + 0),a
	jp	00149$
00148$:
;disk.c:186: resp = diskCmd(CMD55, 0);
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x77
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	ld	e,l
;disk.c:187: if (resp == 0xff)return DISK_ERR_INIT + 6;
	ld	a,e
	inc	a
	jr	NZ,00127$
	ld	l,#0xC6
	jp	00158$
00127$:
;disk.c:188: resp = diskCmd(CMD41, 0);
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x69
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	ld	e,l
;disk.c:189: if (resp == 0xff)return DISK_ERR_INIT + 7;
	ld	a,e
	inc	a
	jr	NZ,00129$
	ld	l,#0xC7
	jp	00158$
00129$:
;disk.c:192: for (i = 0; i < WAIT_LEN; i++) {
	ld	hl,#0x0000
	ex	(sp), hl
	ld	bc,#0x0000
00157$:
;disk.c:193: if (resp < 1) {
	ld	a,e
	sub	a, #0x01
	jr	NC,00141$
;disk.c:195: resp = diskCmd(CMD55, 0);
	push	bc
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x77
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	e,l
;disk.c:196: if (resp == 0xff)return DISK_ERR_INIT + 8;
	ld	a,e
	inc	a
	jr	NZ,00131$
	ld	l,#0xC8
	jp	00158$
00131$:
;disk.c:197: if (resp != 1)continue;
	ld	a,e
	dec	a
	jr	NZ,00143$
;disk.c:199: resp = diskCmd(CMD41, 0);
	push	bc
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x69
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	e,l
;disk.c:200: if (resp == 0xff)return DISK_ERR_INIT + 9;
	ld	a,e
	inc	a
	jr	NZ,00135$
	ld	l,#0xC9
	jr	00158$
00135$:
;disk.c:201: if (resp != 0)continue;
	ld	a,e
	or	a, a
	jr	Z,00144$
	jr	00143$
00141$:
;disk.c:205: resp = diskCmd(CMD1, 0);
	push	bc
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x41
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	e,l
;disk.c:206: if (resp != 0)continue;
	ld	a,e
	or	a, a
	jr	Z,00144$
;disk.c:209: break;
00143$:
;disk.c:192: for (i = 0; i < WAIT_LEN; i++) {
	inc	bc
	inc	sp
	inc	sp
	push	bc
	ld	a,b
	and	a, #0xF8
	jr	Z,00157$
00144$:
;disk.c:213: if (i == WAIT_LEN)return DISK_ERR_INIT + 10;
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00149$
	ld	a,-1 (ix)
	sub	a, #0x08
	jr	NZ,00149$
	ld	l,#0xCA
	jr	00158$
00149$:
;disk.c:217: bi_spi_speed_on();
	push	de
	call	_bi_spi_speed_on
	pop	de
;disk.c:218: disk_addr = 1;
	ld	hl,#_disk_addr + 0
	ld	(hl), #0x01
	xor	a, a
	ld	(#_disk_addr + 1),a
	ld	(#_disk_addr + 2),a
	ld	(#_disk_addr + 3),a
;disk.c:219: disk_init_ok = 1;
	ld	hl,#_disk_init_ok + 0
	ld	(hl), #0x01
;disk.c:221: return 0;
	ld	l,#0x00
00158$:
	ld	sp,ix
	pop	ix
	ret
_diskInit_end::
;disk.c:225: u8 diskOpenRead(u32 saddr) {
;	---------------------------------
; Function diskOpenRead
; ---------------------------------
_diskOpenRead_start::
_diskOpenRead:
;disk.c:228: if (!(bi_card_type & 1))saddr *= 512;
	ld	hl,#_bi_card_type+0
	bit	0, (hl)
	jr	NZ,00102$
	push	af
	pop	af
	ld	b,#0x09
00115$:
	ld	iy,#2
	add	iy,sp
	sla	0 (iy)
	rl	1 (iy)
	rl	2 (iy)
	rl	3 (iy)
	djnz	00115$
00102$:
;disk.c:230: resp = diskCmdFast(CMD18, saddr);
	ld	iy,#2
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	ld	a,#0x52
	push	af
	inc	sp
	call	_diskCmdFast
	pop	af
	pop	af
	inc	sp
	ld	a,l
;disk.c:231: if (resp != 0)return DISK_ERR_RD1;
	or	a, a
	jr	Z,00104$
	ld	l,#0xD2
	ret
00104$:
;disk.c:232: bi_ss_on();
	call	_bi_ss_on
;disk.c:234: return 0;
	ld	l,#0x00
	ret
_diskOpenRead_end::
;disk.c:237: u8 diskReadToRam(u32 sd_addr, void *dst, u16 slen) {
;	---------------------------------
; Function diskReadToRam
; ---------------------------------
_diskReadToRam_start::
_diskReadToRam:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;disk.c:239: u8 resp = 0;
	ld	-1 (ix),#0x00
;disk.c:241: if (sd_addr != disk_addr) {
	ld	a,4 (ix)
	ld	iy,#_disk_addr
	sub	a, 0 (iy)
	jr	NZ,00123$
	ld	a,5 (ix)
	ld	iy,#_disk_addr
	sub	a, 1 (iy)
	jr	NZ,00123$
	ld	a,6 (ix)
	ld	iy,#_disk_addr
	sub	a, 2 (iy)
	jr	NZ,00123$
	ld	a,7 (ix)
	ld	iy,#_disk_addr
	sub	a, 3 (iy)
	jr	Z,00104$
00123$:
;disk.c:242: diskCloseRW();
	call	_diskCloseRW
;disk.c:243: resp = diskOpenRead(sd_addr);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_diskOpenRead
	pop	af
	pop	af
;disk.c:244: if (resp)return resp;
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-1 (ix)
	jr	00109$
00102$:
;disk.c:245: disk_addr = sd_addr;
	ld	de, #_disk_addr
	ld	hl, #5
	add	hl, sp
	ld	bc, #4
	ldir
00104$:
;disk.c:248: if (resp)return resp;
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00106$
	ld	l,-1 (ix)
	jr	00109$
00106$:
;disk.c:249: disk_addr += slen;
	ld	d,10 (ix)
	ld	e,11 (ix)
	ld	bc,#0x0000
	ld	hl,#_disk_addr
	ld	a,(hl)
	add	a, d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, e
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, b
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, c
	ld	(hl),a
;disk.c:251: resp = bi_spi_to_ram(dst, slen);
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	_bi_spi_to_ram
	pop	af
	pop	af
;disk.c:252: if (resp)bi_ss_off();
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00108$
	call	_bi_ss_off
00108$:
;disk.c:254: return resp;
	ld	l,-1 (ix)
00109$:
	inc	sp
	pop	ix
	ret
_diskReadToRam_end::
;disk.c:257: u8 diskReadToRom(u32 sd_addr, void *dst, u16 slen) {
;	---------------------------------
; Function diskReadToRom
; ---------------------------------
_diskReadToRom_start::
_diskReadToRom:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;disk.c:259: u8 resp = 0;
	ld	-1 (ix),#0x00
;disk.c:261: if (sd_addr != disk_addr) {
	ld	a,4 (ix)
	ld	iy,#_disk_addr
	sub	a, 0 (iy)
	jr	NZ,00123$
	ld	a,5 (ix)
	ld	iy,#_disk_addr
	sub	a, 1 (iy)
	jr	NZ,00123$
	ld	a,6 (ix)
	ld	iy,#_disk_addr
	sub	a, 2 (iy)
	jr	NZ,00123$
	ld	a,7 (ix)
	ld	iy,#_disk_addr
	sub	a, 3 (iy)
	jr	Z,00104$
00123$:
;disk.c:262: diskCloseRW();
	call	_diskCloseRW
;disk.c:263: resp = diskOpenRead(sd_addr);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_diskOpenRead
	pop	af
	pop	af
;disk.c:264: if (resp)return resp;
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-1 (ix)
	jr	00109$
00102$:
;disk.c:265: disk_addr = sd_addr;
	ld	de, #_disk_addr
	ld	hl, #5
	add	hl, sp
	ld	bc, #4
	ldir
00104$:
;disk.c:268: if (resp)return resp;
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00106$
	ld	l,-1 (ix)
	jr	00109$
00106$:
;disk.c:269: disk_addr += slen;
	ld	d,10 (ix)
	ld	e,11 (ix)
	ld	bc,#0x0000
	ld	hl,#_disk_addr
	ld	a,(hl)
	add	a, d
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, e
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, b
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, c
	ld	(hl),a
;disk.c:271: resp = bi_spi_to_rom(dst, slen);
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	_bi_spi_to_rom
	pop	af
	pop	af
;disk.c:272: if (resp)bi_ss_off();
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00108$
	call	_bi_ss_off
00108$:
;disk.c:274: return resp;
	ld	l,-1 (ix)
00109$:
	inc	sp
	pop	ix
	ret
_diskReadToRom_end::
;disk.c:278: void diskCloseRW() {
;	---------------------------------
; Function diskCloseRW
; ---------------------------------
_diskCloseRW_start::
_diskCloseRW:
;disk.c:279: if (disk_addr == ~0)return;
	ld	a,(#_disk_addr + 0)
	inc	a
	jr	NZ,00102$
	ld	a,(#_disk_addr + 1)
	inc	a
	jr	NZ,00102$
	ld	a,(#_disk_addr + 2)
	inc	a
	jr	NZ,00102$
	ld	a,(#_disk_addr + 3)
	inc	a
	ret	Z
	jr	00102$
	ret
00102$:
;disk.c:280: bi_ss_off();
	call	_bi_ss_off
;disk.c:281: diskCmdFast(CMD12, 0);
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x4C
	push	af
	inc	sp
	call	_diskCmdFast
	pop	af
	pop	af
	inc	sp
;disk.c:282: disk_addr = ~0;
	ld	hl,#_disk_addr + 0
	ld	(hl), #0xFF
	ld	hl,#_disk_addr + 1
	ld	(hl), #0xFF
	ld	hl,#_disk_addr + 2
	ld	(hl), #0xFF
	ld	hl,#_disk_addr + 3
	ld	(hl), #0xFF
	ret
_diskCloseRW_end::
;disk.c:285: u8 diskOpenWrite(u32 saddr) {
;	---------------------------------
; Function diskOpenWrite
; ---------------------------------
_diskOpenWrite_start::
_diskOpenWrite:
;disk.c:288: if (!(bi_card_type & 1))saddr *= 512;
	ld	hl,#_bi_card_type+0
	bit	0, (hl)
	jr	NZ,00102$
	push	af
	pop	af
	ld	b,#0x09
00115$:
	ld	iy,#2
	add	iy,sp
	sla	0 (iy)
	rl	1 (iy)
	rl	2 (iy)
	rl	3 (iy)
	djnz	00115$
00102$:
;disk.c:289: resp = diskCmdFast(CMD25, saddr);
	ld	iy,#2
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	ld	a,#0x59
	push	af
	inc	sp
	call	_diskCmdFast
	pop	af
	pop	af
	inc	sp
	ld	a,l
;disk.c:290: if (resp != 0)return DISK_ERR_WR1;
	or	a, a
	jr	Z,00104$
	ld	l,#0xD4
	ret
00104$:
;disk.c:291: bi_ss_on();
	call	_bi_ss_on
;disk.c:293: return 0;
	ld	l,#0x00
	ret
_diskOpenWrite_end::
;disk.c:296: u8 diskWrite(u32 sd_addr, void *src, u16 slen) {
;	---------------------------------
; Function diskWrite
; ---------------------------------
_diskWrite_start::
_diskWrite:
;disk.c:299: diskCloseRW();
	push	hl
	call	_diskCloseRW
	ld	iy,#4
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	call	_diskOpenWrite
	pop	af
	pop	af
	ld	a,l
	pop	hl
;disk.c:301: if (resp != 0)return resp; //DISK_ERR_WR2;
	ld	l,a
	or	a, a
	ret	NZ
;disk.c:303: resp = bi_ram_to_spi(src, slen);
	push	hl
	ld	hl, #10
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	hl, #10
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_bi_ram_to_spi
	pop	af
	pop	af
	ld	a,l
	pop	hl
	ld	l,a
;disk.c:305: bi_ss_off();
	push	hl
	call	_bi_ss_off
	pop	hl
;disk.c:306: if (resp)return resp;
	ld	a,l
	or	a, a
	ret	NZ
;disk.c:307: diskCloseRW();
	push	hl
	call	_diskCloseRW
	pop	hl
;disk.c:308: return 0;
	ld	l,#0x00
	ret
_diskWrite_end::
;disk.c:311: u8 diskStop(u8 forced) {
;	---------------------------------
; Function diskStop
; ---------------------------------
_diskStop_start::
_diskStop:
;disk.c:316: if (!forced && !disk_init_ok)return 0;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	NZ,00102$
	ld	a,(#_disk_init_ok + 0)
	or	a,a
	jr	NZ,00102$
	ld	l,a
	ret
00102$:
;disk.c:319: resp = 0;
	ld	l,#0x00
;disk.c:320: while (resp != 1 && i++ < 2) {
	ld	d,#0x00
00105$:
	dec	l
	jr	NZ,00131$
	ld	a,#0x01
	jr	00132$
00131$:
	xor	a,a
00132$:
	ld	h,a
	or	a, a
	jr	NZ,00107$
	ld	l,d
	inc	d
	ld	a,l
	sub	a, #0x02
	jr	NC,00107$
;disk.c:321: resp = diskCmd(CMD0, 0);
	push	de
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	a,#0x40
	push	af
	inc	sp
	call	_diskCmd
	pop	af
	pop	af
	inc	sp
	pop	de
	jr	00105$
00107$:
;disk.c:324: if (resp != 1)return DISK_ERR_INIT + 0;
	ld	a,h
	or	a, a
	jr	NZ,00109$
	ld	l,#0xC0
	ret
00109$:
;disk.c:326: return 0;
	ld	l,#0x00
	ret
_diskStop_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
