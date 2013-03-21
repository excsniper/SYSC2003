;; D-BUG12 Emulator
;; Copyright (c) 1998, Thomas Almy. All rights reserved. 
;; Revised October 1999.
;; License is granted users of his 68HC12 Simulator
;; to use this file as part of their own programs for
;; educational or personal (but not commercial) use. This
;; file may not be given or sold to anyone without permission
;; of the author. 
;; Thomas Almy makes no representation about the suitability
;; of this software for any purpose. It is provided as is without
;; warranty of any kind, expressed or implied.

;; ***How to use the D-BUG12 Emulator***
; The D-BUG12 Emulator is a minimal implementation which has the following
; functionality:
; 1. Handles the reset vector.
; 2. Implements SetUserVector, GetChar, Putchar (if you want more, feel free
;    to add the functionality and send your extension back to me for
;    incorporation in future versions of this file).
; 3. Allows SWI to end program execution
; 4. Disables COP timer, set stack pointer, initializes SCI 0 to 9600bps,
;    sets clock stretch, and clears X bit as part of initialization.
; 
; Naturally a full D-BUG12 emulation is not necessary, because the 68HC12
; simulator has the capabilities of the D-BUG12 user interface.
;
; To use this routine, first assemble it. Then:
; 1. From the Simulator, load DBUG12.S19.
; 2. Load your program.
; 3. Do a reset, then "go". Execution will stop at a BGND instruction.
; 4. Set the PC to the start of your program, if not at $4000.
; 5. Use "go" or "trace" normally.
; 6. If execution stops with a D-BUG12 BGND instruction with the next 
;    instruction displayed being a "BRA", register X contains the vector
;    number of the interrupt that occured (i.e., 27 ($1b) would be an SWI
;    instruction.)
; 7. If execution stops with a D-BUG12 BGND instruction where the next 
;    instruction displayed being a "RTS", this is an un-implemented D-BUG12
;    routine. Feel free to write it for extra credit.


#include EQUATES.ASM
        ORG     $A00    ; RAM interrupt table
table   ds      58
tabend  equ     *
;; Routine Vector table
        ORG     $FE00
        dw      die
        dw      getchar
        dw      putchar
        dw      die
        dw      die
        dw      die
        dw      die
        dw      die
        dw      die
        dw      die
        dw      die
        dw      die
        dw      die
        dw      setuv   ; $fe1a
        dw      die
        dw      die
        dw      die
        dw      die
        ORG     $FFCE   ; Vector table
        dw      keyhint ; ffce
        dw      keyjint ; ffd0
        dw      atdint  ; ffd2
        dw      sci1int ; ffd4
        dw      sci0int ; ffd6
        dw      spiint  ; ffd8
        dw      paieint ; ffda
        dw      paoint  ; ffdc
        dw      tovint  ; ffde
        dw      tc7int  ; ffe0
        dw      tc6int  ; ffe2  
        dw      tc5int  ; ffe4
        dw      tc4int  ; ffe6
        dw      tc3int  ; ffe8
        dw      tc2int  ; ffea
        dw      tc1int  ; ffec
        dw      tc0int  ; ffee
        dw      rtiint  ; fff0
        dw      irqint  ; fff2
        dw      xirqint ; fff4
        dw      swiint  ; fff6
        dw      trapint ; fff8
        dw      coprst  ; fffa
        dw      clkrst  ; fffc
        dw      rstrst  ; fffe
        
        ORG     $F000   ; Start of "ROM"
die:    bgnd            ; We can't handle call
        rts             ; so stop then return
clkrst:
coprst:
rstrst: ; On reset, clear the user table,
        ; set the stack pointer, clear the X flag
	; turn off clock timer, set the ECLK delays
        ; and return to the monitor
        ldx     #table
l1:     clr     1,X+
        cpx     #tabend
        bne     l1
	clr	COPCTL
	movb	#$35 CSSTR0
	movb	#$ff CSSTR1
        andcc   #$bf
	movw	#52 SC0BDH
	movb	#$0c SC0CR2
        lds     #$a00
l2:     bgnd            ; Stop, then proceed to $4000
        jmp	PRSTART
swiint: ldx     #UserSWI*2
        bra     handler
trapint: ldx    #UserTrap*2
        bra     handler
xirqint: ldx    #UserXIRQ*2
        bra     handler
irqint: ldx     #UserIRQ*2
        bra     handler
rtiint: ldx     #UserRTI*2
        bra     handler
tovint: ldx     #UserTimerOvf*2
        bra     handler
paieint: ldx    #UserPAccEdge*2
        bra     handler
paoint: ldx     #UserPAccOvf*2
        bra     handler
tc0int: ldx     #UserTimerCh0*2
        bra     handler
tc1int: ldx     #UserTimerCh1*2
        bra     handler
tc2int: ldx     #UserTimerCh2*2
        bra     handler
tc3int: ldx     #UserTimerCh3*2
        bra     handler
tc4int: ldx     #UserTimerCh4*2
        bra     handler
tc5int: ldx     #UserTimerCh5*2
        bra     handler
tc6int: ldx     #UserTimerCh6*2
        bra     handler
tc7int: ldx     #UserTimerCh7*2
        bra     handler
spiint: ldx     #UserSPI0*2
        bra     handler
sci0int: ldx    #UserSCI0*2
        bra     handler
sci1int: ldx    #UserSCI1*2
        bra     handler
atdint: ldx     #UserAtoD*2
        bra     handler
keyjint: ldx    #UserPortJKWU*2
        bra     handler
keyhint: ldx    #UserPortHKWU*2
handler: ldy    table,X         ; See if there is a vector
        beq     noHandler
        jmp     0,Y
noHandler:
        xgdx
        lsrd
        xgdx
        bgnd                    ; Stop because no handler
                                ; X has table index
        bra     noHandler

getchar:
	brclr	SC0SR1 #$20 getchar	; wait for character available
	ldab	SC0DRL
	rts

putchar:
	brclr	SC0SR1 #$80 putchar     ; wait until buffer clear
	stab	SC0DRL
	rts

setuv:  cpd     #-1     ; Check value
        bne     setvec  ; set vector if not -1
        ldd     #table  ; else return table address
        rts
outOfRange:
        ldd     #-1     ; invalid request
        rts
setvec: cpd     #UserPortHKWU
        blt     outOfRange
        cpd     #UserTrap
        bgt     outOfRange
        asld
        addd    #table
        tfr     D X     ; put offset into x
        movw    2,SP 0,X        ; set value
        ldd     #0
        rts

