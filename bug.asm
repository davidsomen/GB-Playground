INCLUDE "constants.inc"

SECTION "bug", ROMX

; ////////////////////////
; //                    //
; //  CONSTANTS         //
; //                    //
; ////////////////////////

BUG_Y_INIT          EQU 8+(8*6) + 3
BUG_X_INIT          EQU SCRN_X/2

BUG_SPRITE          EQU $04

; ////////////////////////
; //                    //
; //  INITIALISE        //
; //                    //
; ////////////////////////

bug_init::
    ; init position
    ld a, BUG_Y_INIT
    ld [bug_y], a
    ld a, BUG_X_INIT
    ld [bug_x], a
    
    ret
    
; ////////////////////////
; //                    //
; //  UPDATE            //
; //                    //
; ////////////////////////

bug_update::
    
; ////////////////////////
; //                    //
; //  UPDATE OAM        //
; //                    //
; ////////////////////////
    
    ld HL, SPRITE_OAM + ($4 * 4)
    ld a, [bug_y]
    ld [HL], a; y
    inc L
    ld a, [bug_x]
    ld [HL], a; x
    inc L
    ld [HL], BUG_SPRITE; tile
    inc L
    ld [HL], %00000000; flags

    ret
    
; ////////////////////////
; //                    //
; //  VARIABLES         //
; //                    //
; ////////////////////////

SECTION "bug_vars", WRAM0

bug_y: DS 1
bug_x: DS 1