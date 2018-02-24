IF  !DEF(CONSTANTS)
CONSTANTS   SET 1

; ////////////////////////
; //                    //
; //  HEADER CONSTANTS  //
; //                    //
; ////////////////////////

NINTENDO_LOGO:  MACRO

DB $CE,$ED,$66,$66,$CC,$0D,$00,$0B
DB $03,$73,$00,$83,$00,$0C,$00,$0D
DB $00,$08,$11,$1F,$88,$89,$00,$0E
DB $DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
DB $BB,$BB,$67,$63,$6E,$0E,$EC,$CC
DB $DD,$DC,$99,$9F,$BB,$B9,$33,$3E

ENDM

; ////////////////////////
; //                    //
; //  INITIALISATION    //
; //                    //
; ////////////////////////

STACK_TOP           EQU $FFFF

; ////////////////////////
; //                    //
; //  SCREEN ADDRESSES  //
; //                    //
; ////////////////////////

BG_PALLETE          EQU $FF47       ;$47; $FF47
S1_PALLETE          EQU $FF48       ;$48; $FF48
S2_PALLETE          EQU $FF49       ;$49; $FF49

SCROLL_Y            EQU $FF42       ;$42; $FF42
SCROLL_X            EQU $FF43       ;$43; $FF43

LCD_CONTROL         EQU $FF40       ;$40; $FF40 ; LCD (Graphics) Control
LCD_SCAN_Y          EQU $FF44       ;$44; $FF44

VRAM_TILES_SPRITE   EQU $8000
VRAM_TILES_BG       EQU $9000

VRAM_MAP_BG         EQU $9C00
VRAM_MAP_WIN        EQU $9800

SPRITE_OAM          EQU $FE00       ; Object attributes memory

WINDOW_Y            EQU $FF4A
WINDOW_X            EQU $FF4B

; ////////////////////////
; //                    //
; //  SCREEN CONSTANTS  //
; //                    //
; ////////////////////////

VBLANK_Y_LIMIT      EQU 144
PALLETE_DEFAULT     EQU %11100100

BKG_DISP_FLAG		EQU %00000001   ; background tile map is on if set
SPRITE_DISP_FLAG	EQU %00000010   ; sprites are on if set
SPRITE_DISP_SIZE	EQU %00000100   ; sprite size (0=8x8 pixels, 1=16x8)
BKG_MAP_LOC			EQU %00001000   ; background tile map location (0=$9800-$9bff, 1=$9c00-$9fff)
TILES_LOC			EQU %00010000	; tile data location (0=$8800-$97ff, 1=$8000-$8fff)
WINDOW_DISP_FLAG	EQU %00100000	; window tile map is on if set
WINDOW_MAP_LOC		EQU $01000000	; window tile map location (0=$9800-$9bff, 1=$9c00-9fff)
DISPLAY_FLAG		EQU %10000000	; LCD display on if set

SCRN_X              EQU  160 ; Width of screen in pixels
SCRN_Y              EQU  144 ; Height of screen in pixels
SCRN_X_B            EQU  20  ; Width of screen in bytes
SCRN_Y_B            EQU  18  ; Height of screen in bytes
            
SCRN_VX             EQU  256 ; Virtual width of screen in pixels
SCRN_VY             EQU  256 ; Virtual height of screen in pixels
SCRN_VX_B           EQU  32  ; Virtual width of screen in bytes
SCRN_VY_B           EQU  32  ; Virtual height of screen in bytes

; ////////////////////////
; //                    //
; //  JOYPAD ADDRESSES  //
; //                    //
; ////////////////////////

JOYPAD_REGISTER     EQU $00; $FF00

; ////////////////////////
; //                    //
; //  JOYPAD CONSTANTS  //
; //                    //
; ////////////////////////

JOYPAD_PORT_DPAD    EQU %00100000
JOYPAD_PORT_BUTTONS EQU %00010000
JOYPAD_READ_CYCLES  EQU 6
JOYPAD_OUTPUT_MASK  EQU %00001111
JOYPAD_RESET        EQU $30

JOYPAD_DOWN			EQU 7
JOYPAD_UP			EQU 6
JOYPAD_LEFT			EQU 5
JOYPAD_RIGHT		EQU 4
JOYPAD_START		EQU 3
JOYPAD_SELECT		EQU 2
JOYPAD_B			EQU 1
JOYPAD_A			EQU 0

ENDC

; ////////////////////////
; //                    //
; //  SPRITE FLAGS      //
; //                    //
; ////////////////////////

OAMF_PRI    EQU  %10000000 ; Priority
OAMF_YFLIP  EQU  %01000000 ; Y flip
OAMF_XFLIP  EQU  %00100000 ; X flip
OAMF_PAL0   EQU  %00000000 ; Palette number 0
OAMF_PAL1   EQU  %00010000 ; Palette number 1