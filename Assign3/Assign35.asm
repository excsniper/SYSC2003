	ORG	$1000
	
s_prox	fcc	"Proximity: "
	db 0

;test cases
t1:	dw	%1111111100000111
t2:	dw	%1000000001000000
t3	dw	%0000000001000111

	ORG	$4000
	LDS	#$3DFF

main:

;set baud rate	
	LDD	#BAUD19K
	JSR	setbaud

;t1
;%1111111100000111
;expecting ALL LEDs OFF, Buzzer ON

	LDY	#s_prox		;print "Proximity: "
	JSR	putStr_sc0
	
	LDD	t1		;print the value of proximity to be tested
	PSHD
	JSR	_printBin16
	PULD

	LDB	#$0A		;print a new line
	JSR	putChar_sc0

	LDD	t1		;testing the LED_Buzzer sub
	PSHD
	JSR	LED_Buzzer
	PULD
	
;t2
;%1000000001000000
;expecting only RED LED, and buzzer ON for 1s

	LDY	#s_prox
	JSR	putStr_sc0
	
	LDD	t2
	PSHD
	JSR	_printBin16
	PULD

	LDB	#$0A
	JSR	putChar_sc0

	LDD 	t2
	PSHD
	JSR	LED_Buzzer
	PULD

;t3
;%0000000001000111
;expecting GREEN, ORANGE LED and buzzer OFF

	LDY	#s_prox
	JSR	putStr_sc0
	
	LDD	t3
	PSHD
	JSR	_printBin16
	PULD

	LDB	#$0A
	JSR	putChar_sc0

	LDD	t3
	PSHD
	JSR	LED_Buzzer
	PULD


	SWI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void LED_Buzzer(int proximity)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;offsets
LED_Buzzer_proximity 	equ	4	;2bytes

;ports
LED_Buzzer_red			equ	%00000001
LED_Buzzer_orange		equ	%00000010
LED_Buzzer_yellow		equ	%00000100
LED_Buzzer_green		equ	%00001000
LED_Buzzer_buzzer		equ	%00100000

LED_Buzzer:

	PSHD				;save D

	MOVB 	#%00111111, DDRK	;Set up DDRK
	MOVB	#$00, PORTK		;Turn off everything

;motor is off
	BRCLR	LED_Buzzer_proximity+1, SP, #%01000000, LED_Buzzer_collision

LED_Buzzer_directions:
	
	LDAB	#%00000111			;mask proximity, keeping only the 3 LSB
	ANDB	LED_Buzzer_proximity+1, SP

;8 if statements, one for each direction

;0	
	BEQ	LED_Buzzer_N

;1	
	DBEQ	B, LED_Buzzer_S

;2	
	DBEQ	B, LED_Buzzer_E

;3	
	DBEQ	B, LED_Buzzer_W

;4	
	DBEQ	B, LED_Buzzer_NE

;5	
	DBEQ	B, LED_Buzzer_NW

;6	
	DBEQ	B, LED_Buzzer_SE

;7	
	DBEQ	B, LED_Buzzer_SW	

LED_Buzzer_N:

	BSET	PORTK, #LED_Buzzer_red	;turn on the red LED
	BRA 	LED_Buzzer_collision

LED_Buzzer_S:

	BSET	PORTK, #LED_Buzzer_green	;turn on the green LED
	BRA 	LED_Buzzer_collision

LED_Buzzer_E:

	BSET	PORTK, #LED_Buzzer_yellow	;turn on the yello LED
	BRA 	LED_Buzzer_collision
	
LED_Buzzer_W:

	BSET	PORTK, #LED_Buzzer_orange	;since there's no blue LED, turn on the orange one instead
	BRA 	LED_Buzzer_collision
	
LED_Buzzer_NE:

	BSET	PORTK, #LED_Buzzer_red
	BSET	PORTK, #LED_Buzzer_yellow
	BRA 	LED_Buzzer_collision

LED_Buzzer_NW:

	BSET	PORTK, #LED_Buzzer_red
	BSET	PORTK, #LED_Buzzer_orange
	BRA 	LED_Buzzer_collision
	
LED_Buzzer_SE:

	BSET	PORTK, #LED_Buzzer_green
	BSET	PORTK, #LED_Buzzer_yellow
	BRA 	LED_Buzzer_collision

LED_Buzzer_SW:

	BSET	PORTK, #LED_Buzzer_green
	BSET	PORTK, #LED_Buzzer_orange
	BRA 	LED_Buzzer_collision

LED_Buzzer_collision:

;collision
	BRCLR	LED_Buzzer_proximity, SP, #%10000000, LED_Buzzer_done

;if there is a collision, turn on the buzzer and wait 1s
	BSET	PORTK, #LED_Buzzer_buzzer	

	JSR 	oneSec			;wait!

;then turn it off again
	BCLR	PORTK, #LED_Buzzer_buzzer

LED_Buzzer_done:

	PULD	

	RTS

;a blocking function to wait for about one second
oneSec:
	PSHD
	PSHX
	PSHY

	LDY	#$FFFF

oneSec_loop:

	IDIV		;wasting time, 12 cycles for each IDIV
	IDIV
	IDIV
	IDIV
	IDIV
	IDIV

	DBNE	Y, oneSec_loop

	PULY
	PULX
	PULD

	RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        Copied from question 1                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;void printBin(byte num)
;num is an 8bit value to be printed
num	EQU	4

_printBin:

		PSHD
		LDAA	#8
	
printBinLoop:

		LSL 	num, SP
		BCC 	printBinNoCarry

printBinCarry:
	
		LDAB 	#'1'
		BRA 	printBinNext

printBinNoCarry:

		LDAB 	#'0'
	
printBinNext:

		JSR 	putChar_sc0
		DBNE	A, printBinLoop

;done
		PULD

		RTS

;void printBin16(int num)
;num is an 16bit value to be printed

_printBin16:

		PSHA
		JSR 	_printBin
		PULA

		PSHB
		JSR 	_printBin
		PULB

		RTS


#include "../include/DP256reg.asm"
#include "../include/sci0api.asm"
	
	END
