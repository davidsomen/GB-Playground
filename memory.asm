INCLUDE "constants.inc"
SECTION "memory", ROMX

; de = block size
; bc = source address
; hl = destination address
memory_copy::
.loop:
    ld a, [bc]
    ld [hl], a
    inc bc
    inc hl
    dec de

.memcpy_check_limit:
    ld a, e
    cp $00
    jr nz, .loop
    ld a, d
    cp $00
    jr nz, .loop
    
    ret
    
; b  = value
; de = block size
; hl = destination address
memory_fill::
.loop:
    ld [hl], b
    inc hl
    dec de

.check_limit:
    ld a, e
    cp $00
    jr nz, .loop
    ld a, d
    cp $00
    jr nz, .loop
    
    ret
    
;*   hl - pSource
;*   de - pDest
;*   bc - bytecount of Source 
memory_copy_mono::
	inc	b
	inc	c
	jr .skip
	
.loop
    ld a, [hl+]
	ld	[de], a
	inc	de
    ld [de], a
    inc de
        
.skip
    dec c
	jr nz, .loop
	dec b
	jr nz, .loop
	
	ret