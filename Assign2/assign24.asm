				;data area
	;ORG	$800		;use this for SIM 
	ORG	$1000		;use this for DP256

VAR: 	DW	%1010101001111101
MSG: 	DS	6

	ORG	$4000		;code area
main:
	LDS	#$3DFF		;initialize stack pointer @ $3DFF
	
	COM	VAR		;invert the higher byte by doing 1's comp
	COM 	VAR+1		;invert the lower byte
	LDY	#8		;init the loop counter y to half of the len of VAR
	CLRB			;init reg B to 0

shift:
	LSL	VAR		;binary shift the higher byte to the left
	ADCB	#0		;add with carry into reg B; B only inc when the bit
				;shifted into the carry is 1
	LSL	VAR+1		;shift the lower byte
	ADCB	#0		;add with carry
	DBNE	Y, shift		;loop back if reg Y isn't 0

	LDX	#MSG		;load the address of the return param
	JSR	itoa		;convert int to ascii

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
	