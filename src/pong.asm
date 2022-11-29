         *= $1000

; labels
lstx     = $c5
raster   = $d012
vrram    = $1500
spram    = $2000
sppdt    = 128
sppdb    = 129
spbal    = 130
spena    = $d015
sptr0    = $07f8
sptr1    = sptr0+$01
sptr2    = sptr0+$02
spmcena  = $d01c
spmcol0  = $d025
spmcol1  = $d026
spcolor0 = $d027
spcolor1 = $d028
spcolor2 = $d029
sposx0   = $d000
sposy0   = $d001
sposx1   = $d002
sposy1   = $d003
sposx2   = $d004
sposy2   = $d005
spexpy   = $d017
spxmsb   = $d010
; actions / keycodes
p1up     = 9  ; w
p1down   = 13 ; s
p2up     = 33 ; i
p2down   = 37 ; k

; variables
ballx    = vrram
bally    = vrram+$02
ballvx   = vrram+$03
ballvy   = vrram+$04

; start of the program
start    lda #7       ; 0,1,2
         sta spena    ; sprite enable
         sta spmcena  ; sprite mc enable

         lda #3       ; 0,1
         sta spexpy   ; sprite y expand

         lda #sppdt
         sta sptr0    ; sprite ptr

         lda #sppdb
         sta sptr1    ; sprite ptr

         lda #spbal
         sta sptr2    ; sprite ptr

         lda #$06
         sta spmcol0
         lda #$0e
         sta spmcol1  ; sprite mcolor

         lda #$0f
         sta spcolor0 ; sprite 0 color

         lda #$0a
         sta spcolor1 ; sprite 1 color

         lda #$0f
         sta spcolor2 ; sprite 2 color

         lda #23
         sta sposx0
         lda #100
         sta sposy0   ; sprite 0 pos

         lda #200
         sta sposx1
         lda #100
         sta sposy1   ; sprite 1 pos

         lda #127
         sta sposx2
         lda #127
         sta sposy2   ; sprite 2 pos

init     lda #320/2
         sta ballx
         lda #127
         sta bally
         lda #255
         sta ballvx
         sta ballvy

; main loop
loop     inc $d020

         lda #240
         cmp raster
         bne loop     ; raster sync

         jsr mvball   ; move ball

         jmp input

; input handling
input    ldx lstx
         cpx #p1up
         beq mvp1up

         cpx #p1down
         beq mvp1down

         cpx #p2up
         beq mvp2up

         cpx #p2down
         beq mvp2down

         jmp loop

; move ball
mvball
         clc
         lda ballvx
         adc ballx
         ;and #1    ; fix this
         ;spxmsb
         sta ballx
         sta sposx2

         clc
         lda ballvy
         adc bally
         sta bally
         sta sposy2

         jsr bounce

         rts

;bounce routine
bounce
         lda $d01e ; collision register
         cmp #5
         beq flip
         cmp #6
         beq flip
         rts

; todo
flip     eor #$ff
         clc
         adc ballvx
         clc
         adc ballvy
         rts


; movement
mvp1up   dec sposy0
         jmp loop

mvp1down inc sposy0
         jmp loop

mvp2up   dec sposy1
         jmp loop

mvp2down inc sposy1
         jmp loop

         *= spram
         .include "pong.sprites"

square
         .byte $ff,$ff,$ff ; 0
         .byte $ff,$ff,$ff ; 1
         .byte $80,$00,$01 ; 2
         .byte $80,$00,$01 ; 3
         .byte $80,$00,$01 ; 4
         .byte $80,$00,$01 ; 5
         .byte $80,$00,$01 ; 6
         .byte $80,$00,$01 ; 7
         .byte $80,$00,$01 ; 8
         .byte $80,$00,$01 ; 9
         .byte $80,$00,$01 ; 10
         .byte $80,$01,$01 ; 11
         .byte $80,$00,$01 ; 12
         .byte $80,$00,$01 ; 13
         .byte $80,$00,$01 ; 14
         .byte $80,$00,$01 ; 15
         .byte $80,$00,$01 ; 16
         .byte $80,$00,$01 ; 17
         .byte $80,$00,$01 ; 18
         .byte $80,$00,$01 ; 19
         .byte $ff,$ff,$ff ; 20
         .byte $ff,$ff,$ff ; 21
