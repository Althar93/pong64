         *= $1000

; labels
lstx     = $c5
raster   = $d012
spram    = $2000
sploc0   = 128
spena    = $d015
sptr0    = $07f8
sptr1    = sptr0+1
spcolor0 = $d027
spcolor1 = $d028
sposx0   = $d000
sposy0   = $d001
sposx1   = $d002
sposy1   = $d003

; actions / keycodes
p1up     = 9  ; w
p1down   = 13 ; s
p2up     = 33 ; i
p2down   = 37 ; k

; start of the program
start    lda #3
         sta spena    ; sprite enable

         ; paddle
         lda #sploc0
         sta sptr0    ; sprite ptr
         sta sptr1    ; sprite ptr

         lda #$05
         sta spcolor0 ; sprite 0 color

         lda #$0a
         sta spcolor1 ; sprite 1 color

         lda #127
         sta sposx0
         lda #100
         sta sposy0   ; sprite 0 pos

         lda #200
         sta sposx1
         lda #100
         sta sposy1

; main loop
loop     inc $d020

         lda #240
         cmp raster
         bne loop     ; raster sync

         jmp input

                 ;test


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
         .byte $80,$00,$01 ; 11
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
