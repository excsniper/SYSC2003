;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;							;
;	ALL OF THE ANSWERS SUBMITTED WILL RUN ON THE BOARD	;
;							;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				;data area
	;ORG	$800		;use this for SIM 
	ORG	$1000		;use this for DP256

MSG:	ds	6		;using this to store the output message
Z: 	db	0
Y:	db	45
X:	db	4

	ORG	$4000		;code area
main:
	LDS	#$3DFF		;initialize stack pointer @ $3DFF
	
	LDAB	Y		;load var Y into reg B
	ADDB	#7		;add 7 to var Y
	SUBB	X		;subtract var X from var Y
	STAB	Z		;store the result in var Z

convert:
	LDX 	#MSG		;load the address to store the result from itoa
				;since the number to be converted is already in D..
	JSR 	itoa		;convert int to ascii

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
	