				;data area
	;ORG	$800		;use this for SIM 
	ORG	$1000		;use this for DP256

Array:  	DB	47, 121, 114, 34, 44, 117, 33, 124, 255
MSG:	DS	6	

	ORG	$4000		;code area
main:
	LDS	#$3DFF		;initialize stack pointer @ $3DFF

	LDX 	#Array		;init reg X with the address of the first elem of the array
	LDY	#0		;init the sum reg Y to 0

nextelem:
	BRSET 	,X $FF done	;if the current elem is 255, exit loop
	LDAB 	1,X+		;because the elems are 8bits it will first have to be loaded
				;into the 8bit reg B in order to be added to the 16bit reg Y
	ABY			;adding B to Y; summing all the numbers
	BRA 	nextelem		;loop back to nextelem
		
done:
	TFR 	Y, D		;transfer the result into D

	LDX	#MSG		;load the addr of the return param
	JSR	itoa		;call itoa
	
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
	