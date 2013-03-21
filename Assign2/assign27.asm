; void itoa(reg D=signed-int16, reg X=straddr)
; A function to convert a 16-bit signed integer into a null terminated string
; and store the result into the return address specified. 8bit per char.

;DEBUG CODE PLEASE IGNORE!!
;	org $4000

;MSG:	DS 8

;	LDS #$3DFF
;	LDD $-10010	;CBC7 signed
;	LDX #MSG
;	JSR itoa

;	LDD	#BAUD19K		;program SCI0's baud rate
;	JSR	setbaud

;	LDY	#MSG	;output the first string
;	JSR	putStr_sc0

;	BRA 	*

;data
NULL    EQU 	0

;;;;;;;;;;;; WARNING; THIS SUB IS DESTRUCTIVE TO REG x ;;;;;;;;;;;;;;;;;;;;;;
itoa:
	PSHD			;save D
	PSHY			;save Y
	CPD #0			;test if D is negative
	BPL positive		;if it's positive, jump to positive
	
negative:				;else it's negative
	MOVB #'-', 1, X+		;add a '-' sign first; X++ to skip over a char
	COMA			;do 2's comp on D
	COMB			; ...
	ADDD #1			; ...
	
positive:
	PSHX			;save X
	LDY #1			;load #1 into the digit counter

loop1:
	LDX #10			;load the divisor #10
	IDIV			;since the num has been 2's comp'ed, we can
				;just use unsigned, 16bit division
	TBEQ X, preloop2		;if the quotient X == 0, jump to preloop2
	ADDB #48			;else, add #48 to turn it into ascii
	PSHB			;push it into stack to use later
	TFR X, D			;set the resulting dividend in place
	INY			;digit counter ++
	JMP loop1			;back to loop1
	
preloop2:
	ADDB #48			;turn the leftover remainder from loop1 into ascii
	PSHB			;push into stack to reverse it later
	TFR Y, D			;move the digit counter into D, and effectly B
	LDX B, SP			;fish out the string address from the stack

loop2:
	PULA			;pop the numbers stored in the stack earlier (loop1)
	STAA 1,X+			;store it in the return address; X++
	DBNE B, loop2		;check if there are anymore chars to write. if so,
				;back to loop2 
	
enditoa:
	MOVB #NULL, ,X		;terminate the string with \0
	PULX			;restore X
	PULY			;restore Y
	PULD			;restore D

	RTS			;return

;#include "../include/DP256reg.asm"
;#include "../include/sci0api.asm"