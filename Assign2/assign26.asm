				;data area
	;ORG	$800		;use this for SIM 
	ORG	$1000		;use this for DP256
				
				;since I'am using the putStr_sc0 sub
				;all my strings are null terminated
				;which technically makes the first two 11 bytes long

firstString: 	DB  "1234567890"	;first string to be compared
		DB 0		;null terminated
secondString:	DB  "1234s67890"	;second string to be compared
		DB 0		;null terminated

_SAME: 	DB	$31, 0		;null terminated result "1"
_DIFF:	DB	$30, 0		;null terminated result "0"
_NEWLINE: DB 	10, 0		;null terminated ascii Linefeed (LF)

	ORG	$4000		;code area
main:
	LDS	#$3DFF		;initialize stack pointer @ $3DFF
	
	LDX 	#firstString	;init reg X with the address of the first string
	LDY	#secondString	;init reg Y with the address of the second string
	LDAA	#10		;init loop counter reg A with the len of the string
				;since both strings are null terminated, the last byte
				;does not need to be compared

loop:
	LDAB 	1, X+		;load the current char from the first string into reg B
	EORB	1, Y+		;XOR reg B with the current char of the second string
				;to see if there's a difference
	BNE	different		;if so, exit loop and jump to different
	DBNE	A, loop		;else loop back until A == 0
	BRA 	same		;if no difference then jump to same

different:
	JSR	prtstrs		;call the prtstrs sum at the bottom to print both strings
	LDY	#_DIFF		;output the result
	JSR	putStr_sc0

	BRA 	done		;done!

same: 
	JSR	prtstrs		;output both strings
	LDY	#_SAME		;output the result
	JSR	putStr_sc0	

done:
	BRA *

;a sub to print both strings and appends a newline char
prtstrs:
	LDD	#BAUD19K		;program SCI0's baud rate
	JSR	setbaud

	LDY	#firstString	;output the first string
	JSR	putStr_sc0

	JSR	newline		;output a new line

	LDY	#secondString	;output the second string
	JSR	putStr_sc0

	JSR	newline		;newline

	RTS

;a sub to print a newline char
newline:
	LDY	#_NEWLINE		;output a ascii LF
	JSR	putStr_sc0

	RTS			;return from the call

#include "assign27.asm"
#include "../include/DP256reg.asm"
#include "../include/sci0api.asm"

	END
	