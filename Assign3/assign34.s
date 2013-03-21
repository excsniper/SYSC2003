	.module assign34.c
	.area text
	.dbfile C:\DOCUME~1\davidyao\Desktop\Lab3\assign34.c
	.dbfunc e collision_detection _collision_detection fc
;          ?temp -> -2,x
;      proximity -> 6,x
;          speed -> 2,x
_collision_detection::
	pshd
	pshx
	tfr s,x
	leas -2,sp
	.dbline -1
	.dbline 3
; 
; char collision_detection(char *speed, unsigned int *proximity)
; {
	.dbline 5
; 		
;  	 if ( !(*proximity & 0x8000) )
	ldy 6,x
	brset 0,y,#128,L2
	.dbline 6
; 	 {
	.dbline 7
; 	  	*speed = *speed << 1;
	ldy 2,x
	ldab 0,y
	clra
	lsld
	ldy 2,x
	stab 0,y
	.dbline 8
; 		return 0;
	ldd #0
	bra L1
L2:
	.dbline 11
; 	 }
; 	 else
; 	 {
	.dbline 13
; 	 
; 		if( !(*proximity & 0x0003) ) //N, NE
	ldy 6,x
	brclr 1,y,#3,X0
	bra L4
X0:
	.dbline 14
; 		 	*proximity = (*proximity | 0x0200) & 0xFEFF;
	ldd [6,x]
	ora #2
	orb #0
	anda #254
	andb #255
	ldy 6,x
	std 0,y
	bra L5
L4:
	.dbline 15
; 		else if( !(*proximity & 0x0007) || !((*proximity & 0x0007)-1) )
	ldd [6,x]
	anda #0
	andb #7
	std -2,x
	beq L8
	ldd -2,x
	subd #1
	bne L6
L8:
	.dbline 16
; 			*proximity = (*proximity | 0x0100) & 0xFDFF;
	ldd [6,x]
	ora #1
	orb #0
	anda #253
	andb #255
	ldy 6,x
	std 0,y
	bra L7
L6:
	.dbline 18
; 		else
; 			*speed = *speed >> 3;
	ldy 2,x
	ldab 0,y
	clra
	asra
	rorb
	asra
	rorb
	asra
	rorb
	ldy 2,x
	stab 0,y
L7:
L5:
	.dbline 20
; 
; 			return 1;
	ldd #1
	.dbline -2
L1:
	tfr x,s
	pulx
	leas 2,sp
	.dbline 0 ; func end
	rts
	.dbsym l proximity 6 pi
	.dbsym l speed 2 pc
	.dbend
	.dbfunc e main _main fV
;      proxomity -> -3,x
;          speed -> -1,x
_main::
	pshx
	tfr s,x
	leas -8,sp
	.dbline -1
	.dbline 25
; 	 }
; }
; 
; void main()
; {
	.dbline 29
; 
;  	 //Speed: 01101011b (0x6B)
; 	 
; 	 char speed = 0x6B;
	ldab #107
	stab -1,x
	.dbline 30
;  	 unsigned int proxomity = 0x02C5; //Proxomity: 0000001011000101b (0x02C5)
	ldd #709
	std -3,x
	.dbline 31
; 	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L10
	jsr _printf
	.dbline 32
; 	 collision_detection(&speed, &proxomity);
	leay -3,x
	sty 0,sp
	leay -1,x
	xgdy
	jsr _collision_detection
	.dbline 33
; 	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L11
	jsr _printf
	.dbline 35
; 	 
; 	 speed = 0x6B;
	ldab #107
	stab -1,x
	.dbline 36
; 	 proxomity = 0x81C4; //Proxomity: 1000000111000100b (0x81C4)
	ldd #0x81c4
	std -3,x
	.dbline 37
; 	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L10
	jsr _printf
	.dbline 38
; 	 collision_detection(&speed, &proxomity);
	leay -3,x
	sty 0,sp
	leay -1,x
	xgdy
	jsr _collision_detection
	.dbline 39
; 	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L11
	jsr _printf
	.dbline 41
; 
; 	 speed = 0x6B;
	ldab #107
	stab -1,x
	.dbline 42
; 	 proxomity = 0x82C1; //Proxomity: 1000001011000001b (0x82C1)
	ldd #0x82c1
	std -3,x
	.dbline 43
; 	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L10
	jsr _printf
	.dbline 44
; 	 collision_detection(&speed, &proxomity);
	leay -3,x
	sty 0,sp
	leay -1,x
	xgdy
	jsr _collision_detection
	.dbline 45
; 	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L11
	jsr _printf
	.dbline 47
; 
; 	 speed = 0x6B;	 
	ldab #107
	stab -1,x
	.dbline 48
; 	 proxomity = 0x80C5; //Proxomity: 1000000011000101b (0x80C5)
	ldd #0x80c5
	std -3,x
	.dbline 49
; 	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L10
	jsr _printf
	.dbline 50
; 	 collision_detection(&speed, &proxomity);
	leay -3,x
	sty 0,sp
	leay -1,x
	xgdy
	jsr _collision_detection
	.dbline 51
; 	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);
	ldab -1,x
	clra
	std 2,sp
	movw -3,x,0,sp
	ldd #L11
	jsr _printf
	.dbline 53
; 	 
; 	 asm("SWI"); 
		SWI

	.dbline -2
	.dbline 54
; }
L9:
	tfr x,s
	pulx
	.dbline 0 ; func end
	rts
	.dbsym l proxomity -3 i
	.dbsym l speed -1 c
	.dbend
L11:
	.byte 62,32,'P,'r,'o,'x,'i,'m,'i,'t,'y,58,32,48,'x,37
	.byte 'x,32,'S,'p,'e,'e,'d,58,32,48,'x,37,'x,10,10,0
L10:
	.byte 32,32,'P,'r,'o,'x,'i,'m,'i,'t,'y,58,32,48,'x,37
	.byte 'x,32,'S,'p,'e,'e,'d,58,32,48,'x,37,'x,10,0
