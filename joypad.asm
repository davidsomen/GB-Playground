INCLUDE "constants.inc"

SECTION "joypad", ROMX

joypad_update::
    ; get d-pad state
    ld a, JOYPAD_PORT_DPAD
    ldh [JOYPAD_REGISTER], a
    
    ; takes a few cycles
    REPT JOYPAD_READ_CYCLES
    ldh a, [JOYPAD_REGISTER]
    ENDR

    cpl; flip the bits
    and JOYPAD_OUTPUT_MASK; mask high nibble
    
    swap a; swap nibbles
    ld b, a; store temp
    
    ; get button state
    ld a, JOYPAD_PORT_BUTTONS
    ldh [JOYPAD_REGISTER], a
    
    ; takes a few cycles
    REPT JOYPAD_READ_CYCLES
    ldh a, [JOYPAD_REGISTER]
    ENDR
    
    cpl; flip bits
    and JOYPAD_OUTPUT_MASK; mask high nibble
    
    or b; combine states
    ld b, a; store temp
    
    ld a, [joypad_held]; load last held
    
    cpl; flip bits
    and b; check persistant bits
    
    ld [joypad_down], a; store new bits
    
    ld a, b
    ld [joypad_held], a; store persistant bits
    
    ; reset
    ld a, JOYPAD_RESET
    ldh [JOYPAD_REGISTER], a
    
    ret
    
; //////////////////////
; //                  //
; //  VARIABLE SETUP  //
; //                  //
; //////////////////////    
    
SECTION "joypad_vars", WRAM0
    
joypad_held:: DS 1
joypad_down:: DS 1