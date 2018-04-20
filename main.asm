INCLUDE "constants.inc"
INCLUDE "header.inc"

SECTION "main", ROMX
    
; ////////////////////////
; //                    //
; //  INIT              //
; //                    //
; ////////////////////////

main:
    ld SP, STACK_TOP

    call wait_vblank
    call lcd_off

    ld a, PALLETE_DEFAULT
	ld [BG_PALLETE], a
	ld [S1_PALLETE], a
	ld [S2_PALLETE], a
    
    ld hl, SCROLL_Y
    ld [hl], $00
    ld hl, SCROLL_X
    ld [hl], $00
    
    ld hl, WINDOW_Y
    ld [hl], 0
    ld hl, WINDOW_X
    ld [hl], 7
    
    ; enable LCD options
    ld a, BKG_DISP_FLAG + SPRITE_DISP_FLAG + BKG_MAP_LOC + WINDOW_DISP_FLAG
    ld [LCD_CONTROL], a
    
    ; clear OAM
    ld b, $00
    ld de, $9F
    ld hl, SPRITE_OAM
    call memory_fill
    
    call lcd_on
    
; ////////////////////////
; //                    //
; //  LOOP              //
; //                    //
; ////////////////////////
    
.loop:
    call wait_vblank
    call lcd_off
    call title_init
    call lcd_on
    
    call title_loop
    
    ;ld a, 0
    ;call DS_Play
    
    jr .loop
    
;include	"music/DevSound.asm"