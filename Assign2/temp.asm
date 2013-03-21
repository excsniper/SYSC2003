				;data area
	;ORG	$800		;use this for SIM 
	ORG	$1000		;use this for DP256


	ORG	$4000		;code area
main:
	LDS	#$3DFF		;initialize stack pointer @ $3DFF
	
	

output:
	LDD	#BAUD19K		;program SCI0's baud rate
	JSR	setbaud

	LDY	#MSG		;output the message
	JSR	putStr_sc0

	BRA *

#include "itoa.asm"
#include "../include/DP256reg.asm"
#include "../include/sci0api.asm"

	END
	