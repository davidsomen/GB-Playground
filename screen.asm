INCLUDE "constants.inc"

SECTION "screen", ROMX

wait_vblank::
    ld a, [LCD_SCAN_Y]
    
; weird scroll effect test
;   ld b, a
;   ldh	a, [SCROLL_Y]
;	sub	b
;	ld a, b
;	ldh	[SCROLL_X], a
   
    cp 0
    jr nz, .next1
    ld HL, LCD_CONTROL
    set 5, [HL]
.next1
    cp 40
    jr nz, .next2
    ld HL, LCD_CONTROL
    res 5, [HL]
    ret
.next2

    cp VBLANK_Y_LIMIT
    jr nz, wait_vblank
    ret
   
lcd_off::
    ld HL, LCD_CONTROL
    res 7, [HL]
    ret
   
lcd_on::
    ld HL, LCD_CONTROL
    set 7, [HL]
    ret