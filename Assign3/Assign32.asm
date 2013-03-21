	ORG $1000	;DATA

s_speed fcc	" Speed: "
	db 0
s_proximity fcc	"> Proximity: "
	db 0

;test strings
t1:	fcc 	"  Proximity: 0000001011000101 Speed: 01101011"
	db 0
t2:	fcc 	"  Proximity: 1000000111000100 Speed: 01101011"
	db 0
t3:	fcc 	"  Proximity: 1000001011000001 Speed: 01101011"
	db 0
t4:	fcc 	"  Proximity: 1000000011000101 Speed: 01101011"
	db 0

;test cases proximity
p1	dw	%0000001011000101
p2	dw	%1000000111000100
p3	dw	%1000001011000001
p4	dw	%1000000011000101

;using same speed for all the tests
s1	equ	%01101011
s2   	rmb	8
	
NEWLINE equ	$0A

	ORG 	$4000	;CODE

;main

	LDS	#$3DFF

	LDD	#BAUD19K
	JSR	setbaud

;test1
	LDY	#t1		;print the test case
	JSR	putStr_sc0
	
	LDAB	#NEWLINE
	JSR	putChar_sc0

	LDY	#s_proximity
	JSR	putStr_sc0

	MOVB 	#s1, s2		;setting speed
	LDY	#p1
	PSHY
	LDY	#s2
	PSHY
	PSHB
	JSR 	collision_detection
	LEAS	5, SP		;Free the stack
		
	LDD	p1		;printing the results
	PSHD
	JSR	_printBin16
	PULD
	
	LDY	#s_speed
	JSR	putStr_sc0
	
	LDAB	s2
	PSHB
	JSR	_printBin
	PULB

	LDAB	#NEWLINE
	JSR	putChar_sc0
	JSR	putChar_sc0

;test2
	LDY	#t2
	JSR	putStr_sc0
	
	LDAB	#NEWLINE
	JSR	putChar_sc0

	LDY	#s_proximity
	JSR	putStr_sc0

	MOVB 	#s1, s2
	LDY	#p2
	PSHY
	LDY	#s2
	PSHY
	PSHB
	JSR 	collision_detection
	LEAS	5, SP		;Free the stack
		
	LDD	p2
	PSHD
	JSR	_printBin16
	PULD
	
	LDY	#s_speed
	JSR	putStr_sc0
	
	LDAB	s2
	PSHB
	JSR	_printBin
	PULB

	LDAB	#NEWLINE
	JSR	putChar_sc0
	JSR	putChar_sc0

;test3
	LDY	#t3
	JSR	putStr_sc0
	
	LDAB	#NEWLINE
	JSR	putChar_sc0

	LDY	#s_proximity
	JSR	putStr_sc0

	MOVB 	#s1, s2
	LDY	#p3
	PSHY
	LDY	#s2
	PSHY
	PSHB
	JSR 	collision_detection
	LEAS	5, SP		;Free the stack
		
	LDD	p3
	PSHD
	JSR	_printBin16
	PULD
	
	LDY	#s_speed
	JSR	putStr_sc0
	
	LDAB	s2
	PSHB
	JSR	_printBin
	PULB

	LDAB	#NEWLINE
	JSR	putChar_sc0
	JSR	putChar_sc0

;test4
	LDY	#t4
	JSR	putStr_sc0
	
	LDAB	#NEWLINE
	JSR	putChar_sc0

	LDY	#s_proximity
	JSR	putStr_sc0

	MOVB 	#s1, s2
	LDY	#p4
	PSHY
	LDY	#s2
	PSHY
	PSHB
	JSR 	collision_detection
	LEAS	5, SP		;Free the stack
		
	LDD	p4
	PSHD
	JSR	_printBin16
	PULD
	
	LDY	#s_speed
	JSR	putStr_sc0
	
	LDAB	s2
	PSHB
	JSR	_printBin
	PULB

	LDAB	#NEWLINE
	JSR	putChar_sc0
	JSR	putChar_sc0

;done main

	SWI



;***************************************************************************************************



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;boolean collision_detection (byte &speed, unsigned int &proximity);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;offsets
collision_detection_return		equ 5	;1byte
collision_detection_speed		equ 6	;2byte address
collision_detection_proximity	equ 8	;2byte address

collision_detection:

	PSHB
	PSHX

	LDX	collision_detection_proximity, SP			;BRSET/BSET commands cant use Indirect Index Address Mode so loading SP into X 
								;so the param can be be dereferenced

;check if there's collision
	
	BRSET	,X, #%10000000, collision_detection_collision

;if no collision..

	LSL	[collision_detection_speed, SP]			;speed *= 2
	MOVB	#0, collision_detection_return, SP			;no collision, return 0

	BRA	collision_detection_done


collision_detection_collision:	

;check if N, NE

	BRCLR	1,X , #%00000011, collision_detection_N_NE

;else if SW


	BRSET	1,X , #%00000111, collision_detection_S_SW

;else if S
	
	LDAB	#%00000111	
	ANDB	1,X
	DBEQ	B, collision_detection_S_SW 

;else, speed /= 8
	LDAB	#3
else:	
	LSR	[collision_detection_speed, SP]
	DBNE	B, else

	BRA 	collision_detection_return1		;return 1 for collision
	

collision_detection_N_NE:
	
	BSET 	,X, %00000010	;set bits 8-9 to %10
	BCLR	,X, %00000001	;rotate to left
	
	BRA 	collision_detection_return1

collision_detection_S_SW:

	BSET 	,X, %00000001	;set bits 8-9 to %01
	BCLR	,X, %00000010	;rotate to right

collision_detection_return1:
	
	MOVB	#1, collision_detection_return, SP	;return 1 for collision

collision_detection_done:

	PULX
	PULB

	RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        Copied from question 1                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;void printBin(byte num)
;num is an 8bit value to be printed
num	EQU	4

_printBin:

		PSHD
		LDAA	#8
	
printBinLoop:

		LSL 	num, SP
		BCC 	printBinNoCarry

printBinCarry:
	
		LDAB 	#'1'
		BRA 	printBinNext

printBinNoCarry:

		LDAB 	#'0'
	
printBinNext:

		JSR 	putChar_sc0
		DBNE	A, printBinLoop

;done
		PULD

		RTS

;void printBin16(int num)
;num is an 16bit value to be printed

_printBin16:

		PSHA
		JSR 	_printBin
		PULA

		PSHB
		JSR 	_printBin
		PULB

		RTS


#include "../include/DP256reg.asm"
#include "../include/sci0api.asm"

	END
