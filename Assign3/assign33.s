	.module assign33.c
	.area text
	.dbfile C:\DOCUME~1\davidyao\Desktop\Lab3\assign33.c
	.dbfunc e displaySystemStatus _displaySystemStatus fc
;          ?temp -> -2,x
;    keysPressed -> 10,x
;      proximity -> 8,x
;    temperature -> 7,x
;          speed -> 3,x
_displaySystemStatus::
	pshd
	pshx
	tfr s,x
	leas -4,sp
	.dbline -1
	.dbline 3
; 
; char displaySystemStatus(char speed, char temperature, unsigned int proximity, unsigned int *keysPressed)
; {
	.dbline 4
;  	 printf("Speed: 0x%x\n", speed);
	ldab 3,x
	clra
	std 0,sp
	ldd #L2
	jsr _printf
	.dbline 5
; 	 printf("Temperature: 0x%x\n", temperature);
	ldab 7,x
	clra
	std 0,sp
	ldd #L3
	jsr _printf
	.dbline 6
; 	 printf("Proximity: ", proximity);
	movw 8,x,0,sp
	ldd #L4
	jsr _printf
	.dbline 8
; 
; 	 switch(proximity & 0x0007)
	ldd 8,x
	anda #0
	andb #7
	std -2,x
	beq L8
	ldd -2,x
	cpd #1
	beq L10
	ldd -2,x
	cpd #2
	beq L12
	ldd -2,x
	cpd #3
	beq L14
	ldd -2,x
	cpd #4
	beq L16
	ldd -2,x
	cpd #5
	beq L18
	ldd -2,x
	cpd #6
	beq L20
	ldd -2,x
	cpd #7
	beq L22
	bra L5
X0:
	.dbline 9
; 	 {
L8:
	.dbline 11
; 	  		case 0:
; 				 printf("N");
	ldd #L9
	jsr _printf
	.dbline 12
; 				 break;
	bra L6
L10:
	.dbline 14
; 	  		case 1:
; 				 printf("S");
	ldd #L11
	jsr _printf
	.dbline 15
; 				 break;
	bra L6
L12:
	.dbline 17
; 	  		case 2:
; 				 printf("E");
	ldd #L13
	jsr _printf
	.dbline 18
; 				 break;
	bra L6
L14:
	.dbline 20
; 	  		case 3:
; 				 printf("W");
	ldd #L15
	jsr _printf
	.dbline 21
; 				 break;
	bra L6
L16:
	.dbline 23
; 	  		case 4:
; 				 printf("NE");
	ldd #L17
	jsr _printf
	.dbline 24
; 				 break;
	bra L6
L18:
	.dbline 26
; 	  		case 5:
; 				 printf("NW");
	ldd #L19
	jsr _printf
	.dbline 27
; 				 break;
	bra L6
L20:
	.dbline 29
; 	  		case 6:
; 				 printf("SE");
	ldd #L21
	jsr _printf
	.dbline 30
; 				 break;
	bra L6
L22:
	.dbline 32
; 	  		case 7:
; 				 printf("SW");
	ldd #L23
	jsr _printf
	.dbline 33
; 				 break;				 				 				 				 				 				 
L5:
L6:
	.dbline 36
; 		}
; 	 
; 	 if(proximity & 0x8000)
	brclr 8,x,#128,L24
	.dbline 37
; 	 	 printf(" ** Obstacles Nearby! **");
	ldd #L26
	jsr _printf
L24:
	.dbline 39
; 		
; 	 printf("\n");
	ldd #L27
	jsr _printf
	.dbline 40
; 	 printf("Keys Pressed: 0x%x\n", *keysPressed);
	ldd [10,x]
	std 0,sp
	ldd #L28
	jsr _printf
	.dbline 41
; 	 return 1;
	ldd #1
	.dbline -2
L1:
	tfr x,s
	pulx
	leas 2,sp
	.dbline 0 ; func end
	rts
	.dbsym l keysPressed 10 pi
	.dbsym l proximity 8 i
	.dbsym l temperature 6 I
	.dbsym l temperature 7 c
	.dbsym l speed 2 I
	.dbsym l speed 3 c
	.dbend
	.dbfunc e main _main fV
;           keys -> -2,x
_main::
	pshx
	tfr s,x
	leas -8,sp
	.dbline -1
	.dbline 45
; }
; 
; void main()
; {
	.dbline 53
;  	 /*
;  	 Speed: 10110001b (177)
; 	 Temperature: 10101011b (171)
; 	 Proximity: 1111111100001100b (65292)
; 	 Keys Pressed: 100100100101010b (18730)
; 	 */
; 
;  	 unsigned int keys = 0x492A;
	ldd #18730
	std -2,x
	.dbline 54
;  	 displaySystemStatus(0xB1, 0xAB, 0xFF0C, &keys);
	leay -2,x
	sty 4,sp
	ldd #0xff0c
	std 2,sp
	ldd #171
	std 0,sp
	ldd #177
	jsr _displaySystemStatus
	.dbline 56
; 	 
; 	 asm("SWI"); 
		SWI

	.dbline -2
	.dbline 57
; }
L29:
	tfr x,s
	pulx
	.dbline 0 ; func end
	rts
	.dbsym l keys -2 i
	.dbend
L28:
	.byte 'K,'e,'y,'s,32,'P,'r,'e,'s,'s,'e,'d,58,32,48,'x
	.byte 37,'x,10,0
L27:
	.byte 10,0
L26:
	.byte 32,42,42,32,'O,'b,'s,'t,'a,'c,'l,'e,'s,32,'N,'e
	.byte 'a,'r,'b,'y,33,32,42,42,0
L23:
	.byte 'S,'W,0
L21:
	.byte 'S,'E,0
L19:
	.byte 'N,'W,0
L17:
	.byte 'N,'E,0
L15:
	.byte 'W,0
L13:
	.byte 'E,0
L11:
	.byte 'S,0
L9:
	.byte 'N,0
L4:
	.byte 'P,'r,'o,'x,'i,'m,'i,'t,'y,58,32,0
L3:
	.byte 'T,'e,'m,'p,'e,'r,'a,'t,'u,'r,'e,58,32,48,'x,37
	.byte 'x,10,0
L2:
	.byte 'S,'p,'e,'e,'d,58,32,48,'x,37,'x,10,0
