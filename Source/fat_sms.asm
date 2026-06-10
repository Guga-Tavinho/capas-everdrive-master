;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 #8604 (May 11 2013) (MINGW64)
; This file was generated Wed Jun 10 08:26:41 2026
;--------------------------------------------------------
	.module fat
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fat_make_dos_name
	.globl _fat_next_dir_sector
	.globl _fat_make_lfn
	.globl _fat_make_hdr
	.globl _fat_cache_save_data
	.globl _sysMemCopy
	.globl _sysMemSet
	.globl _osGetTime
	.globl _osGetDate
	.globl _osReleaseRam
	.globl _osMallocRam
	.globl _str_append
	.globl _str_extension
	.globl _str_length
	.globl _str_cmp_len
	.globl _diskReadToRom
	.globl _diskReadToRam
	.globl _diskWrite
	.globl _file
	.globl _fat_cov_dir
	.globl _fat_cov_dir_buff
	.globl _fat_dir
	.globl _fat_tab
	.globl _fat_dat
	.globl _fat_dir_is_root
	.globl _fat_cov_dir_size
	.globl _fat_dir_size
	.globl _fat_sub_dir_clust
	.globl _fat_first_free_clust
	.globl _fat_cluster_size_pow
	.globl _fat_type
	.globl _fat_cluster_size
	.globl _fat_reserved_sectors
	.globl _fat_data_entry
	.globl _fat_root_entry
	.globl _fat_sectors_per_fat
	.globl _fat_tab_sector
	.globl _fat_dat_sector
	.globl _fat_pbr_entry
	.globl _fat_entry
	.globl _fat_clust_num
	.globl _fat_init
	.globl _fat_cache_read_dat
	.globl _fat_cache_read_tab
	.globl _fat_get_type
	.globl _fat_bytes_to_short
	.globl _fat_load_dir
	.globl _fat_filter_cover_records
	.globl _fat_cluster_to_sector
	.globl _fat_sector_to_cluster
	.globl _fat_in_cluster_addr
	.globl _fat_get_table_record
	.globl _fat_get_next_cluster
	.globl _fat_get_full_record
	.globl _fat_open_file
	.globl _fat_skip_sectors
	.globl _fat_read
	.globl _fat_make_path_name
	.globl _fat_make_sync_name
	.globl _fat_open_file_by_name
	.globl _fat_seek_record
	.globl _fat_bytes_to_int_le
	.globl _fat_int_to_bytes_le
	.globl _fat_seek_free_cluster
	.globl _fat_cache_save_tab
	.globl _fat_catch_clusters
	.globl _fat_resize_file
	.globl _fat_seek_rec_end
	.globl _fat_join
	.globl _fat_write_file
	.globl _fat_expand
	.globl _fat_clean_cluster
	.globl _fat_make_record
	.globl _fat_make_dir
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_fat_clust_num::
	.ds 4
_fat_entry::
	.ds 4
_fat_pbr_entry::
	.ds 4
_fat_dat_sector::
	.ds 4
_fat_tab_sector::
	.ds 4
_fat_sectors_per_fat::
	.ds 4
_fat_root_entry::
	.ds 4
_fat_data_entry::
	.ds 4
_fat_reserved_sectors::
	.ds 2
_fat_cluster_size::
	.ds 1
_fat_type::
	.ds 1
_fat_cluster_size_pow::
	.ds 1
_fat_first_free_clust::
	.ds 4
_fat_sub_dir_clust::
	.ds 4
_fat_dir_size::
	.ds 2
_fat_cov_dir_size::
	.ds 2
_fat_dir_is_root::
	.ds 1
_fat_dat::
	.ds 2
_fat_tab::
	.ds 2
_fat_dir::
	.ds 2
_fat_cov_dir_buff::
	.ds 512
_fat_cov_dir::
	.ds 2
_file::
	.ds 16
_fat_cluster_to_sector_val_1_113:
	.ds 4
_fat_sector_to_cluster_val_1_115:
	.ds 4
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
;fat.c:75: u8 fat_init() {
;	---------------------------------
; Function fat_init
; ---------------------------------
_fat_init_start::
_fat_init:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-5
	add	hl,sp
	ld	sp,hl
;fat.c:78: fat_dat = (u8 *) osMallocRam(512);
	ld	hl,#0x0200
	push	hl
	call	_osMallocRam
	pop	af
	ld	(_fat_dat),hl
;fat.c:79: fat_tab = (u8 *) osMallocRam(512);
	ld	hl,#0x0200
	push	hl
	call	_osMallocRam
	pop	af
	ld	(_fat_tab),hl
;fat.c:80: fat_dir = (u32 *) osMallocRam(OS_MAX_DIR_SIZE * 4);
	ld	hl,#0x0800
	push	hl
	call	_osMallocRam
	pop	af
	ld	(_fat_dir),hl
;fat.c:81: fat_cov_dir = fat_cov_dir_buff;
	ld	hl,#_fat_cov_dir_buff
	ld	(_fat_cov_dir),hl
;fat.c:83: fat_dat_sector = ~0;
	ld	hl,#_fat_dat_sector + 0
	ld	(hl), #0xFF
	ld	hl,#_fat_dat_sector + 1
	ld	(hl), #0xFF
	ld	hl,#_fat_dat_sector + 2
	ld	(hl), #0xFF
	ld	hl,#_fat_dat_sector + 3
	ld	(hl), #0xFF
;fat.c:84: fat_tab_sector = ~0;
	ld	hl,#_fat_tab_sector + 0
	ld	(hl), #0xFF
	ld	hl,#_fat_tab_sector + 1
	ld	(hl), #0xFF
	ld	hl,#_fat_tab_sector + 2
	ld	(hl), #0xFF
	ld	hl,#_fat_tab_sector + 3
	ld	(hl), #0xFF
;fat.c:86: fat_pbr_entry = 0;
	xor	a, a
	ld	(#_fat_pbr_entry + 0),a
	ld	(#_fat_pbr_entry + 1),a
	ld	(#_fat_pbr_entry + 2),a
	ld	(#_fat_pbr_entry + 3),a
;fat.c:87: resp = fat_cache_read_dat(fat_pbr_entry);
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	call	_fat_cache_read_dat
	pop	af
	pop	af
;fat.c:88: if (resp)return resp;
	ld	-5 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-5 (ix)
	jp	00115$
00102$:
;fat.c:89: fat_type = fat_get_type();
	call	_fat_get_type
	ld	iy,#_fat_type
	ld	0 (iy),l
;fat.c:91: if (fat_type == 0) {
	ld	a,(#_fat_type + 0)
	or	a, a
	jr	NZ,00108$
;fat.c:92: fat_bytes_to_int_le(&fat_dat[0x1c6], &fat_pbr_entry);
	ld	de,#_fat_pbr_entry
	ld	iy,#0x01C6
	ld	bc,(_fat_dat)
	add	iy, bc
	push	de
	push	iy
	call	_fat_bytes_to_int_le
	pop	af
	pop	af
;fat.c:93: resp = fat_cache_read_dat(fat_pbr_entry);
	ld	hl,(_fat_pbr_entry + 2)
	push	hl
	ld	hl,(_fat_pbr_entry)
	push	hl
	call	_fat_cache_read_dat
	pop	af
	pop	af
;fat.c:94: if (resp)return resp;
	ld	-5 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00104$
	ld	l,-5 (ix)
	jp	00115$
00104$:
;fat.c:95: fat_type = fat_get_type();
	call	_fat_get_type
	ld	iy,#_fat_type
	ld	0 (iy),l
;fat.c:96: if (fat_type == 0)return FAT_ERR_UNK_TYPE;
	ld	a,(#_fat_type + 0)
	or	a, a
	jr	NZ,00108$
	ld	l,#0xF6
	jp	00115$
00108$:
;fat.c:99: if (fat_type == FAT_TYPE_16) {
	ld	a,(#_fat_type + 0)
	dec	a
	jr	NZ,00110$
;fat.c:100: return FAT_ERR_FAT16;
	ld	l,#0xFB
	jp	00115$
00110$:
;fat.c:102: fat_bytes_to_int_le(&fat_dat[0x24], &fat_sectors_per_fat);
	ld	de,#_fat_sectors_per_fat
	ld	iy,#0x0024
	ld	bc,(_fat_dat)
	add	iy, bc
	push	de
	push	iy
	call	_fat_bytes_to_int_le
	pop	af
	pop	af
;fat.c:103: fat_clust_num = fat_sectors_per_fat * 128;
	push	af
	ld	a,(#_fat_sectors_per_fat + 0)
	ld	(#_fat_clust_num + 0),a
	ld	a,(#_fat_sectors_per_fat + 1)
	ld	(#_fat_clust_num + 1),a
	ld	a,(#_fat_sectors_per_fat + 2)
	ld	(#_fat_clust_num + 2),a
	ld	a,(#_fat_sectors_per_fat + 3)
	ld	(#_fat_clust_num + 3),a
	pop	af
	ld	b,#0x07
00140$:
	ld	iy,#_fat_clust_num
	sla	0 (iy)
	ld	iy,#_fat_clust_num
	rl	1 (iy)
	ld	iy,#_fat_clust_num
	rl	2 (iy)
	ld	iy,#_fat_clust_num
	rl	3 (iy)
	djnz	00140$
;fat.c:106: fat_reserved_sectors = fat_bytes_to_short(&fat_dat[0x0E]);
	ld	iy,#0x000E
	ld	de,(_fat_dat)
	add	iy, de
	push	iy
	call	_fat_bytes_to_short
	pop	af
	ld	(_fat_reserved_sectors),hl
;fat.c:107: fat_cluster_size = fat_dat[0x0D];
	ld	hl,(_fat_dat)
	ld	de, #0x000D
	add	hl, de
	ld	a,(hl)
	ld	(#_fat_cluster_size + 0),a
;fat.c:108: fat_root_entry = fat_sectors_per_fat * 2 + fat_pbr_entry + fat_reserved_sectors;
	push	af
	ld	hl,#_fat_sectors_per_fat + 0
	ld	d, (hl)
	ld	hl,#_fat_sectors_per_fat + 1
	ld	b, (hl)
	ld	hl,#_fat_sectors_per_fat + 2
	ld	e, (hl)
	ld	hl,#_fat_sectors_per_fat + 3
	ld	c, (hl)
	pop	af
	sla	d
	rl	b
	rl	e
	rl	c
	ld	a,d
	ld	hl,#_fat_pbr_entry
	add	a, (hl)
	ld	-4 (ix),a
	ld	a,b
	inc	hl
	adc	a, (hl)
	ld	-3 (ix),a
	ld	a,e
	inc	hl
	adc	a, (hl)
	ld	-2 (ix),a
	ld	a,c
	inc	hl
	adc	a, (hl)
	ld	-1 (ix),a
	ld	hl,#_fat_reserved_sectors + 0
	ld	e, (hl)
	ld	hl,#_fat_reserved_sectors + 1
	ld	d, (hl)
	ld	bc,#0x0000
	ld	a,-4 (ix)
	ld	hl,#_fat_root_entry
	add	a, e
	ld	(hl),a
	ld	a,-3 (ix)
	adc	a, d
	inc	hl
	ld	(hl),a
	ld	a,-2 (ix)
	adc	a, c
	inc	hl
	ld	(hl),a
	ld	a,-1 (ix)
	adc	a, b
	inc	hl
	ld	(hl),a
;fat.c:109: fat_entry = fat_pbr_entry + fat_reserved_sectors;
	ld	hl,#_fat_entry
	ld	a,(#_fat_pbr_entry + 0)
	add	a, e
	ld	(hl),a
	ld	a,(#_fat_pbr_entry + 1)
	adc	a, d
	inc	hl
	ld	(hl),a
	ld	a,(#_fat_pbr_entry + 2)
	adc	a, c
	inc	hl
	ld	(hl),a
	ld	a,(#_fat_pbr_entry + 3)
	adc	a, b
	inc	hl
	ld	(hl),a
;fat.c:110: fat_data_entry = fat_root_entry;
	ld	de, #_fat_data_entry
	ld	hl, #_fat_root_entry
	ld	bc, #4
	ldir
;fat.c:112: resp = fat_cluster_size;
	ld	a,(#_fat_cluster_size + 0)
	ld	-5 (ix),a
;fat.c:113: fat_cluster_size_pow = 0;
	ld	hl,#_fat_cluster_size_pow + 0
	ld	(hl), #0x00
;fat.c:115: while (resp > 1) {
00112$:
	ld	a,#0x01
	sub	a, -5 (ix)
	jr	NC,00114$
;fat.c:116: resp >>= 1;
	srl	-5 (ix)
	ld	a, -5 (ix)
;fat.c:117: fat_cluster_size_pow++;
	ld	hl, #_fat_cluster_size_pow+0
	inc	(hl)
	jr	00112$
00114$:
;fat.c:120: fat_first_free_clust = 2;
	ld	hl,#_fat_first_free_clust + 0
	ld	(hl), #0x02
	xor	a, a
	ld	(#_fat_first_free_clust + 1),a
	ld	(#_fat_first_free_clust + 2),a
	ld	(#_fat_first_free_clust + 3),a
;fat.c:124: return 0;
	ld	l,#0x00
00115$:
	ld	sp,ix
	pop	ix
	ret
_fat_init_end::
_lfn_char_struct:
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x09	; 9
	.db #0x0E	; 14
	.db #0x10	; 16
	.db #0x12	; 18
	.db #0x14	; 20
	.db #0x16	; 22
	.db #0x18	; 24
	.db #0x1C	; 28
	.db #0x1E	; 30
;fat.c:127: u8 fat_cache_read_dat(u32 sector) {
;	---------------------------------
; Function fat_cache_read_dat
; ---------------------------------
_fat_cache_read_dat_start::
_fat_cache_read_dat:
	push	ix
	ld	ix,#0
	add	ix,sp
;fat.c:129: if (sector == fat_dat_sector)return 0;
	ld	a,4 (ix)
	ld	iy,#_fat_dat_sector
	sub	a, 0 (iy)
	jr	NZ,00102$
	ld	a,5 (ix)
	ld	iy,#_fat_dat_sector
	sub	a, 1 (iy)
	jr	NZ,00102$
	ld	a,6 (ix)
	ld	iy,#_fat_dat_sector
	sub	a, 2 (iy)
	jr	NZ,00102$
	ld	a,7 (ix)
	ld	iy,#_fat_dat_sector
	sub	a, 3 (iy)
	jr	NZ,00102$
	ld	l,#0x00
	jr	00103$
00102$:
;fat.c:130: fat_dat_sector = sector;
	ld	de, #_fat_dat_sector
	ld	hl, #4
	add	hl, sp
	ld	bc, #4
	ldir
;fat.c:131: return diskReadToRam(sector, fat_dat, 1);
	ld	hl,(_fat_dat)
	ld	bc,#0x0001
	push	bc
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_diskReadToRam
	pop	af
	pop	af
	pop	af
	pop	af
00103$:
	pop	ix
	ret
_fat_cache_read_dat_end::
;fat.c:135: u8 fat_cache_read_tab(u32 sector) {
;	---------------------------------
; Function fat_cache_read_tab
; ---------------------------------
_fat_cache_read_tab_start::
_fat_cache_read_tab:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;fat.c:138: if (sector == fat_tab_sector)return 0;
	ld	a,4 (ix)
	ld	iy,#_fat_tab_sector
	sub	a, 0 (iy)
	jr	NZ,00102$
	ld	a,5 (ix)
	ld	iy,#_fat_tab_sector
	sub	a, 1 (iy)
	jr	NZ,00102$
	ld	a,6 (ix)
	ld	iy,#_fat_tab_sector
	sub	a, 2 (iy)
	jr	NZ,00102$
	ld	a,7 (ix)
	ld	iy,#_fat_tab_sector
	sub	a, 3 (iy)
	jr	NZ,00102$
	ld	l,#0x00
	jr	00103$
00102$:
;fat.c:139: fat_tab_sector = sector;
	ld	de, #_fat_tab_sector
	ld	hl, #8
	add	hl, sp
	ld	bc, #4
	ldir
;fat.c:140: sector += fat_entry;
	ld	a,4 (ix)
	ld	hl,#_fat_entry
	add	a, (hl)
	ld	-4 (ix),a
	ld	a,5 (ix)
	inc	hl
	adc	a, (hl)
	ld	-3 (ix),a
	ld	a,6 (ix)
	inc	hl
	adc	a, (hl)
	ld	-2 (ix),a
	ld	a,7 (ix)
	inc	hl
	adc	a, (hl)
	ld	-1 (ix),a
	ld	hl, #8
	add	hl, sp
	ex	de, hl
	ld	hl, #0
	add	hl, sp
	ld	bc, #4
	ldir
;fat.c:142: return diskReadToRam(sector, fat_tab, 1);
	ld	hl,(_fat_tab)
	ld	bc,#0x0001
	push	bc
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_diskReadToRam
	pop	af
	pop	af
	pop	af
	pop	af
00103$:
	ld	sp,ix
	pop	ix
	ret
_fat_cache_read_tab_end::
;fat.c:146: u8 fat_get_type() {
;	---------------------------------
; Function fat_get_type
; ---------------------------------
_fat_get_type_start::
_fat_get_type:
;fat.c:147: if (str_cmp_len(&fat_dat[0x36], "FAT", 3) != 0)return FAT_TYPE_16;
	ld	iy,#0x0036
	ld	de,(_fat_dat)
	add	iy, de
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#__str_0
	push	hl
	push	iy
	call	_str_cmp_len
	pop	af
	pop	af
	inc	sp
	ld	a,l
	or	a, a
	jr	Z,00102$
	ld	l,#0x01
	ret
00102$:
;fat.c:148: if (str_cmp_len(&fat_dat[0x52], "FAT", 3) != 0)return FAT_TYPE_32;
	ld	de,#__str_0
	ld	a,(#_fat_dat + 0)
	add	a, #0x52
	ld	c,a
	ld	a,(#_fat_dat + 1)
	adc	a, #0x00
	ld	b,a
	ld	a,#0x03
	push	af
	inc	sp
	push	de
	push	bc
	call	_str_cmp_len
	pop	af
	pop	af
	inc	sp
	ld	a,l
	or	a, a
	jr	Z,00104$
	ld	l,#0x02
	ret
00104$:
;fat.c:149: return 0;
	ld	l,#0x00
	ret
_fat_get_type_end::
__str_0:
	.ascii "FAT"
	.db 0x00
;fat.c:152: u16 fat_bytes_to_short(u8 *src) {
;	---------------------------------
; Function fat_bytes_to_short
; ---------------------------------
_fat_bytes_to_short_start::
_fat_bytes_to_short:
	push	ix
	ld	ix,#0
	add	ix,sp
;fat.c:154: return *src | (src[1] << 8);
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,(hl)
	inc	hl
	ld	d, (hl)
	ld	hl,#0x0000
	ld	a,e
	or	a, l
	ld	l,a
	ld	a,h
	or	a, d
	ld	h,a
	pop	ix
	ret
_fat_bytes_to_short_end::
;fat.c:157: u8 fat_load_dir(u32 entry) {
;	---------------------------------
; Function fat_load_dir
; ---------------------------------
_fat_load_dir_start::
_fat_load_dir:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-24
	add	hl,sp
	ld	sp,hl
;fat.c:170: lfn_record = 0;
	ld	-19 (ix),#0x00
;fat.c:171: first_char = 0;
	ld	-5 (ix),#0x00
;fat.c:172: fat_dir_size = 0;
	ld	hl,#_fat_dir_size + 0
	ld	(hl), #0x00
	ld	hl,#_fat_dir_size + 1
	ld	(hl), #0x00
;fat.c:173: fat_cov_dir_size = 0;
	ld	hl,#_fat_cov_dir_size + 0
	ld	(hl), #0x00
	ld	iy,#_fat_cov_dir_size
	ld	1 (iy),#0x00
;fat.c:176: if (entry == 0) {
	ld	a,7 (ix)
	or	a, 6 (ix)
	or	a, 5 (ix)
	or	a,4 (ix)
	jr	NZ,00104$
;fat.c:177: sector = fat_root_entry;
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	hl, #_fat_root_entry
	ld	bc, #4
	ldir
;fat.c:178: entry = 2;
	ld	4 (ix),#0x02
	xor	a, a
	ld	5 (ix),a
	ld	6 (ix),a
	ld	7 (ix),a
;fat.c:179: fat_dir_is_root = 1;
	ld	hl,#_fat_dir_is_root + 0
	ld	(hl), #0x01
;fat.c:180: fat_sub_dir_clust = 0;
	xor	a, a
	ld	(#_fat_sub_dir_clust + 0),a
	ld	(#_fat_sub_dir_clust + 1),a
	ld	(#_fat_sub_dir_clust + 2),a
	ld	iy,#_fat_sub_dir_clust
	ld	3 (iy),a
	jp	00152$
00104$:
;fat.c:182: fat_dir_is_root = 0;
	ld	hl,#_fat_dir_is_root + 0
	ld	(hl), #0x00
;fat.c:183: sector = fat_cluster_to_sector(entry);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	-24 (ix),l
	ld	-23 (ix),h
	ld	-22 (ix),e
	ld	-21 (ix),d
;fat.c:185: resp = fat_cache_read_dat(sector);
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	push	hl
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	push	hl
	call	_fat_cache_read_dat
	pop	af
	pop	af
;fat.c:186: if (resp)return resp;
	ld	-13 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-13 (ix)
	jp	00137$
00102$:
;fat.c:188: fat_sub_dir_clust = fat_bytes_to_short(&fat_dat[0x34]);
	ld	iy,#0x0034
	ld	de,(_fat_dat)
	add	iy, de
	push	iy
	call	_fat_bytes_to_short
	ld	a,l
	ld	(#_fat_sub_dir_clust + 0),a
	pop	af
	ld	iy,#_fat_sub_dir_clust
	ld	1 (iy),h
	ld	hl,#_fat_sub_dir_clust + 2
	ld	(hl), #0x00
	ld	hl,#_fat_sub_dir_clust + 3
	ld	(hl), #0x00
;fat.c:189: fat_sub_dir_clust <<= 16;
	push	af
	pop	af
	ld	b,#0x10
00187$:
	ld	iy,#_fat_sub_dir_clust
	sla	0 (iy)
	ld	iy,#_fat_sub_dir_clust
	rl	1 (iy)
	ld	iy,#_fat_sub_dir_clust
	rl	2 (iy)
	ld	iy,#_fat_sub_dir_clust
	rl	3 (iy)
	djnz	00187$
;fat.c:190: fat_sub_dir_clust |= fat_bytes_to_short(&fat_dat[0x3a]);
	ld	iy,#0x003A
	ld	de,(_fat_dat)
	add	iy, de
	push	iy
	call	_fat_bytes_to_short
	pop	af
	ex	de,hl
	ld	bc,#0x0000
	ld	a,(#_fat_sub_dir_clust + 0)
	or	a, e
	ld	(#_fat_sub_dir_clust + 0),a
	ld	a,(#_fat_sub_dir_clust + 1)
	or	a, d
	ld	(#_fat_sub_dir_clust + 1),a
	ld	a,(#_fat_sub_dir_clust + 2)
	or	a, c
	ld	(#_fat_sub_dir_clust + 2),a
	ld	a,(#_fat_sub_dir_clust + 3)
	or	a, b
	ld	iy,#_fat_sub_dir_clust
	ld	3 (iy),a
;fat.c:198: for (u = 0; u < fat_cluster_size; u++) {
00152$:
	ld	hl, #12
	add	hl, sp
	ex	de, hl
	ld	hl, #0
	add	hl, sp
	ld	bc, #4
	ldir
	ld	-18 (ix),#0x00
00133$:
	ld	hl,#_fat_cluster_size
	ld	a,-18 (ix)
	sub	a, (hl)
	jp	NC,00127$
;fat.c:201: sector_32 = (u32) sector << 4;
	push	af
	ld	a,-12 (ix)
	ld	-17 (ix),a
	ld	a,-11 (ix)
	ld	-16 (ix),a
	ld	a,-10 (ix)
	ld	-15 (ix),a
	ld	a,-9 (ix)
	ld	-14 (ix),a
	pop	af
	ld	b,#0x04
00189$:
	sla	-17 (ix)
	rl	-16 (ix)
	rl	-15 (ix)
	rl	-14 (ix)
	djnz	00189$
;fat.c:202: resp = fat_cache_read_dat(sector);
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	call	_fat_cache_read_dat
	pop	af
	pop	af
;fat.c:203: if (resp)return resp;
	ld	-13 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00107$
	ld	l,-13 (ix)
	jp	00137$
00107$:
;fat.c:204: ptr = fat_dat;
	ld	hl,(_fat_dat)
	ld	-7 (ix),l
	ld	-6 (ix),h
;fat.c:206: for (i = 0; i < 16; i++, ptr += 32) {
	ld	-20 (ix),#0x00
00131$:
;fat.c:208: if (*ptr == 0)return fat_filter_cover_records();
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	c,(hl)
	ld	a,c
	or	a, a
	jr	NZ,00109$
	call	_fat_filter_cover_records
	jp	00137$
00109$:
;fat.c:209: if (*ptr == 0xe5 || *ptr == 0x2e) {
	ld	a,c
	cp	a,#0xE5
	jr	Z,00110$
	sub	a, #0x2E
	jr	NZ,00111$
00110$:
;fat.c:210: lfn_record = 0;
	ld	-19 (ix),#0x00
;fat.c:211: continue;
	jp	00125$
00111$:
;fat.c:215: if (ptr[0x0B] == 0x0F) {
	ld	a,-7 (ix)
	add	a, #0x0B
	ld	l,a
	ld	a,-6 (ix)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	ld	-8 (ix),a
;fat.c:221: fat_dir[fat_dir_size] = sector_32 | i;
	ld	de,(_fat_dir_size)
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a,-20 (ix)
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
	ld	a,(#_fat_dir + 0)
	add	a, e
	ld	e,a
	ld	a,(#_fat_dir + 1)
	adc	a, d
	ld	d,a
	ld	a,-4 (ix)
	or	a, -17 (ix)
	ld	-4 (ix),a
	ld	a,-3 (ix)
	or	a, -16 (ix)
	ld	-3 (ix),a
	ld	a,-2 (ix)
	or	a, -15 (ix)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	or	a, -14 (ix)
	ld	-1 (ix),a
;fat.c:215: if (ptr[0x0B] == 0x0F) {
	ld	a,-8 (ix)
	sub	a, #0x0F
	jr	NZ,00116$
;fat.c:217: first_char = ptr[1];
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
;fat.c:219: if ((*ptr & 0xF0) == 0x40) {
	ld	a,c
	and	a, #0xF0
	sub	a, #0x40
	jr	NZ,00125$
;fat.c:220: lfn_record = 1;
	ld	-19 (ix),#0x01
;fat.c:221: fat_dir[fat_dir_size] = sector_32 | i;
	ld	hl, #0x0014
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:224: continue;
	jr	00125$
00116$:
;fat.c:227: if ((first_char == (u8) '.' && lfn_record) || (ptr[0x0B] & 0x0A) != 0) {
	ld	a,-5 (ix)
	sub	a, #0x2E
	jr	NZ,00120$
	ld	a,-19 (ix)
	or	a, a
	jr	NZ,00117$
00120$:
	ld	a,-8 (ix)
	and	a, #0x0A
	jr	Z,00118$
00117$:
;fat.c:228: lfn_record = 0;
	ld	-19 (ix),#0x00
;fat.c:229: continue;
	jr	00125$
00118$:
;fat.c:232: if (lfn_record == 0) {
	ld	a,-19 (ix)
	or	a, a
	jr	NZ,00122$
;fat.c:233: fat_dir[fat_dir_size] = sector_32 | i;
	ld	hl, #0x0014
	add	hl, sp
	ld	bc, #0x0004
	ldir
00122$:
;fat.c:238: fat_dir_size++;
	ld	hl, #_fat_dir_size+0
	inc	(hl)
	jr	NZ,00203$
	ld	hl, #_fat_dir_size+1
	inc	(hl)
00203$:
;fat.c:239: lfn_record = 0;
	ld	-19 (ix),#0x00
;fat.c:240: if (fat_dir_size == OS_MAX_DIR_SIZE)return fat_filter_cover_records();
	ld	a,(#_fat_dir_size + 0)
	or	a, a
	jr	NZ,00125$
	ld	a,(#_fat_dir_size + 1)
	sub	a, #0x02
	jr	NZ,00125$
	call	_fat_filter_cover_records
	jr	00137$
00125$:
;fat.c:206: for (i = 0; i < 16; i++, ptr += 32) {
	inc	-20 (ix)
	ld	a,-7 (ix)
	add	a, #0x20
	ld	-7 (ix),a
	ld	a,-6 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
	ld	a,-20 (ix)
	sub	a, #0x10
	jp	C,00131$
;fat.c:243: sector++;
	inc	-12 (ix)
	jr	NZ,00206$
	inc	-11 (ix)
	jr	NZ,00206$
	inc	-10 (ix)
	jr	NZ,00206$
	inc	-9 (ix)
00206$:
;fat.c:198: for (u = 0; u < fat_cluster_size; u++) {
	inc	-18 (ix)
	jp	00133$
00127$:
;fat.c:248: resp = fat_get_next_cluster(&entry);
	ld	hl,#0x001C
	add	hl,sp
	push	hl
	call	_fat_get_next_cluster
	pop	af
;fat.c:249: if (resp)return resp;
	ld	-13 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00129$
	ld	l,-13 (ix)
	jr	00137$
00129$:
;fat.c:252: sector = fat_cluster_to_sector(entry);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	-24 (ix),l
	ld	-23 (ix),h
	ld	-22 (ix),e
	ld	-21 (ix),d
	jp	00152$
00137$:
	ld	sp,ix
	pop	ix
	ret
_fat_load_dir_end::
;fat.c:260: u8 fat_filter_cover_records() {
;	---------------------------------
; Function fat_filter_cover_records
; ---------------------------------
_fat_filter_cover_records_start::
_fat_filter_cover_records:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-18
	add	hl,sp
	ld	sp,hl
;fat.c:267: visible_size = 0;
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x00
;fat.c:268: fat_cov_dir_size = 0;
	ld	hl,#_fat_cov_dir_size + 0
	ld	(hl), #0x00
	ld	hl,#_fat_cov_dir_size + 1
	ld	(hl), #0x00
;fat.c:269: rec = osMallocRam(sizeof (FatFullRecord));
	ld	hl,#0x00E5
	push	hl
	call	_osMallocRam
	pop	af
	ld	-14 (ix),l
	ld	-13 (ix),h
;fat.c:271: for (i = 0; i < fat_dir_size; i++) {
	ld	a,-14 (ix)
	ld	-10 (ix),a
	ld	a,-13 (ix)
	ld	-9 (ix),a
	ld	hl,#0x0000
	ex	(sp), hl
	ld	-16 (ix),#0x00
	ld	-15 (ix),#0x00
00111$:
	ld	hl,#_fat_dir_size
	ld	a,-16 (ix)
	sub	a, (hl)
	ld	a,-15 (ix)
	inc	hl
	sbc	a, (hl)
	jp	NC,00109$
;fat.c:272: resp = fat_get_full_record(fat_dir[i], rec);
	ld	a,-16 (ix)
	ld	-12 (ix),a
	ld	a,-15 (ix)
	ld	-11 (ix),a
	ld	a,#0x02+1
	jr	00134$
00133$:
	sla	-12 (ix)
	rl	-11 (ix)
00134$:
	dec	a
	jr	NZ,00133$
	ld	a,(#_fat_dir + 0)
	add	a, -12 (ix)
	ld	-8 (ix),a
	ld	a,(#_fat_dir + 1)
	adc	a, -11 (ix)
	ld	-7 (ix),a
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	push	bc
	push	de
	call	_fat_get_full_record
	pop	af
	pop	af
	pop	af
;fat.c:273: if (resp) {
	ld	a,l
	or	a, a
	jr	Z,00102$
;fat.c:274: osReleaseRam(sizeof (FatFullRecord));
	push	hl
	ld	bc,#0x00E5
	push	bc
	call	_osReleaseRam
	pop	af
	pop	hl
;fat.c:275: return resp;
	jp	00113$
00102$:
;fat.c:278: if (!rec->is_dir && str_extension(".cov", rec->name)) {
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	de, #0x00E4
	add	hl, de
	ld	a,(hl)
	or	a, a
	jr	NZ,00106$
	ld	hl,#__str_1
	ld	c,-14 (ix)
	ld	b,-13 (ix)
	push	bc
	push	hl
	call	_str_extension
	pop	af
	pop	af
	ld	a,l
	or	a, a
	jr	Z,00106$
;fat.c:279: if (fat_cov_dir_size < FAT_MAX_COV_DIR_SIZE) {
	ld	a,(#_fat_cov_dir_size + 0)
	sub	a, #0x80
	ld	a,(#_fat_cov_dir_size + 1)
	sbc	a, #0x00
	jp	NC,00112$
;fat.c:280: fat_cov_dir[fat_cov_dir_size] = fat_dir[i];
	ld	de,(_fat_cov_dir_size)
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a,(#_fat_cov_dir + 0)
	add	a, e
	ld	e,a
	ld	a,(#_fat_cov_dir + 1)
	adc	a, d
	ld	d,a
	ld	iy,(_fat_dir)
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	add	iy, bc
	ld	a,0 (iy)
	ld	-4 (ix),a
	ld	a,1 (iy)
	ld	-3 (ix),a
	ld	a,2 (iy)
	ld	-2 (ix),a
	ld	a,3 (iy)
	ld	-1 (ix),a
	ld	hl, #0x000E
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:281: fat_cov_dir_size++;
	ld	hl, #_fat_cov_dir_size+0
	inc	(hl)
	jr	NZ,00112$
	ld	hl, #_fat_cov_dir_size+1
	inc	(hl)
	jr	00112$
00106$:
;fat.c:284: fat_dir[visible_size] = fat_dir[i];
	pop	de
	push	de
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
	ld	iy,(_fat_dir)
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	add	iy, bc
	ld	a,0 (iy)
	ld	-4 (ix),a
	ld	a,1 (iy)
	ld	-3 (ix),a
	ld	a,2 (iy)
	ld	-2 (ix),a
	ld	a,3 (iy)
	ld	-1 (ix),a
	ld	hl, #0x000E
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:285: visible_size++;
	inc	-18 (ix)
	jr	NZ,00140$
	inc	-17 (ix)
00140$:
	ld	a,-18 (ix)
	ld	-6 (ix),a
	ld	a,-17 (ix)
	ld	-5 (ix),a
00112$:
;fat.c:271: for (i = 0; i < fat_dir_size; i++) {
	inc	-16 (ix)
	jp	NZ,00111$
	inc	-15 (ix)
	jp	00111$
00109$:
;fat.c:289: fat_dir_size = visible_size;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(_fat_dir_size),hl
;fat.c:290: osReleaseRam(sizeof (FatFullRecord));
	ld	hl,#0x00E5
	push	hl
	call	_osReleaseRam
	pop	af
;fat.c:291: return 0;
	ld	l,#0x00
00113$:
	ld	sp,ix
	pop	ix
	ret
_fat_filter_cover_records_end::
__str_1:
	.ascii ".cov"
	.db 0x00
;fat.c:294: u32 fat_cluster_to_sector(u32 cluster) {
;	---------------------------------
; Function fat_cluster_to_sector
; ---------------------------------
_fat_cluster_to_sector_start::
_fat_cluster_to_sector:
;fat.c:297: val = cluster - 2;
	ld	hl,#_fat_cluster_to_sector_val_1_113
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	add	a,#0xFE
	ld	(hl),a
	ld	a,1 (iy)
	adc	a,#0xFF
	inc	hl
	ld	(hl),a
	ld	a,2 (iy)
	adc	a,#0xFF
	inc	hl
	ld	(hl),a
	ld	a,3 (iy)
	adc	a,#0xFF
	inc	hl
	ld	(hl),a
;fat.c:298: val <<= fat_cluster_size_pow;
	ld	hl,#_fat_cluster_size_pow + 0
	ld	b, (hl)
	push	af
	pop	af
	inc	b
	jr	00104$
00103$:
	ld	iy,#_fat_cluster_to_sector_val_1_113
	sla	0 (iy)
	ld	iy,#_fat_cluster_to_sector_val_1_113
	rl	1 (iy)
	ld	iy,#_fat_cluster_to_sector_val_1_113
	rl	2 (iy)
	ld	iy,#_fat_cluster_to_sector_val_1_113
	rl	3 (iy)
00104$:
	djnz	00103$
;fat.c:299: val += fat_data_entry;
	ld	hl,#_fat_data_entry
	push	de
	ld	iy,#_fat_cluster_to_sector_val_1_113
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
	inc	de
	ld	a,(de)
	inc	hl
	adc	a, (hl)
	ld	(de),a
	inc	de
	ld	a,(de)
	inc	hl
	adc	a, (hl)
	ld	(de),a
	pop	de
;fat.c:301: return val;
	ld	iy,#_fat_cluster_to_sector_val_1_113
	ld	l,0 (iy)
	ld	iy,#_fat_cluster_to_sector_val_1_113
	ld	h,1 (iy)
	ld	iy,#_fat_cluster_to_sector_val_1_113
	ld	e,2 (iy)
	ld	iy,#_fat_cluster_to_sector_val_1_113
	ld	d,3 (iy)
	ret
_fat_cluster_to_sector_end::
;fat.c:306: u32 fat_sector_to_cluster(u32 sector) {
;	---------------------------------
; Function fat_sector_to_cluster
; ---------------------------------
_fat_sector_to_cluster_start::
_fat_sector_to_cluster:
;fat.c:310: val = sector - fat_data_entry;
	ld	hl,#_fat_data_entry
	push	de
	ld	de,#_fat_sector_to_cluster_val_1_115
	ld	iy,#4
	add	iy,sp
	ld	a,0 (iy)
	sub	a, (hl)
	ld	(de),a
	ld	a,1 (iy)
	inc	hl
	sbc	a, (hl)
	inc	de
	ld	(de),a
	ld	a,2 (iy)
	inc	hl
	sbc	a, (hl)
	inc	de
	ld	(de),a
	ld	a,3 (iy)
	inc	hl
	sbc	a, (hl)
	inc	de
	ld	(de),a
	pop	de
;fat.c:311: val >>= fat_cluster_size_pow;
	ld	hl,#_fat_cluster_size_pow + 0
	ld	b, (hl)
	push	af
	pop	af
	inc	b
	jr	00104$
00103$:
	ld	iy,#_fat_sector_to_cluster_val_1_115
	srl	3 (iy)
	ld	iy,#_fat_sector_to_cluster_val_1_115
	rr	2 (iy)
	ld	iy,#_fat_sector_to_cluster_val_1_115
	rr	1 (iy)
	ld	iy,#_fat_sector_to_cluster_val_1_115
	rr	0 (iy)
00104$:
	djnz	00103$
;fat.c:312: val += 2;
	ld	hl,#_fat_sector_to_cluster_val_1_115
	ld	a,(hl)
	add	a, #0x02
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, #0x00
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, #0x00
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a, #0x00
	ld	(hl),a
;fat.c:314: return val;
	ld	iy,#_fat_sector_to_cluster_val_1_115
	ld	l,0 (iy)
	ld	iy,#_fat_sector_to_cluster_val_1_115
	ld	h,1 (iy)
	ld	iy,#_fat_sector_to_cluster_val_1_115
	ld	e,2 (iy)
	ld	iy,#_fat_sector_to_cluster_val_1_115
	ld	d,3 (iy)
	ret
_fat_sector_to_cluster_end::
;fat.c:319: u8 fat_in_cluster_addr(u32 sector) {
;	---------------------------------
; Function fat_in_cluster_addr
; ---------------------------------
_fat_in_cluster_addr_start::
_fat_in_cluster_addr:
	push	ix
	ld	ix,#0
	add	ix,sp
;fat.c:321: sector -= fat_data_entry;
	ld	hl,#_fat_data_entry
	ld	a,4 (ix)
	sub	a, (hl)
	ld	4 (ix),a
	ld	a,5 (ix)
	inc	hl
	sbc	a, (hl)
	ld	5 (ix),a
	ld	a,6 (ix)
	inc	hl
	sbc	a, (hl)
	ld	6 (ix),a
	ld	a,7 (ix)
	inc	hl
	sbc	a, (hl)
	ld	7 (ix),a
;fat.c:322: return sector & (fat_cluster_size - 1);
	ld	hl,#_fat_cluster_size + 0
	ld	e, (hl)
	dec	e
	ld	h,#0x00
	ld	c,#0x00
	ld	d,#0x00
	ld	a,4 (ix)
	and	a, e
	ld	l,a
	ld	a,5 (ix)
	and	a, h
	ld	a,6 (ix)
	and	a, c
	ld	a,7 (ix)
	and	a, d
	pop	ix
	ret
_fat_in_cluster_addr_end::
;fat.c:325: u8 fat_get_table_record(u32 cluster, u32 *val) {
;	---------------------------------
; Function fat_get_table_record
; ---------------------------------
_fat_get_table_record_start::
_fat_get_table_record:
	push	ix
	ld	ix,#0
	add	ix,sp
;fat.c:331: table_sector = cluster / 128;
	push	af
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	pop	af
	ld	b,#0x07
00108$:
	srl	d
	rr	e
	rr	h
	rr	l
	djnz	00108$
;fat.c:332: resp = fat_cache_read_tab(table_sector);
	push	de
	push	hl
	call	_fat_cache_read_tab
	pop	af
	pop	af
;fat.c:333: if (resp)return resp;
	ld	a,l
	or	a, a
	jr	NZ,00103$
;fat.c:335: ptr = &fat_tab[(cluster & 127) * 4];
	ld	e,4 (ix)
	res	7, e
	ld	d,#0x00
	ld	bc,#0x0000
	ld	a,#0x02
00110$:
	sla	e
	rl	d
	rl	c
	rl	b
	dec	a
	jr	NZ,00110$
	ld	a,(#_fat_tab + 0)
	add	a, e
	ld	e,a
	ld	a,(#_fat_tab + 1)
	adc	a, d
	ld	d,a
;fat.c:336: fat_bytes_to_int_le(ptr, val);
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	push	de
	call	_fat_bytes_to_int_le
	pop	af
	pop	af
;fat.c:339: return 0;
	ld	l,#0x00
00103$:
	pop	ix
	ret
_fat_get_table_record_end::
;fat.c:343: u8 fat_get_next_cluster(u32 *cluster) {
;	---------------------------------
; Function fat_get_next_cluster
; ---------------------------------
_fat_get_next_cluster_start::
_fat_get_next_cluster:
	push	ix
	ld	ix,#0
	add	ix,sp
;fat.c:347: resp = fat_get_table_record(*cluster, cluster);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	bc
	push	de
	call	_fat_get_table_record
	pop	af
	pop	af
	pop	af
;fat.c:350: return resp;
	pop	ix
	ret
_fat_get_next_cluster_end::
;fat.c:353: u8 fat_get_full_record(u32 hdr_entry, FatFullRecord *rec) {
;	---------------------------------
; Function fat_get_full_record
; ---------------------------------
_fat_get_full_record_start::
_fat_get_full_record:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-37
	add	hl,sp
	ld	sp,hl
;fat.c:360: u8 *rec_name = (u8 *) rec->name;
	ld	a,8 (ix)
	ld	-6 (ix),a
	ld	a,9 (ix)
	ld	-5 (ix),a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	-23 (ix),l
	ld	-22 (ix),h
;fat.c:363: u8 rec_idx = hdr_entry & 0x0f;
	ld	a,4 (ix)
	and	a, #0x0F
	ld	-21 (ix), a
;fat.c:364: u32 sector = (u32) hdr_entry >> 4;
	push	af
	ld	a,4 (ix)
	ld	-37 (ix),a
	ld	a,5 (ix)
	ld	-36 (ix),a
	ld	a,6 (ix)
	ld	-35 (ix),a
	ld	a,7 (ix)
	ld	-34 (ix),a
	pop	af
	ld	b,#0x04
00175$:
	srl	-34 (ix)
	rr	-35 (ix)
	rr	-36 (ix)
	rr	-37 (ix)
	djnz	00175$
;fat.c:365: u32 cluster = fat_sector_to_cluster(sector);
	ld	l,-35 (ix)
	ld	h,-34 (ix)
	push	hl
	ld	l,-37 (ix)
	ld	h,-36 (ix)
	push	hl
	call	_fat_sector_to_cluster
	pop	af
	pop	af
	ld	-27 (ix),l
	ld	-26 (ix),h
	ld	-25 (ix),e
	ld	-24 (ix),d
;fat.c:366: u8 in_cluster = fat_in_cluster_addr(sector);
	ld	l,-35 (ix)
	ld	h,-34 (ix)
	push	hl
	ld	l,-37 (ix)
	ld	h,-36 (ix)
	push	hl
	call	_fat_in_cluster_addr
	pop	af
	pop	af
	ld	-20 (ix),l
;fat.c:369: ptr = (u8 *) & fat_dat[rec_idx * 32];
	ld	a,-21 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	a,#0x05+1
	jr	00178$
00177$:
	sla	-9 (ix)
	rl	-8 (ix)
00178$:
	dec	a
	jr	NZ,00177$
	ld	a,(#_fat_dat + 0)
	add	a, -9 (ix)
	ld	-33 (ix),a
	ld	a,(#_fat_dat + 1)
	adc	a, -8 (ix)
	ld	-32 (ix),a
;fat.c:371: rec_name[0] = 0;
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	ld	(hl),#0x00
;fat.c:372: rec_name[208] = 0;
	ld	a,-23 (ix)
	add	a, #0xD0
	ld	l,a
	ld	a,-22 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x00
;fat.c:373: rec->hdr_entry = hdr_entry;
	ld	a,-6 (ix)
	add	a, #0xD4
	ld	e,a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	d,a
	ld	hl, #0x0029
	add	hl, sp
	ld	bc, #0x0004
	ldir
00124$:
;fat.c:378: resp = fat_cache_read_dat(sector);
	ld	l,-35 (ix)
	ld	h,-34 (ix)
	push	hl
	ld	l,-37 (ix)
	ld	h,-36 (ix)
	push	hl
	call	_fat_cache_read_dat
	pop	af
	pop	af
;fat.c:379: if (resp)return resp;
	ld	-28 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00136$
	ld	l,-28 (ix)
	jp	00128$
00136$:
	ld	a,-33 (ix)
	ld	-9 (ix),a
	ld	a,-32 (ix)
	ld	-8 (ix),a
	ld	a,-21 (ix)
	ld	-7 (ix),a
00122$:
;fat.c:382: for (; rec_idx < 16; rec_idx++) {
	ld	a,-7 (ix)
	sub	a, #0x10
	jp	NC,00146$
;fat.c:383: if (ptr[0x0B] != 0x0F)break;
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	de, #0x000B
	add	hl, de
	ld	a,(hl)
	sub	a, #0x0F
	jp	NZ,00146$
;fat.c:385: name_ptr = (u8 *) & rec_name[((*ptr - 1) & 0x0f) * 13];
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	e,(hl)
	ld	l,e
	ld	h,#0x00
	dec	hl
	ld	a,l
	and	a, #0x0F
	ld	l,a
	ld	h,#0x00
	ld	c, l
	ld	b, h
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c,-23 (ix)
	ld	b,-22 (ix)
	add	hl,bc
	ld	-31 (ix),l
	ld	-30 (ix),h
;fat.c:386: if ((*ptr & 0x40) == 0x40)name_ptr[13] = 0;
	ld	a,e
	and	a, #0x40
	sub	a, #0x40
	jr	NZ,00106$
	ld	a,-31 (ix)
	add	a, #0x0D
	ld	-11 (ix),a
	ld	a,-30 (ix)
	adc	a, #0x00
	ld	-10 (ix),a
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	(hl),#0x00
00106$:
;fat.c:388: lfn_struct_ptr = (u8*) lfn_char_struct;
	ld	iy,#_lfn_char_struct
;fat.c:389: for (i = 0; i < 13; i++)*name_ptr++ = ptr[*lfn_struct_ptr++];
	ld	e,-31 (ix)
	ld	d,-30 (ix)
	ld	b,#0x00
00119$:
	ld	h, 0 (iy)
	inc	iy
	ld	a,-9 (ix)
	add	a, h
	ld	l,a
	ld	a,-8 (ix)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	b
	ld	a,b
	sub	a, #0x0D
	jr	C,00119$
;fat.c:391: ptr += 32;
	ld	a,-9 (ix)
	add	a, #0x20
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a, #0x00
	ld	-8 (ix),a
;fat.c:382: for (; rec_idx < 16; rec_idx++) {
	inc	-7 (ix)
	jp	00122$
00146$:
	ld	a,-9 (ix)
	ld	-33 (ix),a
	ld	a,-8 (ix)
	ld	-32 (ix),a
	ld	a,-7 (ix)
	ld	-21 (ix),a
;fat.c:393: if (rec_idx != 16)break;
	ld	a,-7 (ix)
	sub	a, #0x10
	jr	NZ,00115$
;fat.c:395: rec_idx = 0;
	ld	-21 (ix),#0x00
;fat.c:396: ptr = (u8 *) fat_dat;
	ld	hl,(_fat_dat)
	ld	-33 (ix),l
	ld	-32 (ix),h
;fat.c:397: in_cluster++;
	inc	-20 (ix)
;fat.c:398: sector++;
	inc	-37 (ix)
	jr	NZ,00185$
	inc	-36 (ix)
	jr	NZ,00185$
	inc	-35 (ix)
	jr	NZ,00185$
	inc	-34 (ix)
00185$:
;fat.c:400: if (in_cluster == fat_cluster_size) {
	ld	a,-20 (ix)
	ld	iy,#_fat_cluster_size
	sub	a, 0 (iy)
	jp	NZ,00124$
;fat.c:402: resp = fat_get_next_cluster(&cluster);
	ld	hl,#0x000A
	add	hl,sp
	push	hl
	call	_fat_get_next_cluster
	pop	af
;fat.c:403: if (resp)return resp;
	ld	-28 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00112$
	ld	l,-28 (ix)
	jp	00128$
00112$:
;fat.c:405: sector = fat_cluster_to_sector(cluster);
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	push	hl
	ld	l,-27 (ix)
	ld	h,-26 (ix)
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	-37 (ix),l
	ld	-36 (ix),h
	ld	-35 (ix),e
	ld	-34 (ix),d
;fat.c:406: in_cluster = 0;
	ld	-20 (ix),#0x00
	jp	00124$
00115$:
;fat.c:411: if (rec_name[0] == 0) {
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	ld	a,(hl)
	ld	-11 (ix), a
	or	a, a
	jr	NZ,00118$
;fat.c:412: for (i = 0; i < 11; i++)rec_name[i] = ptr[i];
	ld	-29 (ix),#0x00
00126$:
	ld	a,-23 (ix)
	add	a, -29 (ix)
	ld	-11 (ix),a
	ld	a,-22 (ix)
	adc	a, #0x00
	ld	-10 (ix),a
	ld	a,-33 (ix)
	add	a, -29 (ix)
	ld	-9 (ix),a
	ld	a,-32 (ix)
	adc	a, #0x00
	ld	-8 (ix),a
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	(hl),a
	inc	-29 (ix)
	ld	a,-29 (ix)
	sub	a, #0x0B
	jr	C,00126$
;fat.c:413: rec_name[i] = 0;
	ld	a,-23 (ix)
	add	a, -29 (ix)
	ld	l,a
	ld	a,-22 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x00
00118$:
;fat.c:416: rec->hdr_entry_8 = (sector << 4) | rec_idx;
	ld	a,-6 (ix)
	add	a, #0xD8
	ld	-11 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-10 (ix),a
	push	af
	ld	a,-37 (ix)
	ld	-15 (ix),a
	ld	a,-36 (ix)
	ld	-14 (ix),a
	ld	a,-35 (ix)
	ld	-13 (ix),a
	ld	a,-34 (ix)
	ld	-12 (ix),a
	pop	af
	ld	b,#0x04
00188$:
	sla	-15 (ix)
	rl	-14 (ix)
	rl	-13 (ix)
	rl	-12 (ix)
	djnz	00188$
	ld	a,-21 (ix)
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
	ld	a,-4 (ix)
	or	a, -15 (ix)
	ld	-4 (ix),a
	ld	a,-3 (ix)
	or	a, -14 (ix)
	ld	-3 (ix),a
	ld	a,-2 (ix)
	or	a, -13 (ix)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	or	a, -12 (ix)
	ld	-1 (ix),a
	ld	e,-11 (ix)
	ld	d,-10 (ix)
	ld	hl, #0x0021
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:418: rec->is_dir = ptr[0x0B] & 0x10;
	ld	a,-6 (ix)
	add	a, #0xE4
	ld	-4 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
	ld	a,-33 (ix)
	ld	-15 (ix),a
	ld	a,-32 (ix)
	ld	-14 (ix),a
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	ld	de, #0x000B
	add	hl, de
	ld	a,(hl)
	ld	-15 (ix), a
	and	a, #0x10
	ld	-15 (ix),a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,-15 (ix)
	ld	(hl),a
;fat.c:421: rec->data_clsut = fat_bytes_to_short(&ptr[0x14]);
	ld	a,-6 (ix)
	add	a, #0xDC
	ld	-4 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
	ld	a,-33 (ix)
	add	a, #0x14
	ld	-15 (ix),a
	ld	a,-32 (ix)
	adc	a, #0x00
	ld	-14 (ix),a
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	call	_fat_bytes_to_short
	pop	af
	ld	-14 (ix),h
	ld	-15 (ix), l
	ld	d, l
	ld	b,-14 (ix)
	ld	e,#0x00
	ld	c,#0x00
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),d
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),c
;fat.c:422: rec->data_clsut <<= 16;
	push	af
	ld	-15 (ix),d
	ld	-14 (ix),b
	ld	-13 (ix),e
	ld	-12 (ix),c
	pop	af
	ld	a,#0x10
00190$:
	sla	-15 (ix)
	rl	-14 (ix)
	rl	-13 (ix)
	rl	-12 (ix)
	dec	a
	jr	NZ,00190$
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	ld	hl, #0x0016
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:423: rec->data_clsut |= fat_bytes_to_short(&ptr[0x1a]);
	ld	a,-33 (ix)
	add	a, #0x1A
	ld	-11 (ix),a
	ld	a,-32 (ix)
	adc	a, #0x00
	ld	-10 (ix),a
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	_fat_bytes_to_short
	pop	af
	ld	-10 (ix),h
	ld	-11 (ix), l
	ld	-19 (ix), l
	ld	a,-10 (ix)
	ld	-18 (ix),a
	ld	-17 (ix),#0x00
	ld	-16 (ix),#0x00
	ld	a,-19 (ix)
	or	a, -15 (ix)
	ld	-19 (ix),a
	ld	a,-18 (ix)
	or	a, -14 (ix)
	ld	-18 (ix),a
	ld	a,-17 (ix)
	or	a, -13 (ix)
	ld	-17 (ix),a
	ld	a,-16 (ix)
	or	a, -12 (ix)
	ld	-16 (ix),a
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	ld	hl, #0x0012
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:426: fat_bytes_to_int_le(&ptr[0x1c], &rec->size);
	ld	a,-6 (ix)
	add	a, #0xE0
	ld	-19 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-18 (ix),a
	ld	a,-33 (ix)
	add	a, #0x1C
	ld	-4 (ix),a
	ld	a,-32 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_fat_bytes_to_int_le
	pop	af
	pop	af
;fat.c:429: return 0;
	ld	l,#0x00
00128$:
	ld	sp,ix
	pop	ix
	ret
_fat_get_full_record_end::
;fat.c:433: u8 fat_open_file(FatFullRecord *rec, u16 wr_slen) {
;	---------------------------------
; Function fat_open_file
; ---------------------------------
_fat_open_file_start::
_fat_open_file:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;fat.c:437: if (rec->is_dir)return FAT_ERR_NOT_FILE;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	de, #0x00E4
	add	hl, de
	ld	a,(hl)
	ld	-3 (ix), a
	or	a, a
	jr	Z,00102$
	ld	l,#0xF5
	jp	00113$
00102$:
;fat.c:439: file.size = rec->size;
	ld	a,-2 (ix)
	add	a, #0xE0
	ld	-5 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-4 (ix),a
	ld	e,-5 (ix)
	ld	d,-4 (ix)
	ld	hl, #0x0001
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	de,#(_file + 0x0008)
	ld	hl, #0x0001
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:440: file.sec_available = file.size / 512;
	push	af
	ld	e,-9 (ix)
	ld	d,-8 (ix)
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	pop	af
	ld	b,#0x09
00138$:
	srl	h
	rr	l
	rr	d
	rr	e
	djnz	00138$
	ld	((_file + 0x000c)), de
;fat.c:441: if ((file.size & 511) != 0)file.sec_available++;
	ld	a,-9 (ix)
	or	a, a
	jr	NZ,00140$
	bit	0, -8 (ix)
	jr	Z,00104$
00140$:
	ld	de, (#(_file + 0x000c) + 0)
	inc	de
	ld	((_file + 0x000c)), de
00104$:
;fat.c:443: if (wr_slen > file.sec_available) {
	ld	hl, (#(_file + 0x000c) + 0)
	ld	a,l
	sub	a, 6 (ix)
	ld	a,h
	sbc	a, 7 (ix)
	jr	NC,00110$
;fat.c:444: resp = fat_resize_file(rec, wr_slen);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_fat_resize_file
	pop	af
	pop	af
;fat.c:445: if (resp)return resp;
	ld	-10 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00106$
	ld	l,-10 (ix)
	jp	00113$
00106$:
;fat.c:446: resp = fat_get_full_record(rec->hdr_entry, rec);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	de, #0x00D4
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	push	bc
	push	de
	call	_fat_get_full_record
	pop	af
	pop	af
	pop	af
;fat.c:447: if (resp)return resp;
	ld	-10 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00110$
	ld	l,-10 (ix)
	jp	00113$
00110$:
;fat.c:451: file.cluster = rec->data_clsut;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	de, #0x00DC
	add	hl, de
	ld	a,(hl)
	ld	-9 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-8 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-7 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-6 (ix),a
	ld	de,#_file
	ld	hl, #0x0001
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:452: file.sector = fat_cluster_to_sector(file.cluster);
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	push	hl
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	-6 (ix),d
	ld	-7 (ix),e
	ld	-8 (ix),h
	ld	-9 (ix),l
	ld	de,#(_file + 0x0004)
	ld	hl, #0x0001
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:453: file.in_cluster = 0;
	ld	hl,#(_file + 0x000f)
	ld	(hl),#0x00
;fat.c:454: file.size = rec->size;
	ld	e,-5 (ix)
	ld	d,-4 (ix)
	ld	hl, #0x0001
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	de,#(_file + 0x0008)
	ld	hl, #0x0001
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:455: file.wr_slen = wr_slen ? 1 : 0;
	ld	a,7 (ix)
	or	a,6 (ix)
	jr	Z,00115$
	ld	-9 (ix),#0x01
	jr	00116$
00115$:
	ld	-9 (ix),#0x00
00116$:
	ld	hl,#(_file + 0x000e)
	ld	a,-9 (ix)
	ld	(hl),a
;fat.c:456: file.sec_available = file.size / 512;
	ld	de,#(_file + 0x0008)
	ld	hl, #0x0001
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	push	af
	pop	af
	ld	b,#0x09
00141$:
	srl	-6 (ix)
	rr	-7 (ix)
	rr	-8 (ix)
	rr	-9 (ix)
	djnz	00141$
	ld	a,-9 (ix)
	ld	-9 (ix),a
	ld	a,-8 (ix)
	ld	-8 (ix),a
	ld	hl,#(_file + 0x000c)
	ld	a,-9 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-8 (ix)
	ld	(hl),a
;fat.c:457: if ((file.size & 511) != 0)file.sec_available++;
	ld	de,#(_file + 0x0008)
	ld	hl, #0x0001
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	a,-9 (ix)
	or	a, a
	jr	NZ,00143$
	bit	0, -8 (ix)
	jr	Z,00112$
00143$:
	ld	de, (#(_file + 0x000c) + 0)
	inc	de
	ld	((_file + 0x000c)), de
00112$:
;fat.c:460: return 0;
	ld	l,#0x00
00113$:
	ld	sp,ix
	pop	ix
	ret
_fat_open_file_end::
;fat.c:463: u8 fat_skip_sectors(u16 slen) {
;	---------------------------------
; Function fat_skip_sectors
; ---------------------------------
_fat_skip_sectors_start::
_fat_skip_sectors:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;fat.c:466: if (file.sec_available < slen)return FAT_ERR_OUT_OF_FILE;
	ld	hl, #(_file + 0x000c) + 0
	ld	a,(hl)
	ld	-2 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-1 (ix),a
	ld	a,-2 (ix)
	sub	a, 4 (ix)
	ld	a,-1 (ix)
	sbc	a, 5 (ix)
	jr	NC,00102$
	ld	l,#0xF3
	jp	00110$
00102$:
;fat.c:467: file.sec_available -= slen;
	ld	a,-2 (ix)
	sub	a, 4 (ix)
	ld	e,a
	ld	a,-1 (ix)
	sbc	a, 5 (ix)
	ld	d,a
	ld	((_file + 0x000c)), de
;fat.c:469: while (slen) {
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
00107$:
	ld	a,-1 (ix)
	or	a,-2 (ix)
	jr	Z,00109$
;fat.c:471: file.sector++;
	ld	de, (#(_file + 0x0004) + 0)
	ld	bc, (#(_file + 0x0004) + 2)
	inc	e
	jr	NZ,00127$
	inc	d
	jr	NZ,00127$
	inc	c
	jr	NZ,00127$
	inc	b
00127$:
	ld	((_file + 0x0004)), de
	ld	((_file + 0x0004) + 2), bc
;fat.c:472: file.in_cluster++;
	ld	de,#_file + 15
	ld	a,(de)
	ld	b,a
	inc	b
	ld	a,b
	ld	(de),a
;fat.c:473: slen--;
	pop	hl
	push	hl
	dec	hl
	ex	(sp), hl
;fat.c:475: if (file.in_cluster == fat_cluster_size) {
	ld	iy,#_fat_cluster_size
	ld	a,0 (iy)
	sub	a, b
	jr	NZ,00107$
;fat.c:476: file.in_cluster = 0;
	xor	a, a
	ld	(de),a
;fat.c:477: resp = fat_get_next_cluster(&file.cluster);
	ld	hl,#_file
	push	hl
	call	_fat_get_next_cluster
	pop	af
;fat.c:478: if (resp)return resp;
	ld	a,l
	or	a, a
	jr	NZ,00110$
;fat.c:479: file.sector = fat_cluster_to_sector(file.cluster);
	ld	hl, (#_file + 0)
	ld	de, (#_file + 2)
	push	de
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	ld	((_file + 0x0004)), bc
	ld	((_file + 0x0004) + 2), de
	jr	00107$
00109$:
;fat.c:484: return 0;
	ld	l,#0x00
00110$:
	ld	sp,ix
	pop	ix
	ret
_fat_skip_sectors_end::
;fat.c:487: u8 fat_read(u8 *dst, u16 slen, u8 memory) {
;	---------------------------------
; Function fat_read
; ---------------------------------
_fat_read_start::
_fat_read:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;fat.c:491: if (file.wr_slen)return FAT_ERR_FILE_MODE1;
	ld	hl, #_file + 14
	ld	c,(hl)
	ld	a,c
	or	a, a
	jr	Z,00102$
	ld	l,#0xF7
	jp	00125$
00102$:
;fat.c:492: if (file.sec_available < slen)return FAT_ERR_OUT_OF_FILE;
	ld	hl, (#(_file + 0x000c) + 0)
	ld	a,l
	sub	a, 6 (ix)
	ld	a,h
	sbc	a, 7 (ix)
	jr	NC,00104$
	ld	l,#0xF3
	jp	00125$
00104$:
;fat.c:493: file.sec_available -= slen;
	ld	a,l
	sub	a, 6 (ix)
	ld	e,a
	ld	a,h
	sbc	a, 7 (ix)
	ld	d,a
	ld	((_file + 0x000c)), de
;fat.c:495: while (slen) {
00122$:
	ld	a,7 (ix)
	or	a,6 (ix)
	jp	Z,00124$
;fat.c:498: if (file.in_cluster == 0) {
	ld	hl, #(_file + 0x000f) + 0
	ld	c,(hl)
;fat.c:499: len = slen > fat_cluster_size ? fat_cluster_size : slen;
	ld	e,6 (ix)
	ld	d,7 (ix)
;fat.c:498: if (file.in_cluster == 0) {
	ld	a,c
	or	a, a
	jr	NZ,00108$
;fat.c:499: len = slen > fat_cluster_size ? fat_cluster_size : slen;
	ld	iy,#_fat_cluster_size
	ld	c,0 (iy)
	ld	h,#0x00
	ld	a,c
	sub	a, 6 (ix)
	ld	a,h
	sbc	a, 7 (ix)
	jr	NC,00127$
	ld	e,c
	jr	00128$
00127$:
	ld	h,d
00128$:
	ld	-8 (ix),e
	ld	-7 (ix),h
	jr	00109$
00108$:
;fat.c:501: len = fat_cluster_size - file.in_cluster;
	ld	iy,#_fat_cluster_size
	ld	l,0 (iy)
	ld	h,#0x00
	ld	b,#0x00
	cp	a, a
	sbc	hl, bc
	ld	-8 (ix),l
	ld	-7 (ix),h
;fat.c:502: if (len > slen)len = slen;
	ld	a,6 (ix)
	sub	a, -8 (ix)
	ld	a,7 (ix)
	sbc	a, -7 (ix)
	jr	NC,00109$
	ld	-8 (ix),e
	ld	-7 (ix),d
00109$:
;fat.c:506: resp = diskReadToRom(file.sector, dst, len);
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
	ld	de,#(_file + 0x0004)
	ld	hl, #0x0003
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
;fat.c:505: if (memory == ROM) {
	ld	a,8 (ix)
	or	a, a
	jr	NZ,00111$
;fat.c:506: resp = diskReadToRom(file.sector, dst, len);
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	call	_diskReadToRom
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-9 (ix),l
;fat.c:507: *((u16 *) dst) = *((u16 *) dst) + len;
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	e,(hl)
	inc	hl
	ld	b,(hl)
	pop	hl
	ld	a,-8 (ix)
	add	a, e
	ld	d,a
	ld	a,-7 (ix)
	adc	a, b
	ld	e,a
	ld	(hl),d
	inc	hl
	ld	(hl),e
	jr	00112$
00111$:
;fat.c:509: resp = diskReadToRam(file.sector, dst, len);
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	call	_diskReadToRam
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-9 (ix),l
;fat.c:510: dst += len * 512;
	ld	a,-8 (ix)
	add	a, a
	ld	l,a
	ld	h,#0x00
	ld	a,4 (ix)
	add	a, h
	ld	4 (ix),a
	ld	a,5 (ix)
	adc	a, l
	ld	5 (ix),a
00112$:
;fat.c:512: if (resp)return resp;
	ld	a,-9 (ix)
	or	a, a
	jr	Z,00114$
	ld	l,-9 (ix)
	jp	00125$
00114$:
;fat.c:514: file.in_cluster += len;
	ld	hl, #(_file + 0x000f) + 0
	ld	h,(hl)
	ld	l,-8 (ix)
	ld	a,h
	add	a, l
	ld	d,a
	ld	hl,#(_file + 0x000f)
	ld	(hl),d
;fat.c:516: slen -= len;
	ld	a,6 (ix)
	sub	a, -8 (ix)
	ld	6 (ix),a
	ld	a,7 (ix)
	sbc	a, -7 (ix)
	ld	7 (ix),a
;fat.c:518: if (file.in_cluster == fat_cluster_size) {
	ld	iy,#_fat_cluster_size
	ld	a,0 (iy)
;fat.c:519: file.in_cluster = 0;
	sub	a,d
	jr	NZ,00120$
	ld	(hl),a
;fat.c:520: resp = fat_get_next_cluster(&file.cluster);
	ld	hl,#_file
	push	hl
	call	_fat_get_next_cluster
	pop	af
;fat.c:521: if (resp)return resp;
	ld	-9 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00116$
	ld	l,-9 (ix)
	jr	00125$
00116$:
;fat.c:522: file.sector = fat_cluster_to_sector(file.cluster);
	ld	hl, (#_file + 0)
	ld	de, (#_file + 2)
	push	de
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	ld	((_file + 0x0004)), bc
	ld	((_file + 0x0004) + 2), de
;fat.c:523: if (resp)return resp;
	ld	a,-9 (ix)
	or	a, a
	jp	Z,00122$
	ld	l,-9 (ix)
	jr	00125$
00120$:
;fat.c:525: file.sector += len;
	ld	de,#(_file + 0x0004)
	ld	hl, #0x0003
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	de,#0x0000
	ld	a,-6 (ix)
	add	a, l
	ld	c,a
	ld	a,-5 (ix)
	adc	a, h
	ld	b,a
	ld	a,-4 (ix)
	adc	a, e
	ld	e,a
	ld	a,-3 (ix)
	adc	a, d
	ld	d,a
	ld	((_file + 0x0004)), bc
	ld	((_file + 0x0004) + 2), de
	jp	00122$
00124$:
;fat.c:529: return 0;
	ld	l,#0x00
00125$:
	ld	sp,ix
	pop	ix
	ret
_fat_read_end::
;fat.c:532: void fat_make_path_name(u8 *dst, u8 *dir, u8 *filename) {
;	---------------------------------
; Function fat_make_path_name
; ---------------------------------
_fat_make_path_name_start::
_fat_make_path_name:
	push	ix
	ld	ix,#0
	add	ix,sp
;fat.c:534: dst[0] = 0;
	ld	e,4 (ix)
	ld	d,5 (ix)
	xor	a, a
	ld	(de),a
;fat.c:535: str_append(dst, dir);
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	de
	call	_str_append
	pop	af
	pop	af
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_str_length
	pop	af
	pop	de
	dec	l
	jr	Z,00102$
	ld	hl,#__str_2
	push	de
	push	hl
	push	de
	call	_str_append
	pop	af
	pop	af
	pop	de
00102$:
;fat.c:537: str_append(dst, filename);
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	push	de
	call	_str_append
	pop	af
	pop	af
	pop	ix
	ret
_fat_make_path_name_end::
__str_2:
	.ascii "/"
	.db 0x00
;fat.c:540: void fat_make_sync_name(u8 *dir, u8 *filename, u8 *ext, u8 *dst) {
;	---------------------------------
; Function fat_make_sync_name
; ---------------------------------
_fat_make_sync_name_start::
_fat_make_sync_name:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;fat.c:542: u8 ext_exist = 0;
	ld	-1 (ix),#0x00
;fat.c:544: dst[0] = 0;
	ld	c,10 (ix)
	ld	d,11 (ix)
	ld	e,c
	ld	b,d
	ld	l, c
	ld	h, d
	ld	(hl),#0x00
;fat.c:546: fat_make_path_name(dst, dir, filename);
	push	bc
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	e,c
	push	de
	call	_fat_make_path_name
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
	pop	de
	pop	bc
;fat.c:549: while (*ptr != 0) {
00103$:
	ld	l, c
	ld	h, d
	ld	a,(hl)
	or	a, a
	jr	Z,00121$
;fat.c:550: if (*ptr == (u8) '.')ext_exist = 1;
	sub	a, #0x2E
	jr	NZ,00102$
	ld	-1 (ix),#0x01
00102$:
;fat.c:551: ptr++;
	inc	c
	jr	NZ,00103$
	inc	d
	jr	00103$
00121$:
	push	hl
	ld	l,c
	ld	h,d
	push	hl
	pop	iy
	pop	hl
;fat.c:554: if (ext_exist) {
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00110$
;fat.c:555: while (*ptr != (u8) '.')ptr--;
	push	hl
	ld	l,c
	ld	h,d
	push	hl
	pop	iy
	pop	hl
00106$:
	ld	a, 0 (iy)
	sub	a, #0x2E
	jr	Z,00122$
	dec	iy
	jr	00106$
00122$:
00110$:
;fat.c:558: if (*ext != (u8) '.')*ptr++ = (u8) '.';
	ld	l,8 (ix)
	ld	h,9 (ix)
	ld	a,(hl)
	sub	a, #0x2E
	jr	Z,00112$
	ld	0 (iy), #0x2E
	inc	iy
00112$:
;fat.c:559: *ptr = 0;
	ld	0 (iy), #0x00
;fat.c:561: str_append(dst, ext);
	push	hl
	ld	c,e
	push	bc
	call	_str_append
	pop	af
	pop	af
	inc	sp
	pop	ix
	ret
_fat_make_sync_name_end::
;fat.c:565: u8 fat_open_file_by_name(u8 *name, FatFullRecord *rec, u16 wr_slen) {
;	---------------------------------
; Function fat_open_file_by_name
; ---------------------------------
_fat_open_file_by_name_start::
_fat_open_file_by_name:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;fat.c:570: resp = fat_seek_record(name, rec, &file_root, 0);
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	push	bc
	pop	iy
	push	bc
	push	de
	xor	a, a
	push	af
	inc	sp
	push	iy
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_seek_record
	pop	af
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	e,l
;fat.c:571: if (resp == FAT_ERR_NOT_EXIST) {
	ld	a,e
	sub	a, #0xF0
	jp	NZ,00110$
;fat.c:572: if (wr_slen == 0)return FAT_ERR_NOT_EXIST;
	ld	a,9 (ix)
	or	a,8 (ix)
	jr	NZ,00102$
	ld	l,#0xF0
	jp	00111$
00102$:
;fat.c:573: if (file_root == FAT_END_VAL)return FAT_ERR_PATH_NOT_EXIST;
	ld	a,-4 (ix)
	inc	a
	jr	NZ,00104$
	ld	a,-3 (ix)
	inc	a
	jr	NZ,00104$
	ld	a,-2 (ix)
	inc	a
	jr	NZ,00104$
	ld	a,-1 (ix)
	sub	a, #0x0F
	jr	NZ,00104$
	ld	l,#0xFA
	jr	00111$
00104$:
;fat.c:574: resp = fat_make_record(name, file_root, wr_slen, 0);
	push	bc
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_make_record
	ld	iy,#0x0009
	add	iy,sp
	ld	sp,iy
	pop	de
	pop	bc
	ld	e,l
;fat.c:575: if (resp)return resp;
	ld	a,e
	or	a, a
	jr	Z,00106$
	ld	l,e
	jr	00111$
00106$:
;fat.c:577: resp = fat_seek_record(name, rec, &file_root, 0);
	push	de
	xor	a, a
	push	af
	inc	sp
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_seek_record
	pop	af
	pop	af
	pop	af
	inc	sp
	pop	de
	ld	e,l
;fat.c:578: if (resp)return resp;
	ld	a,e
	or	a, a
	jr	Z,00110$
	ld	l,e
	jr	00111$
00110$:
;fat.c:581: resp = fat_open_file(rec, wr_slen);
	push	de
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_fat_open_file
	pop	af
	pop	af
	pop	de
;fat.c:583: return resp;
00111$:
	ld	sp,ix
	pop	ix
	ret
_fat_open_file_by_name_end::
;fat.c:586: u8 fat_seek_record(u8 *name, FatFullRecord *rec, u32 *file_root, u8 dir) {
;	---------------------------------
; Function fat_seek_record
; ---------------------------------
_fat_seek_record_start::
_fat_seek_record:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-28
	add	hl,sp
	ld	sp,hl
;fat.c:590: u8 last_sub = 0;
	ld	-24 (ix),#0x00
;fat.c:591: u32 dir_addr = 0;
	xor	a, a
	ld	-28 (ix),a
	ld	-27 (ix),a
	ld	-26 (ix),a
	ld	-25 (ix),a
;fat.c:592: u8 exist = 0;
	ld	-20 (ix),#0x00
;fat.c:597: *file_root = FAT_END_VAL;
	ld	a,8 (ix)
	ld	-4 (ix),a
	ld	a,9 (ix)
	ld	-3 (ix),a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),#0xFF
	inc	hl
	ld	(hl),#0xFF
	inc	hl
	ld	(hl),#0xFF
	inc	hl
	ld	(hl),#0x0F
	ld	a,6 (ix)
	ld	-10 (ix),a
	ld	a,7 (ix)
	ld	-9 (ix),a
	ld	a,-10 (ix)
	add	a, #0xE4
	ld	-2 (ix),a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
	ld	a,-10 (ix)
	ld	-12 (ix),a
	ld	a,-9 (ix)
	ld	-11 (ix),a
00147$:
;fat.c:601: if (*name == (u8) '/')name++;
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	a,(de)
	sub	a, #0x2F
	jr	NZ,00102$
	inc	de
	ld	4 (ix),e
	ld	5 (ix),d
00102$:
;fat.c:603: while (name[sub_name_len] != (u8) '/' && name[sub_name_len] != 0)sub_name_len++;
	ld	-17 (ix),#0x00
00104$:
	ld	a,4 (ix)
	add	a, -17 (ix)
	ld	-14 (ix),a
	ld	a,5 (ix)
	adc	a, #0x00
	ld	-13 (ix),a
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	ld	h,(hl)
	ld	a,h
	cp	a,#0x2F
	jr	Z,00174$
	or	a, a
	jr	Z,00174$
	inc	-17 (ix)
	jr	00104$
00174$:
;fat.c:604: if (name[sub_name_len] == 0)last_sub = 1;
	ld	a,h
	or	a, a
	jr	NZ,00108$
	ld	-24 (ix),#0x01
00108$:
;fat.c:608: resp = fat_load_dir(dir_addr);
	ld	l,-26 (ix)
	ld	h,-25 (ix)
	push	hl
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	push	hl
	call	_fat_load_dir
	pop	af
	pop	af
;fat.c:609: if (resp)return resp;
	ld	-23 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00110$
	ld	l,-23 (ix)
	jp	00149$
00110$:
;fat.c:611: for (i = 0; i < fat_dir_size; i++) {
	ld	-14 (ix),#0x00
	ld	-13 (ix),#0x00
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
00146$:
	ld	hl,#_fat_dir_size
	ld	a,-19 (ix)
	sub	a, (hl)
	ld	a,-18 (ix)
	inc	hl
	sbc	a, (hl)
	jp	NC,00132$
;fat.c:612: resp = fat_get_full_record(fat_dir[i], rec);
	ld	a,-19 (ix)
	ld	-16 (ix),a
	ld	a,-18 (ix)
	ld	-15 (ix),a
	ld	a,#0x02+1
	jr	00225$
00224$:
	sla	-16 (ix)
	rl	-15 (ix)
00225$:
	dec	a
	jr	NZ,00224$
	ld	a,(#_fat_dir + 0)
	add	a, -16 (ix)
	ld	-16 (ix),a
	ld	iy,#_fat_dir
	ld	a,1 (iy)
	adc	a, -15 (ix)
	ld	-15 (ix),a
	ld	e,-16 (ix)
	ld	d,-15 (ix)
	ld	hl, #0x0014
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_fat_get_full_record
	pop	af
	pop	af
	pop	af
;fat.c:613: if (resp)return resp;
	ld	-23 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00112$
	ld	l,-23 (ix)
	jp	00149$
00112$:
;fat.c:614: if (!rec->is_dir && !last_sub)continue;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	or	a, a
	jr	NZ,00114$
	ld	a,-24 (ix)
	or	a, a
	jp	Z,00131$
00114$:
;fat.c:617: str_empty = 1;
	ld	-22 (ix),#0x01
;fat.c:618: for (u = sub_name_len; rec->name[u] != 0; u++) {
	ld	a,-17 (ix)
	ld	-21 (ix),a
00143$:
	ld	a,-10 (ix)
	add	a, -21 (ix)
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	h,(hl)
	ld	a,h
	or	a, a
	jr	Z,00118$
;fat.c:619: if (rec->name[u] != (u8) ' ') {
	ld	a,h
	sub	a, #0x20
	jr	Z,00144$
;fat.c:620: str_empty = 0;
	ld	-22 (ix),#0x00
;fat.c:621: break;
	jr	00118$
00144$:
;fat.c:618: for (u = sub_name_len; rec->name[u] != 0; u++) {
	inc	-21 (ix)
	jr	00143$
00118$:
;fat.c:625: if (str_empty && str_cmp_len(name, rec->name, sub_name_len)) {
	ld	a,-22 (ix)
	or	a, a
	jp	Z,00131$
	ld	a,-17 (ix)
	push	af
	inc	sp
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_str_cmp_len
	pop	af
	pop	af
	inc	sp
	ld	a,l
	or	a, a
	jr	Z,00131$
;fat.c:626: if (last_sub) {
	ld	a,-24 (ix)
	or	a, a
	jr	Z,00126$
;fat.c:627: if (rec->is_dir && !dir)continue;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	h,(hl)
	ld	a,h
	or	a, a
	jr	Z,00120$
	ld	a,10 (ix)
	or	a, a
	jr	Z,00131$
00120$:
;fat.c:628: if (!rec->is_dir && dir)continue;
	ld	a,h
	or	a, a
	jr	NZ,00123$
	ld	a,10 (ix)
	or	a, a
	jr	NZ,00131$
00123$:
;fat.c:629: exist = 1;
	ld	-20 (ix),#0x01
	jr	00127$
00126$:
;fat.c:631: dir_addr = rec->data_clsut;
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	ld	de, #0x00DC
	add	hl, de
	ld	a,(hl)
	ld	-28 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-27 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-26 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-25 (ix),a
00127$:
;fat.c:633: name += sub_name_len;
	ld	a,4 (ix)
	add	a, -17 (ix)
	ld	4 (ix),a
	ld	a,5 (ix)
	adc	a, #0x00
	ld	5 (ix),a
;fat.c:634: break;
	jr	00132$
00131$:
;fat.c:611: for (i = 0; i < fat_dir_size; i++) {
	inc	-19 (ix)
	jr	NZ,00228$
	inc	-18 (ix)
00228$:
	ld	a,-19 (ix)
	ld	-14 (ix),a
	ld	a,-18 (ix)
	ld	-13 (ix),a
	jp	00146$
00132$:
;fat.c:639: if (resp || last_sub || i == fat_dir_size)break;
	ld	a,-23 (ix)
	or	a, a
	jr	NZ,00137$
	ld	a,-24 (ix)
	or	a, a
	jr	NZ,00137$
	ld	a,(#_fat_dir_size + 0)
	sub	a, -14 (ix)
	jp	NZ,00147$
	ld	a,(#_fat_dir_size + 1)
	sub	a, -13 (ix)
	jp	NZ,00147$
00137$:
;fat.c:642: if (last_sub)*file_root = dir_addr;
	ld	a,-24 (ix)
	or	a, a
	jr	Z,00139$
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	ld	hl, #0x0000
	add	hl, sp
	ld	bc, #0x0004
	ldir
00139$:
;fat.c:643: if (!exist)return FAT_ERR_NOT_EXIST;
	ld	a,-20 (ix)
	or	a, a
	jr	NZ,00141$
	ld	l,#0xF0
	jr	00149$
00141$:
;fat.c:646: return 0;
	ld	l,#0x00
00149$:
	ld	sp,ix
	pop	ix
	ret
_fat_seek_record_end::
;fat.c:649: void fat_bytes_to_int_le(u8 *src, u32 *dst) {
;	---------------------------------
; Function fat_bytes_to_int_le
; ---------------------------------
_fat_bytes_to_int_le_start::
_fat_bytes_to_int_le:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;fat.c:658: *dst = *(u32 *) src;
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	h,4 (ix)
	ld	b,5 (ix)
	push	de
	ld	e, h
	ld	d, b
	ld	hl, #0x0002
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	de
	ld	hl, #0x0000
	add	hl, sp
	ld	bc, #0x0004
	ldir
	ld	sp,ix
	pop	ix
	ret
_fat_bytes_to_int_le_end::
;fat.c:663: void fat_int_to_bytes_le(u32 src, u8 *dst) {
;	---------------------------------
; Function fat_int_to_bytes_le
; ---------------------------------
_fat_int_to_bytes_le_start::
_fat_int_to_bytes_le:
;fat.c:671: *(u32 *) dst = src;
	ld	hl, #6
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, sp
	ld	bc, #0x0004
	ldir
	ret
_fat_int_to_bytes_le_end::
;fat.c:683: u8 fat_seek_free_cluster(u32 *base_clust, u16 clen) {
;	---------------------------------
; Function fat_seek_free_cluster
; ---------------------------------
_fat_seek_free_cluster_start::
_fat_seek_free_cluster:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-21
	add	hl,sp
	ld	sp,hl
;fat.c:693: ptr32 = (u32 *) & fat_tab[508];
	ld	a,(#_fat_tab + 0)
	add	a, #0xFC
	ld	d,a
	ld	a,(#_fat_tab + 1)
	adc	a, #0x01
	ld	-21 (ix), d
	ld	-20 (ix), a
;fat.c:694: sector = fat_first_free_clust / 128;
	push	af
	ld	hl,#_fat_first_free_clust + 0
	ld	c, (hl)
	ld	hl,#_fat_first_free_clust + 1
	ld	b, (hl)
	ld	hl,#_fat_first_free_clust + 2
	ld	e, (hl)
	ld	hl,#_fat_first_free_clust + 3
	ld	d, (hl)
	pop	af
	ld	a,#0x07
00159$:
	srl	d
	rr	e
	rr	b
	rr	c
	dec	a
	jr	NZ,00159$
;fat.c:721: clust = sector * 128;
00121$:
;fat.c:705: resp = fat_cache_read_tab(sector);
	push	bc
	push	de
	push	de
	push	bc
	call	_fat_cache_read_tab
	pop	af
	pop	af
	pop	de
	pop	bc
;fat.c:706: if (resp)return resp;
	ld	-11 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-11 (ix)
	jp	00127$
00102$:
;fat.c:708: if (*ptr32 == 0)break;
	push	de
	push	bc
	ld	e,-21 (ix)
	ld	d,-20 (ix)
	ld	hl, #0x0015
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	bc
	pop	de
	ld	a,-1 (ix)
	or	a, -2 (ix)
	or	a, -3 (ix)
	or	a,-4 (ix)
	jr	Z,00107$
;fat.c:710: sector += FAT_SEEK_STEP;
	ld	a,c
	add	a, #0x40
	ld	c,a
	ld	a,b
	adc	a, #0x00
	ld	b,a
	ld	a,e
	adc	a, #0x00
	ld	e,a
	ld	a,d
	adc	a, #0x00
	ld	d,a
;fat.c:711: if (sector >= fat_sectors_per_fat) return FAT_ERR_NO_FRE_SPACE;
	ld	hl,#_fat_sectors_per_fat
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
	jr	C,00121$
	ld	l,#0xF4
	jp	00127$
00107$:
;fat.c:721: clust = sector * 128;
	push	af
	ld	-19 (ix),c
	ld	-18 (ix),b
	ld	-17 (ix),e
	ld	-16 (ix),d
	pop	af
	ld	a,#0x07
00161$:
	sla	-19 (ix)
	rl	-18 (ix)
	rl	-17 (ix)
	rl	-16 (ix)
	dec	a
	jr	NZ,00161$
;fat.c:722: if (clust < 2)clust = 2;
	ld	a,-19 (ix)
	sub	a, #0x02
	ld	a,-18 (ix)
	sbc	a, #0x00
	ld	a,-17 (ix)
	sbc	a, #0x00
	ld	a,-16 (ix)
	sbc	a, #0x00
	jr	NC,00136$
	ld	-19 (ix),#0x02
	xor	a, a
	ld	-18 (ix),a
	ld	-17 (ix),a
	ld	-16 (ix),a
;fat.c:724: ctr = 0;
00136$:
	ld	a,-19 (ix)
	ld	-4 (ix),a
	ld	a,-18 (ix)
	ld	-3 (ix),a
	ld	a,-17 (ix)
	ld	-2 (ix),a
	ld	a,-16 (ix)
	ld	-1 (ix),a
	ld	-10 (ix),#0x00
	ld	-9 (ix),#0x00
00123$:
;fat.c:727: resp = fat_get_table_record(clust, &tab_val);
	ld	hl,#0x0006
	add	hl,sp
	push	bc
	push	de
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_fat_get_table_record
	pop	af
	pop	af
	pop	af
	pop	de
	pop	bc
;fat.c:728: if (resp)return resp;
	ld	-11 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00111$
	ld	l,-11 (ix)
	jp	00127$
00111$:
;fat.c:729: clust++;
	inc	-4 (ix)
	jr	NZ,00163$
	inc	-3 (ix)
	jr	NZ,00163$
	inc	-2 (ix)
	jr	NZ,00163$
	inc	-1 (ix)
00163$:
;fat.c:731: if (tab_val == 0) {
	ld	a,-12 (ix)
	or	a, -13 (ix)
	or	a, -14 (ix)
	or	a,-15 (ix)
	jr	NZ,00117$
;fat.c:733: ctr++;
	inc	-10 (ix)
	jr	NZ,00164$
	inc	-9 (ix)
00164$:
;fat.c:734: if (ctr == clen) {
	ld	a,-10 (ix)
	sub	a, 6 (ix)
	jr	NZ,00123$
	ld	a,-9 (ix)
	sub	a, 7 (ix)
	jr	NZ,00123$
;fat.c:735: *base_clust = clust - clen;
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	l,6 (ix)
	ld	h,7 (ix)
	ld	bc,#0x0000
	ld	a,-4 (ix)
	sub	a, l
	ld	-8 (ix),a
	ld	a,-3 (ix)
	sbc	a, h
	ld	-7 (ix),a
	ld	a,-2 (ix)
	sbc	a, c
	ld	-6 (ix),a
	ld	a,-1 (ix)
	sbc	a, b
	ld	-5 (ix),a
	ld	hl, #0x000D
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:736: fat_first_free_clust = *base_clust;
	ld	de, #_fat_first_free_clust
	ld	hl, #13
	add	hl, sp
	ld	bc, #4
	ldir
;fat.c:737: return 0;
	ld	l,#0x00
	jr	00127$
00117$:
;fat.c:742: if (ctr != 0) break;
	ld	a,-9 (ix)
	or	a,-10 (ix)
	jp	Z,00123$
;fat.c:747: sector++;
	inc	c
	jp	NZ,00121$
	inc	b
	jp	NZ,00121$
	inc	e
	jp	NZ,00121$
	inc	d
	jp	00121$
00127$:
	ld	sp,ix
	pop	ix
	ret
_fat_seek_free_cluster_end::
;fat.c:755: u8 fat_cache_save_tab() {
;	---------------------------------
; Function fat_cache_save_tab
; ---------------------------------
_fat_cache_save_tab_start::
_fat_cache_save_tab:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;fat.c:760: sector = fat_tab_sector + fat_entry;
	ld	hl,#_fat_entry
	ld	a,(#_fat_tab_sector + 0)
	add	a, (hl)
	ld	e,a
	ld	a,(#_fat_tab_sector + 1)
	inc	hl
	adc	a, (hl)
	ld	d,a
	ld	a,(#_fat_tab_sector + 2)
	inc	hl
	adc	a, (hl)
	ld	c,a
	ld	a,(#_fat_tab_sector + 3)
	inc	hl
	adc	a, (hl)
	ld	b,a
;fat.c:762: resp = diskWrite(sector, fat_tab, 1);
	ld	iy,(_fat_tab)
	push	bc
	push	de
	ld	hl,#0x0001
	push	hl
	push	iy
	push	bc
	push	de
	call	_diskWrite
	pop	af
	pop	af
	pop	af
	pop	af
	pop	de
	pop	bc
;fat.c:763: if (resp)return resp;
	ld	-3 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-3 (ix)
	jr	00103$
00102$:
;fat.c:765: resp = diskWrite(sector + fat_sectors_per_fat, fat_tab, 1);
	ld	hl,(_fat_tab)
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	a,e
	ld	hl,#_fat_sectors_per_fat
	add	a, (hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a, (hl)
	ld	d,a
	ld	a,c
	inc	hl
	adc	a, (hl)
	ld	c,a
	ld	a,b
	inc	hl
	adc	a, (hl)
	ld	b,a
	ld	hl,#0x0001
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	push	bc
	push	de
	call	_diskWrite
	pop	af
	pop	af
	pop	af
	pop	af
;fat.c:768: return resp;
	ld	-3 (ix), l
00103$:
	ld	sp,ix
	pop	ix
	ret
_fat_cache_save_tab_end::
;fat.c:771: u8 fat_cache_save_data() {
;	---------------------------------
; Function fat_cache_save_data
; ---------------------------------
_fat_cache_save_data_start::
_fat_cache_save_data:
;fat.c:773: return diskWrite(fat_dat_sector, fat_dat, 1);
	ld	hl,(_fat_dat)
	ld	bc,#0x0001
	push	bc
	push	hl
	ld	hl,(_fat_dat_sector + 2)
	push	hl
	ld	hl,(_fat_dat_sector)
	push	hl
	call	_diskWrite
	pop	af
	pop	af
	pop	af
	pop	af
	ret
_fat_cache_save_data_end::
;fat.c:777: u8 fat_catch_clusters(u32 base, u16 clen) {
;	---------------------------------
; Function fat_catch_clusters
; ---------------------------------
_fat_catch_clusters_start::
_fat_catch_clusters:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
00114$:
;fat.c:786: sector = base / 128;
	push	af
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	pop	af
	ld	b,#0x07
00136$:
	srl	d
	rr	e
	rr	h
	rr	l
	djnz	00136$
;fat.c:787: resp = fat_cache_read_tab(sector);
	push	de
	push	hl
	call	_fat_cache_read_tab
	pop	af
	pop	af
;fat.c:788: if (resp)return resp;
	ld	-9 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-9 (ix)
	jp	00116$
00102$:
;fat.c:789: ptr = (u32 *) & fat_tab[(base & 127) * 4];
	ld	e,4 (ix)
	res	7, e
	ld	d,#0x00
	ld	bc,#0x0000
	ld	a,#0x02
00138$:
	sla	e
	rl	d
	rl	c
	rl	b
	dec	a
	jr	NZ,00138$
	ld	a,(#_fat_tab + 0)
	add	a, e
	ld	e,a
	ld	iy,#_fat_tab
	ld	a,1 (iy)
	adc	a, d
	ld	d,a
	inc	sp
	inc	sp
	push	de
	ld	a,-11 (ix)
	ld	-8 (ix),a
	ld	a,-10 (ix)
	ld	-7 (ix),a
	ld	hl, #5
	add	hl, sp
	ex	de, hl
	ld	hl, #15
	add	hl, sp
	ld	bc, #4
	ldir
	ld	a,8 (ix)
	ld	-2 (ix),a
	ld	a,9 (ix)
	ld	-1 (ix),a
00112$:
;fat.c:793: base++;
	inc	-6 (ix)
	jr	NZ,00140$
	inc	-5 (ix)
	jr	NZ,00140$
	inc	-4 (ix)
	jr	NZ,00140$
	inc	-3 (ix)
00140$:
	ld	hl, #15
	add	hl, sp
	ex	de, hl
	ld	hl, #5
	add	hl, sp
	ld	bc, #4
	ldir
;fat.c:794: clen--;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	dec	hl
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	a,-2 (ix)
	ld	8 (ix),a
	ld	a,-1 (ix)
	ld	9 (ix),a
;fat.c:795: if (clen == 0) {
	ld	a,-1 (ix)
	or	a,-2 (ix)
	jr	NZ,00104$
;fat.c:796: fat_int_to_bytes_le(FAT_END_VAL, (u8*) ptr);
	pop	hl
	push	hl
	push	hl
	ld	hl,#0x0FFF
	push	hl
	ld	hl,#0xFFFF
	push	hl
	call	_fat_int_to_bytes_le
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;fat.c:797: resp = fat_cache_save_tab();
	call	_fat_cache_save_tab
;fat.c:798: return resp;
	ld	-9 (ix), l
	jr	00116$
00104$:
;fat.c:800: fat_int_to_bytes_le(base, (u8*) ptr);
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	call	_fat_int_to_bytes_le
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;fat.c:801: ptr++;
	ld	a,-8 (ix)
	add	a, #0x04
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a, #0x00
	ld	-7 (ix),a
	ld	a,-8 (ix)
	ld	-11 (ix),a
	ld	a,-7 (ix)
	ld	-10 (ix),a
;fat.c:804: if ((base & 127) == 0) {
	ld	a,-6 (ix)
	and	a, #0x7F
	jp	NZ,00112$
;fat.c:805: resp = fat_cache_save_tab();
	call	_fat_cache_save_tab
;fat.c:806: if (resp)return resp;
	ld	-9 (ix), l
	ld	a, l
	or	a, a
	jp	Z,00114$
	ld	l,-9 (ix)
;fat.c:807: break;
00116$:
	ld	sp,ix
	pop	ix
	ret
_fat_catch_clusters_end::
;fat.c:817: u8 fat_resize_file(FatFullRecord *rec, u16 slen) {
;	---------------------------------
; Function fat_resize_file
; ---------------------------------
_fat_resize_file_start::
_fat_resize_file:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-23
	add	hl,sp
	ld	sp,hl
;fat.c:829: new_size = (u32) slen * 512;
	ld	a,6 (ix)
	ld	-4 (ix),a
	ld	a,7 (ix)
	ld	-3 (ix),a
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
	push	af
	ld	a,-4 (ix)
	ld	-14 (ix),a
	ld	a,-3 (ix)
	ld	-13 (ix),a
	ld	a,-2 (ix)
	ld	-12 (ix),a
	ld	a,-1 (ix)
	ld	-11 (ix),a
	pop	af
	ld	b,#0x09
00143$:
	sla	-14 (ix)
	rl	-13 (ix)
	rl	-12 (ix)
	rl	-11 (ix)
	djnz	00143$
;fat.c:833: if (new_size <= rec->size)return FAT_ERR_SIZE_EQ;
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	ld	a,-4 (ix)
	add	a, #0xE0
	ld	-10 (ix),a
	ld	a,-3 (ix)
	adc	a, #0x00
	ld	-9 (ix),a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	a,e
	sub	a, -14 (ix)
	ld	a,d
	sbc	a, -13 (ix)
	ld	a,c
	sbc	a, -12 (ix)
	ld	a,h
	sbc	a, -11 (ix)
	jr	C,00102$
	ld	l,#0xFC
	jp	00117$
00102$:
;fat.c:834: hdr_idx = (u8) (rec->hdr_entry_8 & 0x0F);
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	de, #0x00D8
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,e
	and	a, #0x0F
	ld	-8 (ix),a
	ld	-7 (ix),#0x00
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x00
	ld	l,-8 (ix)
;fat.c:835: hdr_sector = rec->hdr_entry_8 >> 4;
	ld	a,#0x04
00145$:
	srl	b
	rr	c
	rr	d
	rr	e
	dec	a
	jr	NZ,00145$
;fat.c:836: resp = fat_cache_read_dat(hdr_sector);
	push	hl
	push	bc
	push	de
	call	_fat_cache_read_dat
	pop	af
	pop	af
	ld	a,l
	pop	hl
;fat.c:837: if (resp)return resp;
	ld	-15 (ix), a
	or	a, a
	jr	Z,00104$
	ld	l,-15 (ix)
	jp	00117$
00104$:
;fat.c:841: ptr = (u8 *) & fat_dat[(u16) hdr_idx * 32];
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	d,l
	ld	e,h
	ld	a,(#_fat_dat + 0)
	add	a, d
	ld	c,a
	ld	a,(#_fat_dat + 1)
	adc	a, e
	ld	b,a
;fat.c:844: fat_int_to_bytes_le(new_size, &ptr[0x1c]);
	ld	hl,#0x001C
	add	hl,bc
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_fat_int_to_bytes_le
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;fat.c:847: resp = fat_cache_save_data();
	call	_fat_cache_save_data
;fat.c:848: if (resp)return resp;
	ld	-15 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00106$
	ld	l,-15 (ix)
	jp	00117$
00106$:
;fat.c:851: old_slen = rec->size / 512;
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	hl, #0x000F
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	push	af
	ld	c,-8 (ix)
	ld	h,-7 (ix)
	ld	l,-6 (ix)
	ld	d,-5 (ix)
	pop	af
	ld	b,#0x09
00147$:
	srl	d
	rr	l
	rr	h
	rr	c
	djnz	00147$
	ld	b, h
;fat.c:852: if ((rec->size & 511) != 0)old_slen++;
	ld	a,-8 (ix)
	or	a, a
	jr	NZ,00149$
	bit	0, -7 (ix)
	jr	Z,00108$
00149$:
	inc	bc
00108$:
;fat.c:855: old_clen = old_slen >> fat_cluster_size_pow;
	ld	a,(#_fat_cluster_size_pow + 0)
	ld	h,c
	ld	l,b
	inc	a
	jr	00151$
00150$:
	srl	l
	rr	h
00151$:
	dec	a
	jr	NZ,00150$
	ld	-23 (ix),h
	ld	-22 (ix),l
;fat.c:856: if ((old_slen & (fat_cluster_size - 1)) != 0)old_clen++;
	ld	iy,#_fat_cluster_size
	ld	l,0 (iy)
	ld	h,#0x00
	dec	hl
	ld	a,l
	and	a, c
	ld	-8 (ix),a
	ld	a,h
	and	a, b
	ld	-7 (ix), a
	or	a,-8 (ix)
	jr	Z,00110$
	inc	-23 (ix)
	jr	NZ,00152$
	inc	-22 (ix)
00152$:
00110$:
;fat.c:859: new_clen = slen >> fat_cluster_size_pow;
	ld	iy,#_fat_cluster_size_pow
	ld	b,0 (iy)
	push	af
	ld	d,6 (ix)
	ld	e,7 (ix)
	pop	af
	inc	b
	jr	00154$
00153$:
	srl	e
	rr	d
00154$:
	djnz	00153$
	ld	-21 (ix),d
	ld	-20 (ix),e
;fat.c:860: if ((slen & (fat_cluster_size - 1)) != 0)new_clen++;
	ld	a,l
	and	a, 6 (ix)
	ld	-8 (ix),a
	ld	a,h
	and	a, 7 (ix)
	ld	-7 (ix), a
	or	a,-8 (ix)
	jr	Z,00112$
	inc	-21 (ix)
	jr	NZ,00155$
	inc	-20 (ix)
00155$:
00112$:
;fat.c:863: if (old_clen == new_clen)return 0;
	ld	a,-23 (ix)
	sub	a, -21 (ix)
	jr	NZ,00114$
	ld	a,-22 (ix)
	sub	a, -20 (ix)
	jr	NZ,00114$
	ld	l,#0x00
	jp	00117$
00114$:
;fat.c:865: new_clen -= old_clen;
	ld	a,-21 (ix)
	sub	a, -23 (ix)
	ld	-21 (ix),a
	ld	a,-20 (ix)
	sbc	a, -22 (ix)
	ld	-20 (ix),a
;fat.c:868: resp = fat_seek_rec_end(rec->data_clsut, &end_cluster);
	ld	hl,#0x0004
	add	hl,sp
	ld	-8 (ix),l
	ld	-7 (ix),h
	ld	a,-8 (ix)
	ld	-8 (ix),a
	ld	a,-7 (ix)
	ld	-7 (ix),a
	ld	a,-4 (ix)
	ld	-10 (ix),a
	ld	a,-3 (ix)
	ld	-9 (ix),a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	de, #0x00DC
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
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_fat_seek_rec_end
	pop	af
	pop	af
	pop	af
	ld	-8 (ix), l
	ld	a, l
;fat.c:869: if (resp)return resp;
	ld	-15 (ix), a
	or	a, a
	jr	Z,00116$
	ld	l,-15 (ix)
	jr	00117$
00116$:
;fat.c:872: return fat_expand(end_cluster, new_clen, 0);
	xor	a, a
	push	af
	inc	sp
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	call	_fat_expand
	pop	af
	pop	af
	pop	af
	inc	sp
00117$:
	ld	sp,ix
	pop	ix
	ret
_fat_resize_file_end::
;fat.c:877: u8 fat_seek_rec_end(u32 start_clust, u32 *end_clust) {
;	---------------------------------
; Function fat_seek_rec_end
; ---------------------------------
_fat_seek_rec_end_start::
_fat_seek_rec_end:
;fat.c:881: while (start_clust != FAT_END_VAL) {
00103$:
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	inc	a
	jr	NZ,00117$
	ld	a,1 (iy)
	inc	a
	jr	NZ,00117$
	ld	a,2 (iy)
	inc	a
	jr	NZ,00117$
	ld	a,3 (iy)
	sub	a, #0x0F
	jr	Z,00105$
00117$:
;fat.c:882: *end_clust = start_clust;
	ld	hl, #6
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, sp
	ld	bc, #0x0004
	ldir
;fat.c:883: resp = fat_get_next_cluster(&start_clust);
	ld	hl,#0x0002
	add	hl,sp
	push	hl
	call	_fat_get_next_cluster
	pop	af
;fat.c:885: if (resp)return resp;
	ld	a,l
	or	a, a
	jr	Z,00103$
	ret
00105$:
;fat.c:888: return 0;
	ld	l,#0x00
	ret
_fat_seek_rec_end_end::
;fat.c:891: u8 fat_join(u32 last_clust, u32 next_clust) {
;	---------------------------------
; Function fat_join
; ---------------------------------
_fat_join_start::
_fat_join:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;fat.c:897: resp = fat_get_table_record(last_clust, &val);
	ld	hl,#0x0000
	add	hl,sp
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_get_table_record
	pop	af
	pop	af
	pop	af
	ld	c,l
;fat.c:898: if (resp)return resp;
	ld	a,c
	or	a, a
	jr	Z,00102$
	ld	l,c
	jr	00105$
00102$:
;fat.c:900: if (val != FAT_END_VAL)return FAT_ERR_NOT_LAST;
	ld	a,-4 (ix)
	inc	a
	jr	NZ,00113$
	ld	a,-3 (ix)
	inc	a
	jr	NZ,00113$
	ld	a,-2 (ix)
	inc	a
	jr	NZ,00113$
	ld	a,-1 (ix)
	sub	a, #0x0F
	jr	Z,00104$
00113$:
	ld	l,#0xFE
	jr	00105$
00104$:
;fat.c:902: ptr = (u8 *) & fat_tab[(last_clust & 127) * 4];
	ld	e,4 (ix)
	res	7, e
	ld	d,#0x00
	ld	bc,#0x0000
	ld	a,#0x02
00114$:
	sla	e
	rl	d
	rl	c
	rl	b
	dec	a
	jr	NZ,00114$
	ld	a,(#_fat_tab + 0)
	add	a, e
	ld	e,a
	ld	a,(#_fat_tab + 1)
	adc	a, d
	ld	d,a
;fat.c:903: fat_int_to_bytes_le(next_clust, ptr);
	push	de
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	_fat_int_to_bytes_le
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;fat.c:905: return fat_cache_save_tab();
	call	_fat_cache_save_tab
00105$:
	ld	sp,ix
	pop	ix
	ret
_fat_join_end::
;fat.c:908: u8 fat_write_file(u8 *src, u16 slen) {
;	---------------------------------
; Function fat_write_file
; ---------------------------------
_fat_write_file_start::
_fat_write_file:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
;fat.c:913: if (!file.wr_slen)return FAT_ERR_FILE_MODE2;
	ld	bc,#_file + 14
	ld	a,(bc)
	ld	e,a
	or	a, a
	jr	NZ,00102$
	ld	l,#0xF8
	jp	00124$
00102$:
;fat.c:914: if (file.sec_available < slen)return FAT_ERR_OUT_OF_FILE_WR;
	ld	hl, (#(_file + 0x000c) + 0)
	ld	a,l
	sub	a, 6 (ix)
	ld	a,h
	sbc	a, 7 (ix)
	jr	NC,00104$
	ld	l,#0xFD
	jp	00124$
00104$:
;fat.c:915: file.sec_available -= slen;
	ld	a,l
	sub	a, 6 (ix)
	ld	e,a
	ld	a,h
	sbc	a, 7 (ix)
	ld	d,a
	ld	((_file + 0x000c)), de
;fat.c:916: if (file.sec_available == 0)file.wr_slen = 0;
	ld	a,d
	or	a,e
	jr	NZ,00138$
	xor	a, a
	ld	(bc),a
;fat.c:918: while (slen) {
00138$:
00121$:
	ld	a,7 (ix)
	or	a,6 (ix)
	jp	Z,00123$
;fat.c:920: if (file.in_cluster == 0) {
	ld	hl, #(_file + 0x000f) + 0
	ld	e,(hl)
;fat.c:921: len = slen > fat_cluster_size ? fat_cluster_size : slen;
	ld	a,6 (ix)
	ld	-2 (ix),a
	ld	a,7 (ix)
	ld	-1 (ix),a
;fat.c:920: if (file.in_cluster == 0) {
	ld	a,e
	or	a, a
	jr	NZ,00110$
;fat.c:921: len = slen > fat_cluster_size ? fat_cluster_size : slen;
	ld	a,(#_fat_cluster_size + 0)
	ld	-8 (ix),a
	ld	-7 (ix),#0x00
	ld	a,-8 (ix)
	sub	a, 6 (ix)
	ld	a,-7 (ix)
	sbc	a, 7 (ix)
	jr	NC,00126$
	ld	a,-8 (ix)
	ld	-10 (ix),a
	ld	a,-7 (ix)
	ld	-9 (ix),a
	jr	00127$
00126$:
	ld	a,-2 (ix)
	ld	-10 (ix),a
	ld	a,-1 (ix)
	ld	-9 (ix),a
00127$:
	ld	c,-10 (ix)
	ld	b,-9 (ix)
	jr	00111$
00110$:
;fat.c:923: len = fat_cluster_size - file.in_cluster;
	ld	iy,#_fat_cluster_size
	ld	l,0 (iy)
	ld	h,#0x00
	ld	d,#0x00
	ld	a,l
	sub	a, e
	ld	c,a
	ld	a,h
	sbc	a, d
	ld	b,a
;fat.c:924: if (len > slen)len = slen;
	ld	a,6 (ix)
	sub	a, c
	ld	a,7 (ix)
	sbc	a, b
	jr	NC,00111$
	ld	c,-2 (ix)
	ld	b,-1 (ix)
00111$:
;fat.c:928: resp = diskWrite(file.sector, src, len);
	ld	e,4 (ix)
	ld	d,5 (ix)
	push	de
	pop	iy
	ld	hl, (#(_file + 0x0004) + 0)
	ld	de, (#(_file + 0x0004) + 2)
	push	bc
	push	bc
	push	iy
	push	de
	push	hl
	call	_diskWrite
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
;fat.c:929: if (resp)return resp;
	ld	-11 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00113$
	ld	l,-11 (ix)
	jp	00124$
00113$:
;fat.c:931: file.in_cluster += len;
	ld	hl, #(_file + 0x000f) + 0
	ld	h,(hl)
	ld	l,c
	ld	a,h
	add	a, l
	ld	d,a
	ld	hl,#(_file + 0x000f)
	ld	(hl),d
;fat.c:932: src += len * 512;
	ld	a,c
	add	a, a
	ld	l,a
	ld	h,#0x00
	ld	a,4 (ix)
	add	a, h
	ld	4 (ix),a
	ld	a,5 (ix)
	adc	a, l
	ld	5 (ix),a
;fat.c:933: slen -= len;
	ld	a,6 (ix)
	sub	a, c
	ld	6 (ix),a
	ld	a,7 (ix)
	sbc	a, b
	ld	7 (ix),a
;fat.c:935: if (file.in_cluster == fat_cluster_size) {
	ld	iy,#_fat_cluster_size
	ld	a,0 (iy)
	sub	a, d
	jr	NZ,00119$
;fat.c:936: file.in_cluster = 0;
	ld	hl,#(_file + 0x000f)
	ld	(hl),#0x00
;fat.c:937: resp = fat_get_next_cluster(&file.cluster);
	ld	hl,#_file
	push	hl
	call	_fat_get_next_cluster
	pop	af
;fat.c:938: if (resp)return resp;
	ld	-11 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00115$
	ld	l,-11 (ix)
	jr	00124$
00115$:
;fat.c:939: file.sector = fat_cluster_to_sector(file.cluster);
	ld	hl, (#_file + 0)
	ld	de, (#_file + 2)
	push	de
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	ld	((_file + 0x0004)), bc
	ld	((_file + 0x0004) + 2), de
;fat.c:940: if (resp)return resp;
	ld	a,-11 (ix)
	or	a, a
	jp	Z,00121$
	ld	l,-11 (ix)
	jr	00124$
00119$:
;fat.c:942: file.sector += len;
	push	bc
	ld	de,#(_file + 0x0004)
	ld	hl, #0x0007
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	bc
	ld	hl,#0x0000
	ld	a,-6 (ix)
	add	a, c
	ld	e,a
	ld	a,-5 (ix)
	adc	a, b
	ld	d,a
	ld	a,-4 (ix)
	adc	a, l
	ld	c,a
	ld	a,-3 (ix)
	adc	a, h
	ld	b,a
	ld	((_file + 0x0004)), de
	ld	((_file + 0x0004) + 2), bc
	jp	00121$
00123$:
;fat.c:947: return 0;
	ld	l,#0x00
00124$:
	ld	sp,ix
	pop	ix
	ret
_fat_write_file_end::
;fat.c:950: u8 fat_expand(u32 last_clust, u16 csize, u8 clean) {
;	---------------------------------
; Function fat_expand
; ---------------------------------
_fat_expand_start::
_fat_expand:
	push	af
	push	af
;fat.c:956: resp = fat_seek_free_cluster(&free_clust, csize);
	ld	hl,#0x0000
	add	hl,sp
	push	de
	ld	iy,#12
	add	iy,sp
	ld	c,0 (iy)
	ld	b,1 (iy)
	push	bc
	push	hl
	call	_fat_seek_free_cluster
	pop	af
	pop	af
	pop	de
	ld	d,l
;fat.c:957: if (resp)return resp;
	ld	a,d
	or	a, a
	jr	Z,00102$
	ld	l,d
	jp	00111$
00102$:
;fat.c:959: resp = fat_catch_clusters(free_clust, csize);
	push	de
	ld	hl, #12
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	iy,#4
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	call	_fat_catch_clusters
	pop	af
	pop	af
	pop	af
	pop	de
	ld	d,l
;fat.c:960: if (resp)return resp;
	ld	a,d
	or	a, a
	jr	Z,00104$
	ld	l,d
	jr	00111$
00104$:
;fat.c:963: resp = fat_join(last_clust, free_clust);
	push	de
	ld	iy,#2
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	ld	iy,#12
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	call	_fat_join
	pop	af
	pop	af
	pop	af
	pop	af
	pop	de
	ld	d,l
;fat.c:964: if (resp)return resp;
	ld	a,d
	or	a, a
	jr	Z,00106$
	ld	l,d
	jr	00111$
00106$:
;fat.c:966: if (clean) {
	ld	hl, #12+0
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z,00110$
;fat.c:968: resp = fat_clean_cluster(free_clust, csize);
	push	de
	ld	hl, #12
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	iy,#4
	add	iy,sp
	ld	l,2 (iy)
	ld	h,3 (iy)
	push	hl
	ld	l,0 (iy)
	ld	h,1 (iy)
	push	hl
	call	_fat_clean_cluster
	pop	af
	pop	af
	pop	af
	pop	de
	ld	d,l
;fat.c:969: if (resp)return resp;
	ld	a,d
	or	a, a
	jr	Z,00110$
	ld	l,d
	jr	00111$
00110$:
;fat.c:973: return 0;
	ld	l,#0x00
00111$:
	pop	af
	pop	af
	ret
_fat_expand_end::
;fat.c:976: u8 fat_clean_cluster(u32 cluster, u16 clen) {
;	---------------------------------
; Function fat_clean_cluster
; ---------------------------------
_fat_clean_cluster_start::
_fat_clean_cluster:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;fat.c:982: sector = fat_cluster_to_sector(cluster);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	-8 (ix),l
	ld	-7 (ix),h
	ld	-6 (ix),e
	ld	-5 (ix),d
;fat.c:983: fat_dat_sector = ~0;
	ld	hl,#_fat_dat_sector + 0
	ld	(hl), #0xFF
	ld	hl,#_fat_dat_sector + 1
	ld	(hl), #0xFF
	ld	hl,#_fat_dat_sector + 2
	ld	(hl), #0xFF
	ld	hl,#_fat_dat_sector + 3
	ld	(hl), #0xFF
;fat.c:984: sysMemSet(fat_dat, 0, 512);
	ld	de,(_fat_dat)
	ld	hl,#0x0200
	push	hl
	xor	a, a
	push	af
	inc	sp
	push	de
	call	_sysMemSet
	pop	af
	pop	af
	inc	sp
;fat.c:986: while (clen--) {
	ld	c,8 (ix)
	ld	b,9 (ix)
00104$:
	ld	e,c
	ld	h,b
	dec	bc
	ld	a,h
	or	a,e
	jr	Z,00106$
;fat.c:987: for (i = 0; i < fat_cluster_size; i++) {
	ld	a,-8 (ix)
	ld	-4 (ix),a
	ld	a,-7 (ix)
	ld	-3 (ix),a
	ld	a,-6 (ix)
	ld	-2 (ix),a
	ld	a,-5 (ix)
	ld	-1 (ix),a
	ld	-9 (ix),#0x00
00108$:
	ld	hl,#_fat_cluster_size
	ld	a,-9 (ix)
	sub	a, (hl)
	jr	NC,00104$
;fat.c:988: resp = diskWrite(sector, fat_dat, 1);
	ld	hl,(_fat_dat)
	push	bc
	ld	de,#0x0001
	push	de
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_diskWrite
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
;fat.c:989: if (resp)return resp;
	ld	a,l
	or	a, a
	jr	NZ,00110$
;fat.c:990: sector++;
	inc	-4 (ix)
	jr	NZ,00127$
	inc	-3 (ix)
	jr	NZ,00127$
	inc	-2 (ix)
	jr	NZ,00127$
	inc	-1 (ix)
00127$:
	ld	a,-4 (ix)
	ld	-8 (ix),a
	ld	a,-3 (ix)
	ld	-7 (ix),a
	ld	a,-2 (ix)
	ld	-6 (ix),a
	ld	a,-1 (ix)
	ld	-5 (ix),a
;fat.c:987: for (i = 0; i < fat_cluster_size; i++) {
	inc	-9 (ix)
	jr	00108$
00106$:
;fat.c:994: return 0;
	ld	l,#0x00
00110$:
	ld	sp,ix
	pop	ix
	ret
_fat_clean_cluster_end::
;fat.c:1011: u8 fat_make_hdr(u8 *name, u8 rec_idx, u8 attrib, u32 entry, u32 size) {
;	---------------------------------
; Function fat_make_hdr
; ---------------------------------
_fat_make_hdr_start::
_fat_make_hdr:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-7
	add	hl,sp
	ld	sp,hl
;fat.c:1018: date = osGetDate();
	call	_osGetDate
;fat.c:1019: time = osGetTime();
	push	hl
	call	_osGetTime
	pop	de
	ld	-5 (ix),l
	ld	-4 (ix),h
;fat.c:1021: ptr = (u8 *) & fat_dat[(u16) rec_idx * 32];
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	iy,(_fat_dat)
	add	iy, bc
	push	iy
	pop	af
	ld	-6 (ix),a
	push	iy
	dec	sp
	pop	af
	inc	sp
	ld	-7 (ix),a
;fat.c:1023: for (i = 0; i < 11; i++)*ptr++ = name[i];
	pop	bc
	push	bc
	ld	-3 (ix),#0x00
00103$:
	ld	a,4 (ix)
	add	a, -3 (ix)
	ld	l,a
	ld	a,5 (ix)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	ld	(bc),a
	inc	bc
	inc	-3 (ix)
	ld	a,-3 (ix)
	sub	a, #0x0B
	jr	C,00103$
;fat.c:1024: *ptr++ = attrib;
	ld	a,7 (ix)
	ld	(bc),a
	inc	bc
	inc	sp
	inc	sp
	push	bc
;fat.c:1025: for (i = 0; i < 8; i++)ptr++;
	ld	l,#0x08
	ld	a,-7 (ix)
	ld	-2 (ix),a
	ld	a,-6 (ix)
	ld	-1 (ix),a
00107$:
	inc	-2 (ix)
	jr	NZ,00124$
	inc	-1 (ix)
00124$:
	dec	l
	ld	a,l
	or	a, a
	jr	NZ,00107$
;fat.c:1027: *ptr++ = (entry >> 16) & 0xff;
	push	af
	ld	b,8 (ix)
	ld	h,9 (ix)
	ld	l,10 (ix)
	ld	c,11 (ix)
	pop	af
	ld	a,#0x10
00125$:
	srl	c
	rr	l
	rr	h
	rr	b
	dec	a
	jr	NZ,00125$
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),b
	ld	a,-2 (ix)
	add	a, #0x01
	ld	-7 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
;fat.c:1028: *ptr++ = (entry >> 24) & 0xff;
	push	af
	ld	b,8 (ix)
	ld	h,9 (ix)
	ld	l,10 (ix)
	ld	c,11 (ix)
	pop	af
	ld	a,#0x18
00127$:
	srl	c
	rr	l
	rr	h
	rr	b
	dec	a
	jr	NZ,00127$
	pop	hl
	push	hl
	ld	(hl),b
	inc	-7 (ix)
	jr	NZ,00129$
	inc	-6 (ix)
00129$:
;fat.c:1030: *ptr++ = time & 0xff; //time
	ld	b,-5 (ix)
	pop	hl
	push	hl
	ld	(hl),b
	inc	-7 (ix)
	jr	NZ,00130$
	inc	-6 (ix)
00130$:
;fat.c:1031: *ptr++ = time >> 8;
	ld	b,-4 (ix)
	pop	hl
	push	hl
	ld	(hl),b
	inc	-7 (ix)
	jr	NZ,00131$
	inc	-6 (ix)
00131$:
;fat.c:1033: *ptr++ = date & 0xff; //date
	ld	b,e
	pop	hl
	push	hl
	ld	(hl),b
	inc	-7 (ix)
	jr	NZ,00132$
	inc	-6 (ix)
00132$:
;fat.c:1034: *ptr++ = date >> 8;
	pop	hl
	push	hl
	ld	(hl),d
	inc	-7 (ix)
	jr	NZ,00133$
	inc	-6 (ix)
00133$:
;fat.c:1036: *ptr++ = entry & 0xff;
	ld	d,8 (ix)
	pop	hl
	push	hl
	ld	(hl),d
	inc	-7 (ix)
	jr	NZ,00134$
	inc	-6 (ix)
00134$:
;fat.c:1037: *ptr++ = (entry >> 8) & 0xff;
	push	af
	ld	e,8 (ix)
	ld	h,9 (ix)
	ld	l,10 (ix)
	ld	d,11 (ix)
	pop	af
	ld	b,#0x08
00135$:
	srl	d
	rr	l
	rr	h
	rr	e
	djnz	00135$
	pop	hl
	push	hl
	ld	(hl),e
	inc	-7 (ix)
	jr	NZ,00137$
	inc	-6 (ix)
00137$:
;fat.c:1039: fat_int_to_bytes_le(size, ptr);
	pop	hl
	push	hl
	push	hl
	ld	l,14 (ix)
	ld	h,15 (ix)
	push	hl
	ld	l,12 (ix)
	ld	h,13 (ix)
	push	hl
	call	_fat_int_to_bytes_le
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;fat.c:1041: return fat_cache_save_data();
	call	_fat_cache_save_data
	ld	sp,ix
	pop	ix
	ret
_fat_make_hdr_end::
;fat.c:1045: void fat_make_lfn(u8 *name, u8 rec_idx, u8 lfn_idx, u8 crc) {
;	---------------------------------
; Function fat_make_lfn
; ---------------------------------
_fat_make_lfn_start::
_fat_make_lfn:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;fat.c:1051: u8 mask = 0;
	ld	-2 (ix),#0x00
;fat.c:1053: dat_ptr = (u8 *) & fat_dat[(u16) rec_idx * 32];
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	a,(#_fat_dat + 0)
	add	a, e
	ld	c,a
	ld	a,(#_fat_dat + 1)
	adc	a, d
	ld	b,a
;fat.c:1054: lfn_ptr = (u8 *) & name[lfn_idx * 13];
	ld	e,7 (ix)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e,4 (ix)
	ld	d,5 (ix)
	add	hl,de
	ex	de,hl
;fat.c:1056: sysMemSet(dat_ptr, 0, 32);
	push	bc
	pop	iy
	push	bc
	push	de
	ld	hl,#0x0020
	push	hl
	xor	a, a
	push	af
	inc	sp
	push	iy
	call	_sysMemSet
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
;fat.c:1058: for (i = 0; i < 13; i++) {
	ld	-4 (ix),#0x00
00107$:
;fat.c:1059: idx = lfn_char_struct[i];
	ld	a,#<(_lfn_char_struct)
	add	a, -4 (ix)
	ld	l,a
	ld	a,#>(_lfn_char_struct)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	ld	-3 (ix),a
;fat.c:1060: dat_ptr[idx] = *lfn_ptr++ | mask;
	push	hl
	ld	l,-3 (ix)
	ld	h,#0x00
	push	hl
	pop	iy
	pop	hl
	add	iy, bc
	ld	a,(de)
	inc	de
	or	a, -2 (ix)
	ld	-1 (ix), a
	ld	0 (iy), a
;fat.c:1061: dat_ptr[idx + 1] = mask;
	ld	l,-3 (ix)
	ld	h,#0x00
	inc	hl
	add	hl,bc
	ld	a,-2 (ix)
	ld	(hl),a
;fat.c:1062: if (dat_ptr[idx] == 0)mask = 0xff;
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00108$
	ld	-2 (ix),#0xFF
00108$:
;fat.c:1058: for (i = 0; i < 13; i++) {
	inc	-4 (ix)
	ld	a,-4 (ix)
	sub	a, #0x0D
	jr	C,00107$
;fat.c:1065: if (mask != 0 || *lfn_ptr == 0)mask = 0x40;
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00104$
	ld	a,(de)
	or	a, a
	jr	NZ,00105$
00104$:
	ld	-2 (ix),#0x40
00105$:
;fat.c:1067: dat_ptr[0x00] = (lfn_idx + 1) | mask;
	ld	a,7 (ix)
	inc	a
	or	a, -2 (ix)
	ld	(bc),a
;fat.c:1068: dat_ptr[0x0B] = 0x0F;
	ld	hl,#0x000B
	add	hl,bc
	ld	(hl),#0x0F
;fat.c:1069: dat_ptr[0x0D] = crc;
	ld	hl,#0x000D
	add	hl,bc
	ld	a,8 (ix)
	ld	(hl),a
	ld	sp,ix
	pop	ix
	ret
_fat_make_lfn_end::
;fat.c:1073: u8 fat_next_dir_sector(u32 *clust, u32 *sector, u8 *in_clust) {
;	---------------------------------
; Function fat_next_dir_sector
; ---------------------------------
_fat_next_dir_sector_start::
_fat_next_dir_sector:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-15
	add	hl,sp
	ld	sp,hl
;fat.c:1080: if (*sector == 0) {
	ld	a,6 (ix)
	ld	-10 (ix),a
	ld	a,7 (ix)
	ld	-9 (ix),a
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	hl, #0x000B
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
;fat.c:1082: *in_clust = 0;
	ld	c,8 (ix)
	ld	b,9 (ix)
;fat.c:1083: *sector = fat_cluster_to_sector(*clust);
	ld	e,4 (ix)
	ld	d,5 (ix)
;fat.c:1080: if (*sector == 0) {
	ld	a,-1 (ix)
	or	a, -2 (ix)
	or	a, -3 (ix)
	or	a,-4 (ix)
	jr	NZ,00112$
;fat.c:1082: *in_clust = 0;
	xor	a, a
	ld	(bc),a
;fat.c:1083: *sector = fat_cluster_to_sector(*clust);
	ld	hl, #0x000B
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jp	00113$
00112$:
;fat.c:1087: *in_clust = *in_clust + 1;
	ld	a,(bc)
	inc	a
	ld	-4 (ix), a
	ld	(bc),a
;fat.c:1088: *sector = *sector + 1;
	push	de
	push	bc
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	hl, #0x000B
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	bc
	pop	de
	inc	-8 (ix)
	jr	NZ,00134$
	inc	-7 (ix)
	jr	NZ,00134$
	inc	-6 (ix)
	jr	NZ,00134$
	inc	-5 (ix)
00134$:
	push	de
	push	bc
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	hl, #0x000B
	add	hl, sp
	ld	bc, #0x0004
	ldir
	pop	bc
	pop	de
;fat.c:1090: if (*in_clust == fat_cluster_size) {
	ld	iy,#_fat_cluster_size
	ld	a,0 (iy)
	sub	a, -4 (ix)
	jp	NZ,00113$
;fat.c:1091: *in_clust = 0;
	xor	a, a
	ld	(bc),a
;fat.c:1092: last_clust = *clust;
	push	de
	ld	hl, #0x0003
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	de
;fat.c:1093: resp = fat_get_next_cluster(clust);
	push	de
	push	de
	call	_fat_get_next_cluster
	pop	af
	pop	de
;fat.c:1094: if (resp)return resp;
	ld	-15 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	l,-15 (ix)
	jp	00114$
00102$:
;fat.c:1096: if (*clust == FAT_END_VAL) {
	ld	l, e
	ld	h, d
	ld	b,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	h,(hl)
	ld	l,a
	inc	b
	jr	NZ,00108$
	inc	c
	jr	NZ,00108$
	inc	h
	jr	NZ,00108$
	ld	a,l
	sub	a, #0x0F
	jr	NZ,00108$
;fat.c:1097: resp = fat_expand(last_clust, 1, 1);
	push	de
	ld	a,#0x01
	push	af
	inc	sp
	ld	hl,#0x0001
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_fat_expand
	pop	af
	pop	af
	pop	af
	inc	sp
	pop	de
;fat.c:1098: if (resp)return resp;
	ld	-15 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00104$
	ld	l,-15 (ix)
	jr	00114$
00104$:
;fat.c:1099: *clust = last_clust;
	push	de
	ld	hl, #0x0003
	add	hl, sp
	ld	bc, #0x0004
	ldir
	pop	de
;fat.c:1100: resp = fat_get_next_cluster(clust);
	push	de
	push	de
	call	_fat_get_next_cluster
	pop	af
	pop	de
;fat.c:1101: if (resp)return resp;
	ld	-15 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00108$
	ld	l,-15 (ix)
	jr	00114$
00108$:
;fat.c:1104: *sector = fat_cluster_to_sector(*clust);
	ex	de,hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	bc
	push	de
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
00113$:
;fat.c:1109: resp = fat_cache_read_dat(*sector);
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	bc
	push	de
	call	_fat_cache_read_dat
	pop	af
	pop	af
;fat.c:1112: return resp;
	ld	-15 (ix), l
00114$:
	ld	sp,ix
	pop	ix
	ret
_fat_next_dir_sector_end::
;fat.c:1115: u8 fat_make_dos_name(u8 *lfn_name, u8 *dos_name, u16 idx) {
;	---------------------------------
; Function fat_make_dos_name
; ---------------------------------
_fat_make_dos_name_start::
_fat_make_dos_name:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;fat.c:1121: sysMemCopy(lfn_name, dos_name, 8);
	ld	hl,#0x0008
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_sysMemCopy
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
;fat.c:1123: dos_name[8] = (u8) ' ';
	ld	a,6 (ix)
	add	a, #0x08
	ld	l,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x20
;fat.c:1124: dos_name[9] = (u8) ' ';
	ld	a,6 (ix)
	add	a, #0x09
	ld	l,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x20
;fat.c:1125: dos_name[10] = (u8) ' ';
	ld	a,6 (ix)
	add	a, #0x0A
	ld	l,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x20
;fat.c:1126: dot = 0;
	ld	c,#0x00
;fat.c:1128: for (i = 0; lfn_name[i] != 0; i++) {
	ld	e,#0x00
00115$:
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	d,#0x00
	add	hl, de
	ld	h,(hl)
	ld	a,h
	or	a, a
	jr	Z,00103$
;fat.c:1129: if (lfn_name[i] == (u8) '.')dot = i;
	ld	a,h
	sub	a, #0x2E
	jr	NZ,00116$
	ld	c,e
00116$:
;fat.c:1128: for (i = 0; lfn_name[i] != 0; i++) {
	inc	e
	jr	00115$
00103$:
;fat.c:1132: if (dot != 0) {
	ld	a,c
	or	a, a
	jr	Z,00133$
;fat.c:1133: dot++;
	inc	c
;fat.c:1135: for (i = 0; i < 3; i++) {
	ld	b,#0x00
00117$:
;fat.c:1136: if (lfn_name[i] == 0)break;
	ld	a,4 (ix)
	add	a, b
	ld	l,a
	ld	a,5 (ix)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	or	a, a
	jr	Z,00133$
;fat.c:1137: dos_name[i + 8] = lfn_name[i + dot];
	ld	e,b
	ld	d,#0x00
	ld	hl,#0x0008
	add	hl,de
	ld	a,6 (ix)
	add	a, l
	ld	-2 (ix),a
	ld	a,7 (ix)
	adc	a, h
	ld	-1 (ix),a
	ld	l,c
	ld	h,#0x00
	add	hl,de
	ld	e,4 (ix)
	ld	d,5 (ix)
	add	hl,de
	ld	a,(hl)
	pop	hl
	push	hl
	ld	(hl),a
;fat.c:1135: for (i = 0; i < 3; i++) {
	inc	b
	ld	a,b
	sub	a, #0x03
	jr	C,00117$
;fat.c:1141: for (i = 0; i < 11; i++) {
00133$:
	ld	e,#0x00
00119$:
;fat.c:1142: if (dos_name[i] >= (u8) 'a' && dos_name[i] <= (u8) 'z')dos_name[i] &= ~0x20;
	ld	l,6 (ix)
	ld	h,7 (ix)
	ld	d,#0x00
	add	hl, de
	ld	d,(hl)
	ld	a,d
	sub	a, #0x61
	jr	C,00120$
	ld	a,#0x7A
	sub	a, d
	jr	C,00120$
	res	5, d
	ld	(hl),d
00120$:
;fat.c:1141: for (i = 0; i < 11; i++) {
	inc	e
	ld	a,e
	sub	a, #0x0B
	jr	C,00119$
;fat.c:1146: dos_name[4] = '~';
	ld	a,6 (ix)
	add	a, #0x04
	ld	l,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x7E
;fat.c:1147: dos_name[5] = idx % 1000 / 100 + (u8) '0';
	ld	a,6 (ix)
	add	a, #0x05
	ld	e,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	d,a
	push	de
	ld	hl,#0x03E8
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	ld	bc,#0x0064
	push	bc
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	pop	de
	ld	a,l
	add	a, #0x30
	ld	(de),a
;fat.c:1148: dos_name[6] = idx % 100 / 10 + (u8) '0';
	ld	a,6 (ix)
	add	a, #0x06
	ld	e,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	d,a
	push	de
	ld	hl,#0x0064
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	ld	bc,#0x000A
	push	bc
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	pop	de
	ld	a,l
	add	a, #0x30
	ld	(de),a
;fat.c:1149: dos_name[7] = idx % 10 + (u8) '0';
	ld	a,6 (ix)
	add	a, #0x07
	ld	e,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	d,a
	push	de
	ld	hl,#0x000A
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	pop	de
	ld	a,l
	add	a, #0x30
	ld	(de),a
;fat.c:1151: crc = 0;
	ld	l,#0x00
;fat.c:1152: for (i = 0; i < 11; i++)crc = (((crc & 1) << 7) | ((crc & 0xfe) >> 1)) + dos_name[i];
	ld	e,#0x00
00121$:
	ld	a,l
	and	a, #0x01
	rrca
	and	a,#0x80
	ld	h,a
	ld	a,l
	and	a, #0xFE
	srl	a
	or	a, h
	ld	c,a
	ld	l,6 (ix)
	ld	h,7 (ix)
	ld	d,#0x00
	add	hl, de
	ld	l,(hl)
	add	hl, bc
	inc	e
	ld	a,e
	sub	a, #0x0B
	jr	C,00121$
;fat.c:1154: return crc;
	ld	sp,ix
	pop	ix
	ret
_fat_make_dos_name_end::
;fat.c:1158: u8 fat_make_record(u8 *name, u32 dir_entry, u16 slen, u8 is_dir) {
;	---------------------------------
; Function fat_make_record
; ---------------------------------
_fat_make_record_start::
_fat_make_record:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-63
	add	hl,sp
	ld	sp,hl
;fat.c:1169: u8 crc = 0;
	ld	-58 (ix),#0x00
;fat.c:1178: name_ptr = name;
	ld	a,4 (ix)
	ld	-43 (ix),a
	ld	a,5 (ix)
	ld	-42 (ix),a
;fat.c:1179: while (*name != 0) {
	ld	l,-43 (ix)
	ld	h,-42 (ix)
00103$:
	ld	a,(hl)
	or	a, a
	jr	Z,00105$
;fat.c:1180: if (*name == (u8) '/')name_ptr = name;
	sub	a, #0x2F
	jr	NZ,00102$
	ld	-43 (ix),l
	ld	-42 (ix),h
00102$:
;fat.c:1181: name++;
	inc	hl
	jr	00103$
00105$:
;fat.c:1183: if (*name_ptr == (u8) '/')name_ptr++;
	ld	l,-43 (ix)
	ld	h,-42 (ix)
	ld	a,(hl)
	sub	a, #0x2F
	jr	NZ,00107$
	inc	-43 (ix)
	jr	NZ,00256$
	inc	-42 (ix)
00256$:
00107$:
;fat.c:1186: if (dir_entry < 2)dir_entry = 2;
	ld	a,6 (ix)
	sub	a, #0x02
	ld	a,7 (ix)
	sbc	a, #0x00
	ld	a,8 (ix)
	sbc	a, #0x00
	ld	a,9 (ix)
	sbc	a, #0x00
	jr	NC,00109$
	ld	6 (ix),#0x02
	xor	a, a
	ld	7 (ix),a
	ld	8 (ix),a
	ld	9 (ix),a
00109$:
;fat.c:1188: str_len = str_length(name_ptr);
	ld	l,-43 (ix)
	ld	h,-42 (ix)
	push	hl
	call	_str_length
	pop	af
;fat.c:1189: if (str_len < 11) {
	ld	-44 (ix), l
	ld	a, l
	sub	a, #0x0B
	jr	NC,00112$
;fat.c:1191: sysMemSet(new_dos_name, ' ', 11);
	ld	hl,#0x0007
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	e, c
	ld	d, b
	push	bc
	ld	hl,#0x000B
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	push	de
	call	_sysMemSet
	pop	af
	pop	af
	inc	sp
	pop	bc
;fat.c:1192: new_dos_name[11] = 0;
	ld	hl,#0x000B
	add	hl,bc
	ld	(hl),#0x00
;fat.c:1193: for (i = 0; name_ptr[i] != 0; i++)new_dos_name[i] = name_ptr[i];
	ld	e,#0x00
00150$:
	ld	l,-43 (ix)
	ld	h,-42 (ix)
	ld	d,#0x00
	add	hl, de
	ld	a,(hl)
	ld	-9 (ix), a
	or	a, a
	jr	Z,00110$
	ld	l,e
	ld	h,#0x00
	add	hl,bc
	ld	a,-9 (ix)
	ld	(hl),a
	inc	e
	jr	00150$
00110$:
;fat.c:1194: name_ptr = (u8 *) new_dos_name;
	ld	-43 (ix),c
	ld	-42 (ix),b
;fat.c:1195: str_len = 11;
	ld	-44 (ix),#0x0B
00112$:
;fat.c:1200: entry = 0;
	xor	a, a
	ld	-21 (ix),a
	ld	-20 (ix),a
	ld	-19 (ix),a
	ld	-18 (ix),a
;fat.c:1202: clen = slen / fat_cluster_size;
	ld	a,(#_fat_cluster_size + 0)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	ld	-22 (ix),h
	ld	-23 (ix),l
;fat.c:1203: if (slen % fat_cluster_size != 0)clen++;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	ld	a,h
	or	a,l
	jr	Z,00114$
	inc	-23 (ix)
	jr	NZ,00258$
	inc	-22 (ix)
00258$:
00114$:
;fat.c:1204: resp = fat_seek_free_cluster(&entry, clen);
	ld	hl,#0x002A
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_fat_seek_free_cluster
	pop	af
	pop	af
;fat.c:1205: if (resp)return resp;
	ld	-57 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00116$
	ld	l,-57 (ix)
	jp	00158$
00116$:
;fat.c:1206: resp = fat_catch_clusters(entry, clen);
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	push	hl
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	push	hl
	call	_fat_catch_clusters
	pop	af
	pop	af
	pop	af
;fat.c:1207: if (resp)return resp;
	ld	-57 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00118$
	ld	l,-57 (ix)
	jp	00158$
00118$:
;fat.c:1209: if (is_dir) {
	ld	a,12 (ix)
	or	a, a
	jr	Z,00122$
;fat.c:1210: resp = fat_clean_cluster(entry, 1);
	ld	hl,#0x0001
	push	hl
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	push	hl
	call	_fat_clean_cluster
	pop	af
	pop	af
	pop	af
;fat.c:1211: if (resp)return resp;
	ld	-57 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00122$
	ld	l,-57 (ix)
	jp	00158$
00122$:
;fat.c:1215: len32 = 0;
	ld	-30 (ix),#0x00
;fat.c:1216: if (str_len == 11) {
	ld	a,-44 (ix)
	sub	a, #0x0B
	jr	NZ,00124$
;fat.c:1217: sysMemCopy(name_ptr, dos_name, 11);
	ld	hl,#0x0016
	add	hl,sp
	ld	bc,#0x000B
	push	bc
	push	hl
	ld	l,-43 (ix)
	ld	h,-42 (ix)
	push	hl
	call	_sysMemCopy
	ld	hl,#0x0006
	add	hl,sp
	ld	sp,hl
00124$:
;fat.c:1219: if (str_len > 11) {
	ld	a,#0x0B
	sub	a, -44 (ix)
	jr	NC,00128$
;fat.c:1220: len32 = str_len / 13;
	ld	a,#0x0D
	push	af
	inc	sp
	ld	a,-44 (ix)
	push	af
	inc	sp
	call	__divuchar_rrx_s
	pop	af
	ld	-30 (ix),l
;fat.c:1221: if (str_len % 13 != 0)len32++;
	ld	a,#0x0D
	push	af
	inc	sp
	ld	a,-44 (ix)
	push	af
	inc	sp
	call	__moduchar_rrx_s
	pop	af
	ld	a,l
	or	a, a
	jr	Z,00126$
	inc	-30 (ix)
00126$:
;fat.c:1223: crc = fat_make_dos_name(name_ptr, dos_name, fat_dir_size);
	ld	hl,#0x0016
	add	hl,sp
	ex	de,hl
	ld	hl,(_fat_dir_size)
	push	hl
	push	de
	ld	l,-43 (ix)
	ld	h,-42 (ix)
	push	hl
	call	_fat_make_dos_name
	pop	af
	pop	af
	pop	af
	ld	-58 (ix),l
00128$:
;fat.c:1227: attrib = is_dir ? 0x10 : 0x20;
	ld	a,12 (ix)
	or	a, a
	jr	Z,00160$
	ld	a,#0x10
	jr	00161$
00160$:
	ld	a,#0x20
00161$:
	ld	-59 (ix),a
;fat.c:1229: sector = 0;
	xor	a, a
	ld	-29 (ix),a
	ld	-28 (ix),a
	ld	-27 (ix),a
	ld	-26 (ix),a
;fat.c:1230: ptr = (u8 *) & fat_dat[512 - 32];
	ld	a,(#_fat_dat + 0)
	add	a, #0xE0
	ld	-62 (ix),a
	ld	a,(#_fat_dat + 1)
	adc	a, #0x01
	ld	-61 (ix),a
00154$:
;fat.c:1233: resp = fat_next_dir_sector(&dir_entry, &sector, &in_clust);
	ld	hl,#0x0003
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	a,-2 (ix)
	ld	-11 (ix),a
	ld	a,-1 (ix)
	ld	-10 (ix),a
	ld	hl,#0x0022
	add	hl,sp
	ld	-4 (ix),l
	ld	-3 (ix),h
	ld	a,-4 (ix)
	ld	-15 (ix),a
	ld	a,-3 (ix)
	ld	-14 (ix),a
	ld	hl,#0x0045
	add	hl,sp
	ld	-13 (ix),l
	ld	-12 (ix),h
	ld	a,-13 (ix)
	ld	-17 (ix),a
	ld	a,-12 (ix)
	ld	-16 (ix),a
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	_fat_next_dir_sector
	pop	af
	pop	af
	pop	af
;fat.c:1234: if (resp)return resp;
	ld	-57 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00130$
	ld	l,-57 (ix)
	jp	00158$
00130$:
;fat.c:1236: if (*ptr != 0)continue;
	ld	l,-62 (ix)
	ld	h,-61 (ix)
	ld	a,(hl)
	ld	-17 (ix), a
	or	a, a
	jr	NZ,00154$
;fat.c:1238: for (rec_idx = 0; rec_idx < 512; rec_idx += 32) {
	ld	-25 (ix),#0x00
	ld	-24 (ix),#0x00
00152$:
;fat.c:1239: if (fat_dat[rec_idx] == 0)break;
	ld	iy,(_fat_dat)
	ld	e,-25 (ix)
	ld	d,-24 (ix)
	add	iy, de
	ld	a, 0 (iy)
	or	a, a
	jr	Z,00135$
;fat.c:1238: for (rec_idx = 0; rec_idx < 512; rec_idx += 32) {
	ld	a,-25 (ix)
	add	a, #0x20
	ld	-25 (ix),a
	ld	a,-24 (ix)
	adc	a, #0x00
	ld	-24 (ix), a
	and	a, #0xFE
	jr	Z,00152$
00135$:
;fat.c:1241: if (rec_idx != 512)break;
	ld	a,-25 (ix)
	or	a, a
	jr	NZ,00262$
	ld	a,-24 (ix)
	sub	a, #0x02
	jp	Z,00154$
00262$:
;fat.c:1245: rec_idx /= 32;
	srl	-24 (ix)
	rr	-25 (ix)
	srl	-24 (ix)
	rr	-25 (ix)
	srl	-24 (ix)
	rr	-25 (ix)
	srl	-24 (ix)
	rr	-25 (ix)
	srl	-24 (ix)
	rr	-25 (ix)
;fat.c:1246: for (i = 0; i < len32; i++) {
	ld	a,-2 (ix)
	ld	-17 (ix),a
	ld	a,-1 (ix)
	ld	-16 (ix),a
	ld	a,-4 (ix)
	ld	-15 (ix),a
	ld	a,-3 (ix)
	ld	-14 (ix),a
	ld	-63 (ix),#0x00
00156$:
;fat.c:1248: fat_make_lfn(name_ptr, rec_idx, len32 - i - 1, crc);
	ld	a,-25 (ix)
	ld	-4 (ix),a
;fat.c:1246: for (i = 0; i < len32; i++) {
	ld	a,-63 (ix)
	sub	a, -30 (ix)
	jr	NC,00146$
;fat.c:1248: fat_make_lfn(name_ptr, rec_idx, len32 - i - 1, crc);
	ld	a,-30 (ix)
	sub	a, -63 (ix)
	ld	d,a
	dec	d
	ld	a,-58 (ix)
	push	af
	inc	sp
	push	de
	inc	sp
	ld	a,-4 (ix)
	push	af
	inc	sp
	ld	l,-43 (ix)
	ld	h,-42 (ix)
	push	hl
	call	_fat_make_lfn
	pop	af
	pop	af
	inc	sp
;fat.c:1249: rec_idx++;
	inc	-25 (ix)
	jr	NZ,00263$
	inc	-24 (ix)
00263$:
;fat.c:1250: if (rec_idx == 16) {
	ld	a,-25 (ix)
	sub	a, #0x10
	jr	NZ,00157$
	ld	a,-24 (ix)
	or	a, a
	jr	NZ,00157$
;fat.c:1251: rec_idx = 0;
	ld	-25 (ix),#0x00
	ld	-24 (ix),#0x00
;fat.c:1252: resp = fat_cache_save_data();
	call	_fat_cache_save_data
;fat.c:1253: if (resp)return resp;
	ld	-57 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00141$
	ld	l,-57 (ix)
	jp	00158$
00141$:
;fat.c:1254: resp = fat_next_dir_sector(&dir_entry, &sector, &in_clust);
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	ld	e,-15 (ix)
	ld	d,-14 (ix)
	ld	c,-13 (ix)
	ld	b,-12 (ix)
	push	hl
	push	de
	push	bc
	call	_fat_next_dir_sector
	pop	af
	pop	af
	pop	af
;fat.c:1255: if (resp)return resp;
	ld	-57 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00157$
	ld	l,-57 (ix)
	jp	00158$
00157$:
;fat.c:1246: for (i = 0; i < len32; i++) {
	inc	-63 (ix)
	jp	00156$
00146$:
;fat.c:1259: if (is_dir)slen = 0;
	ld	a,12 (ix)
	or	a, a
	jr	Z,00148$
	ld	10 (ix),#0x00
	ld	11 (ix),#0x00
00148$:
;fat.c:1260: resp = fat_make_hdr(dos_name, rec_idx, attrib, entry, (u32) slen * 512);
	ld	a,10 (ix)
	ld	-8 (ix),a
	ld	a,11 (ix)
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x00
	push	af
	pop	af
	ld	b,#0x09
00266$:
	sla	-8 (ix)
	rl	-7 (ix)
	rl	-6 (ix)
	rl	-5 (ix)
	djnz	00266$
	ld	hl,#0x0016
	add	hl,sp
	ld	-17 (ix),l
	ld	-16 (ix),h
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	push	hl
	ld	h,-59 (ix)
	ld	l,-4 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	_fat_make_hdr
	ld	iy,#0x000C
	add	iy,sp
	ld	sp,iy
;fat.c:1263: return resp;
	ld	-57 (ix), l
00158$:
	ld	sp,ix
	pop	ix
	ret
_fat_make_record_end::
;fat.c:1268: u8 fat_make_dir(FatFullRecord *rec, u8 *name) {
;	---------------------------------
; Function fat_make_dir
; ---------------------------------
_fat_make_dir_start::
_fat_make_dir:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-5
	add	hl,sp
	ld	sp,hl
;fat.c:1276: resp = fat_seek_record(name, rec, &root, 1);
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	e, c
	ld	d, b
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	push	de
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_fat_seek_record
	pop	af
	pop	af
	pop	af
	inc	sp
	pop	bc
;fat.c:1279: if (resp == 0)return FAT_ERR_EXIST;
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	NZ,00102$
	ld	l,#0xF1
	jp	00117$
00102$:
;fat.c:1280: if (resp == FAT_ERR_NOT_EXIST) {
	ld	a,-1 (ix)
	sub	a, #0xF0
	jp	NZ,00116$
;fat.c:1281: if (root == FAT_END_VAL)return FAT_ERR_PATH_NOT_EXIST;
	ld	a,-5 (ix)
	inc	a
	jr	NZ,00104$
	ld	a,-4 (ix)
	inc	a
	jr	NZ,00104$
	ld	a,-3 (ix)
	inc	a
	jr	NZ,00104$
	ld	a,-2 (ix)
	sub	a, #0x0F
	jr	NZ,00104$
	ld	l,#0xFA
	jp	00117$
00104$:
;fat.c:1282: resp = fat_make_record(name, root, fat_cluster_size, 1);
	ld	hl,#_fat_cluster_size + 0
	ld	e, (hl)
	ld	d,#0x00
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	push	de
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_fat_make_record
	ld	iy,#0x0009
	add	iy,sp
	ld	sp,iy
	pop	bc
;fat.c:1283: if (resp)return resp;
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00106$
	ld	l,-1 (ix)
	jp	00117$
00106$:
;fat.c:1285: resp = fat_seek_record(name, rec, &root, 1);
	ld	a,#0x01
	push	af
	inc	sp
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_fat_seek_record
	pop	af
	pop	af
	pop	af
	inc	sp
;fat.c:1286: if (resp == FAT_ERR_NOT_EXIST)return FAT_ERR_DIR_MAKE;
	ld	-1 (ix), l
	ld	a, l
	sub	a, #0xF0
	jr	NZ,00108$
	ld	l,#0xFF
	jp	00117$
00108$:
;fat.c:1287: if (resp)return resp;
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00110$
	ld	l,-1 (ix)
	jp	00117$
00110$:
;fat.c:1288: sector = fat_cluster_to_sector(rec->data_clsut);
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	bc,#0x00DC
	add	hl,bc
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	bc
	push	de
	call	_fat_cluster_to_sector
	pop	af
	pop	af
	push	de
	push	hl
	call	_fat_cache_read_dat
	pop	af
	pop	af
	ld	a,l
	pop	hl
;fat.c:1290: if (resp)return resp;
	ld	-1 (ix), a
	or	a, a
	jr	Z,00112$
	ld	l,-1 (ix)
	jp	00117$
00112$:
;fat.c:1293: fat_make_hdr("           ", 0, 0x10, rec->data_clsut, 0);
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	push	bc
	push	de
	ld	h, #0x10
	push	hl
	ld	hl,#__str_3
	push	hl
	call	_fat_make_hdr
	ld	hl,#0x000C
	add	hl,sp
	ld	sp,hl
;fat.c:1294: fat_make_hdr("           ", 1, 0x10, root, 0);
	ld	de,#__str_3
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	push	hl
	ld	hl,#0x1001
	push	hl
	push	de
	call	_fat_make_hdr
	ld	hl,#0x000C
	add	hl,sp
	ld	sp,hl
;fat.c:1295: fat_dat[0x00] = 0x2E;
	ld	hl,(_fat_dat)
	ld	(hl),#0x2E
;fat.c:1296: fat_dat[0x20] = 0x2E;
	ld	iy,#0x0020
	ld	de,(_fat_dat)
	add	iy, de
	ld	0 (iy), #0x2E
;fat.c:1297: fat_dat[0x21] = 0x2E;
	ld	iy,#0x0021
	ld	de,(_fat_dat)
	add	iy, de
	ld	0 (iy), #0x2E
;fat.c:1299: resp = fat_cache_save_data();
	call	_fat_cache_save_data
;fat.c:1300: if (resp)return resp;
	ld	-1 (ix), l
	ld	a, l
	or	a, a
	jr	Z,00116$
	ld	l,-1 (ix)
	jr	00117$
00116$:
;fat.c:1306: return resp;
	ld	l,-1 (ix)
00117$:
	ld	sp,ix
	pop	ix
	ret
_fat_make_dir_end::
__str_3:
	.ascii "           "
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
