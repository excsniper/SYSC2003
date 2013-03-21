; SYSC 2003 - Intro to Real-Time Systems - Winter 2010
; Print on terminal template

		ORG	$1000			;data area

message:	FCC	"The result is:"		; string: display message
Result:         DW  					: your result variable is this one; store the result here
TerminateString DB      0

		ORG	$4000			;program area
start:
		LDS	#$3DFF			;initialize stack pointer (details later)


		; YOUR PROGRAM GOES HERE



		LDD	#BAUD19K		;program SCI0's baud rate
		JSR	setbaud

		LDY	#message		;output the message
		JSR	putStr_sc0

		BRA *

#include "DP256reg.asm"
#include "sci0api.asm"

		END
	