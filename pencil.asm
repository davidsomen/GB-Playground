INCLUDE "constants.inc"

SECTION "pencil", ROMX

; ////////////////////////
; //                    //
; //  CONSTANTS         //
; //                    //
; ////////////////////////

PENCIL_Y_INIT       EQU SCRN_Y/2
PENCIL_X_INIT       EQU SCRN_X/2

PENCIL_TOP_LEFT     EQU $00
PENCIL_TOP_RIGHT    EQU $01
PENCIL_BOTTOM_LEFT  EQU $02
PENCIL_BOTTOM_RIGHT EQU $03

; ////////////////////////
; //                    //
; //  INITIALISE        //
; //                    //
; ////////////////////////

pencil_init::
    ; init position
    ld a, PENCIL_Y_INIT
    ld [pencil_y], a
    ld a, PENCIL_X_INIT
    ld [pencil_x], a
    
    ret
    
; ////////////////////////
; //                    //
; //  UPDATE            //
; //                    //
; ////////////////////////

pencil_update::

; ////////////////////////
; //                    //
; //  CHECK JOYPAD      //
; //                    //
; ////////////////////////

    ld a, [joypad_held]
    bit JOYPAD_RIGHT, a
    jp z, .check_left
    ld a, [pencil_x]
    inc a
    ld [pencil_x], a
    
.check_left
    ld a, [joypad_held]
    bit JOYPAD_LEFT, a
    jp z, .check_up
    ld a, [pencil_x]
    dec a
    ld [pencil_x], a
    
.check_up
    ld a, [joypad_held]
    bit JOYPAD_UP, a
    jp z, .check_down
    ld a, [pencil_y]
    dec a
    ld [pencil_y], a
    
.check_down
    ld a, [joypad_held]
    bit JOYPAD_DOWN, a
    jp z, .update
    ld a, [pencil_y]
    inc a
    ld [pencil_y], a
    
; ////////////////////////
; //                    //
; //  UPDATE OAM        //
; //                    //
; ////////////////////////
    
.update
    ld HL, SPRITE_OAM + ($4 * 0)
    ld a, [pencil_y]
    add a, $10; y offset
    ld [HL], a; y
    inc L
    ld a, [pencil_x]
    add a, $08; x offset
    ld [HL], a; x
    inc L
    ld [HL], PENCIL_TOP_RIGHT; tile
    inc L
    ld [HL], OAMF_XFLIP; flags
    
    ld HL, SPRITE_OAM + ($4 * 1)
    ld a, [pencil_y]
    add a, $10; y offset
    ld [HL], a; y
    inc L
    ld a, [pencil_x]
    add a, $10; x offset
    ld [HL], a; x
    inc L
    ld [HL], PENCIL_TOP_LEFT; tile
    inc L
    ld [HL], OAMF_XFLIP; flags
    
    ld HL, SPRITE_OAM + ($4 * 2)
    ld a, [pencil_y]
    add a, $18; y offset
    ld [HL], a; y
    inc L
    ld a, [pencil_x]
    add a, $08; x offset
    ld [HL], a; x
    inc L
    ld [HL], PENCIL_BOTTOM_RIGHT; tile
    inc L
    ld [HL], OAMF_XFLIP; flags
    
    ld HL, SPRITE_OAM + ($4 * 3)
    ld a, [pencil_y]
    add a, $18; y offset
    ld [HL], a; y
    inc L
    ld a, [pencil_x]
    add a, $10; x offset
    ld [HL], a; x
    inc L
    ld [HL], PENCIL_BOTTOM_LEFT; tile
    inc L
    ld [HL], OAMF_XFLIP; flags

    ret
    
; ////////////////////////
; //                    //
; //  VARIABLES         //
; //                    //
; ////////////////////////

SECTION "pencil_vars", WRAM0

pencil_y: DS 1
pencil_x: DS 1