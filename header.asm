SECTION "header_ROM", ROM0

; $0000 - $003F: RST handlers.
ret
REPT 7
    nop
ENDR
ret
REPT 7
    nop
ENDR
ret
REPT 7
    nop
ENDR
ret
REPT 7
    nop
ENDR
ret
REPT 7
    nop
ENDR
ret
REPT 7
    nop
ENDR
ret
REPT 7
    nop
ENDR
ret
REPT 7
    nop
ENDR

; $0040 - $0067: Interrupt handlers.
jp draw
REPT 5
    nop
ENDR

jp stat
REPT 5
    nop
ENDR

jp timer
REPT 5
    nop
ENDR

jp serial
REPT 5
    nop
ENDR

jp joypad
REPT 5
    nop
ENDR

; $0068 - $00FF: Free space.
DS $98

; $0100 - $0103: Startup handler.
nop
jp main

; HEADER
; $0104 - $0133: The Nintendo Logo.
    NINTENDO_LOGO

; $0134 - $013E: The title.
DB "DAVIDSOMEN"
DS 1; padding

; $013F - $0142: Manafacturer code.
DS 4

; $0143: CGB compatability flag.
DB $00; unsupported

; $0144 - $0145: Licensee code.
DB "DS"

; $0146: SGB compatability flag.
DB $00; unsupported

; $0147: Cartridge type.
DB $00; Cart rom only

; $0148: Rom size.
DB $00; 32K rom (2 banks)

; $0149: Ram size.
DB $00; No ram

; $014A: Region code.
DB $01; international

; $014B: Old licensee code.
DB $33; new licensee code is used

; $014C: ROM version
DB $00

; $014D: Header checksum
DB $FF

; $014E - $014F: Global checksum
DW $FACE

; $0150: start
start:
    jp main
        
draw:
stat:
timer:
serial:
joypad:
    reti