				;data area
	;ORG	$800		;use this for SIM 
	ORG	$1000		;use this for DP256

				;this code takes the possiblity of getting a 16bit result into consideration
W:	ds.w	1		;using var W to store an intermediate value
X:	db	20		
Y:	db	2
MSG: 	ds	6		;using this to store the output msg

	ORG	$4000		;code area
main:

	LDS	#$3DFF		;initialize stack pointer @ $3DFF
	
	LDAB 	Y		;load Y into reg B
	CLRA			;load 0 into reg A; unsigned extend var Y into D
	LSLD			;binary shift D to the left, effectivly multiplying it by 2
	STD	W		;store 2Y in var W
	LDAB	X		;load var X into reg B
	CLRA			;load 0 into reg A; unsigned extend var Y into D
	SUBD	W		;D -= W
	LDY 	#3		;load 3 into the reg Y to be multiplied 
	EMULS			; Y:D = D * Y (signed), disregarding Y

	LDX	#MSG		;load the return param for itoa
				;since the number to be converted is already in D...
	JSR 	itoa		;call itoa

output:
	LDD	#BAUD19K		;program SCI0's baud rate
	JSR	setbaud

	LDY	#MSG		;output the message
	JSR	putStr_sc0

	BRA *

#include "assign27.asm"
#include "../include/DP256reg.asm"
#include "../include/sci0api.asm"

	END
	