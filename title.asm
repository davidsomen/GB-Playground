INCLUDE "constants.inc"

SECTION "title", ROMX

; ////////////////////////
; //                    //
; //  ASSETS            //
; //                    //
; ////////////////////////

INCLUDE "assets/ibmpc1.inc"
INCLUDE "assets/title.inc"
INCLUDE "assets/pencil.inc"
INCLUDE "assets/window.inc"

; ////////////////////////
; //                    //
; //  CONSTANTS         //
; //                    //
; ////////////////////////

FLASH_DELAY                 EQU $4
MOVE_DELAY                  EQU $2
TITLE_PALLETE_TABLE_SIZE    EQU $6;232
TITLE_PALLETE_TABLE:
    DB %11100100; black text
    DB %10010000
    DB %01000000
    DB %00000000; white
    DB %01000000
    DB %10010000
    ;DB %11100100; black
    ;DB %11111001
    ;DB %11111110
    ;DB %11111111; black
    ;DB %10111111
    ;DB %01101111
    ;DB %00011011; white text
    ;DB %01101111
    ;DB %10111111
    ;DB %11111111; black
    ;DB %10111111
    ;DB %01101111
    ;DB %00011011; white text
    ;DB %00000110
    ;DB %00000001
    ;DB %00000000; white
    ;DB %01000000
    ;DB %10010000
TextTileData:
    chr_IBMPC1      3,3
TextTileMap:
    DB $56,$53,$68,$5B,$56,$00,$5E,$61,$68,$57,$65,$00,$57,$64,$5B,$5D,$61
bug_tile_data_size  EQU $10
bug_tile_data::
    DW `22000022
    DW `00333300
    DW `03333330
    DW `33333333
    DW `33333333
    DW `03133330
    DW `00333300
    DW `22000022
    
SOUNDTEST:
    DW $00, $05, $01, $02, $03, $04, $05
    
; ////////////////////////
; //                    //
; //  INITIALISE        //
; //                    //
; ////////////////////////

title_init::
    ; reset timers
    ld a, 0
    ld [position_update_timer], a
    ld [title_pallete_update_timer], a
    ld [title_pallete_update_timer_index], a
    
; ////////////////////////
; //                    //
; //  LOAD TILES        //
; //                    //
; ////////////////////////  

    ; load title tile data
    ld de, title_tile_data_size
    ld bc, title_tile_data
    ld hl, VRAM_TILES_BG
    call memory_copy
    
    ; load window tile data
    ld de, window_tile_data_size
    ld bc, window_tile_data
    ld hl, VRAM_TILES_BG + title_tile_data_size
    call memory_copy
    
    ; Load pencil tile data
    ld de, pencil_tile_data_size
    ld bc, pencil_tile_data
    ld hl, VRAM_TILES_SPRITE
    call memory_copy
    
    ; Load bug tile data
    ld de, bug_tile_data_size
    ld bc, bug_tile_data
    ld hl, VRAM_TILES_SPRITE + pencil_tile_data_size
    call memory_copy
    
    ; Load text tile data
    ld bc, 8*31
    ld hl, TextTileData
    ld de, VRAM_TILES_BG + title_tile_data_size + window_tile_data_size
    call memory_copy_mono
    
; ////////////////////////
; //                    //
; //  LOAD MAPS         //
; //                    //
; ////////////////////////   
    
    ; load title map
INDEX SET 0
    REPT 18
        ld de, $15
        ld bc, title_map_data + ($14 * INDEX)
        ld hl, VRAM_MAP_BG + ($20 * INDEX)
        call memory_copy
INDEX SET INDEX + 1
    ENDR
    
    ; load window map
INDEX SET 0
    REPT 6
        ld de, $15
        ld bc, window_map_data + ($14 * INDEX)
        ld hl, VRAM_MAP_WIN + ($20 * INDEX)
        call memory_copy
INDEX SET INDEX + 1
    ENDR
    
    ; load text map
    ld de, 17
    ld bc, TextTileMap
    ld hl, VRAM_MAP_WIN + ($20 * 1) + 1
    call memory_copy
    
; ////////////////////////
; //                    //
; //  INIT SPRITES      //
; //                    //
; ////////////////////////    
    
    call pencil_init
    call bug_init
    
    ret
    
; ////////////////////////
; //                    //
; //  LOOP              //
; //                    //
; ////////////////////////

title_loop::
    call wait_vblank
    call joypad_update
    call pencil_update
    call bug_update

    ; update position timer
	ld a, [position_update_timer]
	inc a
	ld [position_update_timer], a
	
	;cp MOVE_DELAY
	;call z, update_title_position
	
	; update pallete timer
	;ld a, [title_pallete_update_timer]
	;inc a
	;ld [title_pallete_update_timer], a
	
	;cp FLASH_DELAY
	;call z, update_title_pallete

.update_title_position:
    ; reset position timer
    ld a, $0
    ld [position_update_timer], a

    ; move forward in y
    ldh	a, [SCROLL_Y]
	dec	a
	ldh	[SCROLL_Y], a

    ; move forward in x
    ldh	a, [SCROLL_X]
	dec	a
	ldh	[SCROLL_X], a
	
;.update_title_pallete:
;    ; reset pallete timer
;    ld a, $0
;    ld [title_pallete_update_timer], a
;    
;    ; move hl to current index
;    ld b, 0
;    ld a, [title_pallete_update_timer_index]
;    ld c, a
;    ld hl, TITLE_PALLETE_TABLE
;    add hl, bc
;    
;    ; set background pallete
;    ld a, [hl]
;	ldh [BG_PALLETE], a
;	
;	; if end of array then reset
;    ld a, [title_pallete_update_timer_index]
;    cp TITLE_PALLETE_TABLE_SIZE - 1
;    jp z, .reset_title_pallete_update_timer_index
;    
;    ; otherwise increment
;    ld a, [title_pallete_update_timer_index]
;    inc a
;	ld [title_pallete_update_timer_index], a
;	;ret
;    
;.reset_title_pallete_update_timer_index:
;    ld a, 0
;	ld [title_pallete_update_timer_index], a
;	;ret
	
	jr title_loop
	
; ////////////////////////
; //                    //
; //  VARIABLES         //
; //                    //
; ////////////////////////

SECTION "title_vars", WRAM0

position_update_timer: DS 1
title_pallete_update_timer: DS 1
title_pallete_update_timer_index: DS 1