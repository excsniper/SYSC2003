				;data area
	;ORG	$800		;use this for SIM 
	ORG	$1000		;use this for DP256

MSG: 	ds	6		;using this to store the output msg
W:	ds.w	1		;this var is for temp storage needed in the algorithm
space   db 	$20, $0

	ORG	$4000		;code area
main:
	LDS	#$3DFF		;initialize stack pointer @ $3DFF
	
				;since there are 2 versions of the fibonacci seqs with different starting values: 0, 1 and 1, 1
				;this code computes the nth fib number using starting values 1 and 1
				;therefore the 10th fib number is 55; 
				;http://www.wolframalpha.com/input/?i=10th+fibonacci+number

	LDD 	#1		;init the first number to 0
	LDX	#1		;set reg A to 1; second number = 1
	LDY	#10		;load Y with n; n being the nth fib num

fib:
	JSR	prtnum		;print the number in reg D	
	
	STX	W		;store the varlue of reg X so it can be restored later
	LEAX	D, X		;add D into X
	LDD	W		;restore the value of reg X before the addition into reg D

	DBNE	Y, fib		;loop back to fib if Y != 0

	BRA *


;a simple sub to print numbers follow by space
prtnum:
	PSHD			;save reg D
	PSHX			;save reg X
	PSHY			;save reg Y
	PSHD			;save reg D again so the baudrate can be set without affecting reg D
	
	LDD	#BAUD19K	;program SCI0's baud rate
	JSR	setbaud

	PULD			;restore reg D after setting the baudrate

	LDX 	#MSG		;load the return address...
	JSR	itoa		;call itoa	

	LDY	#MSG		;output the message
	JSR	putStr_sc0

	LDY	#space		;output a space
	JSR	putStr_sc0

	PULY			;restore reg Y
	PULX			;restore reg X
	PULD			;restore reg D

	RTS

#include "assign27.asm"
#include "../include/DP256reg.asm"
#include "../include/sci0api.asm"

	END
	