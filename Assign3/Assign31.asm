
	ORG 	$1000		; DATA

keys  	dw 	%0100100100101010	;a test value for the keys pressed


	ORG 	$4000		; CODE

;main
	LDS	#$3DFF		;initialize stack pointer @ $3DFF

	LDD	#BAUD19K
	JSR	setbaud

	LDY	#keys		;address of keys pressed
	PSHY

	LDD	#%1111111100001100 ;prox
	PSHD	

	LDAB	#%10101011	;temp
	PSHB
	
	LDAB	#%10110001	;speed
	PSHB

	PSHB			;allocate 1byte for the return value

	JSR	displaySystemStatus
	
	LEAS	7, SP		;deallocate the stack
	

	SWI

;end main





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;bool displaySystemStatus (byte speed, byte temperature, unsigned int proximity; unsigned int &keysPressed);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;some equates
N: 		equ 1		;Bot's Directions
S: 		equ 2
E: 		equ 3
W: 		equ 4
NE: 		equ 5
NW: 		equ 6
SE: 		equ 7
SW: 		equ 8

FWD: 		equ 1		;Motor's Directions
BAK: 		equ 2

R_RIGHT: 		equ 1		;Rotation
R_LEFT: 		equ 10		

				;Strings
s_speed: 		fcc "Speed: "
	db 0

s_temperature: 	fcc "Temperature: "
	db 0

s_proximity: 	fcc "Proximity: "
	db 0

s_keysPressed: 	fcc "Keys Pressed: "
	db 0

s_obstacles: 	fcc " ** Obstacles Nearby! **"
	db 0

s_fwd:		fcc "Forward, "
	db 0
s_bak:		fcc "Backward, "
	db 0

;2 string arrays to be used to display the directions
s_directions 	fcc "NSEW"		;string array for directions
s_directions2 	fcc "NENWSESW"		;string array for directions (2bytes)

NEWLINE: db $0A


;Offsets for params
displaySystemStatus_return		equ 6		;1byte
displaySystemStatus_speed 		equ 7		;1byte
displaySystemStatus_temperature 		equ 8		;1byte
displaySystemStatus_proximity		equ 9		;2byte
displaySystemStatus_keysPressed 		equ 11		;2byte address

displaySystemStatus:
	
		PSHD					;save regs
		PSHY

;print speed:
	
		LDY	#s_speed				;print "Speed: "
		JSR	putStr_sc0

		LDAB	displaySystemStatus_speed, SP	;print the speed in binary
		PSHB
		JSR	_printBin
		PULB
	
		LDAB	NEWLINE				;print a newline char
		JSR	putChar_sc0
	
;print temperature
	
		LDY	#s_temperature			;print "Temperature: "
		JSR	putStr_sc0		
	
		LDAB	displaySystemStatus_temperature, SP	;print the temperature
		PSHB
		JSR	_printBin
		PULB

		LDAB	NEWLINE				;print newline	
		JSR	putChar_sc0

;print proximity
	
		LDY	#s_proximity
		JSR	putStr_sc0	

;print direction
		
		BRCLR	displaySystemStatus_proximity+1, SP, #$80, printBak

		
printFwd:
		LDY	#s_fwd
		JSR	putStr_sc0

		BRA	printDirection

printBak:
		LDY	#s_bak
		JSR	putStr_sc0

printDirection:

;the next few lines check to see which char array to use
		LDAB	#%00000011			;load a mask
		ANDB	displaySystemStatus_proximity+1, SP
	
		BRSET	displaySystemStatus_proximity+1, SP #%00000100, twochar

;onechar

		LDY	#s_directions		;using the value from proximity as an offset, print the direction from the one char array
		LDAB	B, Y
		JSR	putChar_sc0
	
		BRA	printObstacles

twochar:

		LDY	#s_directions2		;using the value from proximity as an offset, print the direction from the two char array
		LSLB
		ABY

		LDAB	1, Y+			;Y++
		JSR	putChar_sc0
	
		LDAB	,Y
		JSR	putChar_sc0

printObstacles:

		LSL	displaySystemStatus_proximity, SP
		BCC	endProximity
	
		LDY	#s_obstacles
		JSR	putStr_sc0	

endProximity:

		LDAB	NEWLINE
		JSR	putChar_sc0

printKeyPressed:
	
		LDY	#s_keysPressed
		JSR	putStr_sc0	

		LDD	[displaySystemStatus_keysPressed, SP]	;since keysPressed was passed by reference, using square brackets aka
								;Indirect Indexed Addressing Mode to dereference it
		PSHD
		JSR	_printBin16
		PULD

		LDAB	NEWLINE
		JSR	putChar_sc0

;return 1

		MOVB 	#1, displaySystemStatus_return, SP		;always return 1
		
;done

		PULY		;restore regs
		PULD

		RTS


;void printBin(byte num)
;num is an 8bit value to be printed
num	EQU	4

_printBin:

		PSHD
		LDAA	#8	;loop counter A = 8(bits)
	
printBinLoop:

		LSL 	num, SP		;left shift and check carry
		BCC 	printBinNoCarry

printBinCarry:
	
		LDAB 	#'1'		;if there is carry print '1'
		BRA 	printBinNext

printBinNoCarry:

		LDAB 	#'0'		;else print '0'
	
printBinNext:

		JSR 	putChar_sc0
		DBNE	A, printBinLoop

;done
		PULD

		RTS

;void printBin16(int num)
;num is an 16bit value to be printed

_printBin16:

		PSHA			;printing first half of the word
		JSR 	_printBin
		PULA

		PSHB			;print second half of the word
		JSR 	_printBin
		PULB

		RTS


#include "../include/DP256reg.asm"
#include "../include/sci0api.asm"


	end