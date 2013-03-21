;; 68HC12 Equates
;; Copyright (c) 1998, Thomas Almy. All rights reserved. 
;; License is granted users of his 68HC12 Simulator
;; to use this file as part of their own programs for
;; educational or personal (but not commercial) use. This
;; file may not be given or sold to anyone without permission
;; of the author. 
;; Thomas Almy makes no representation about the suitability
;; of this software for any purpose. It is provided as is without
;; warranty of any kind, expressed or implied.

REGBASE EQU     $0      ; Register base
RAMSTART EQU    $800    ; Start of internal RAM
RAMEND  EQU     $A00    ; Start of DBUG internal RAM 
                        ; (can't use this!)
PRSTART EQU     $4000   ; Start of program Memory
;; Functions in the D-BUG12
GetChar EQU     $fe02
PutChar EQU     $fe04
SetUserVector   EQU   $fe1a   ; Thse are the only functions
                                ; implemented in the Emulator

UserPortHKWU    EQU     7       ; Equates for SetUserVector() function
UserPortJKWU    EQU     8
UserAtoD        EQU     9
UserSCI1        EQU     10
UserSCI0        EQU     11
UserSPI0        EQU     12
UserTimerCh0    EQU     23
UserTimerCh1    EQU     22
UserTimerCh2    EQU     21
UserTimerCh3    EQU     20
UserTimerCh4    EQU     19
UserTimerCh5    EQU     18
UserTimerCh6    EQU     17
UserTimerCh7    EQU     16 
UserPAccOvf     EQU     14
UserPAccEdge    EQU     13
UserTimerOvf    EQU     15
UserRTI         EQU     24
UserIRQ         EQU     25
UserXIRQ        EQU     26
UserSWI         EQU     27
UserTrap        EQU     28
RAMVectAddr     EQU     -1

PORTA	EQU	$00+REGBASE
PORTB	EQU	$01+REGBASE
DDRA	EQU	$02+REGBASE
DDRB	EQU	$03+REGBASE
PORTC	EQU	$04+REGBASE
PORTD	EQU	$05+REGBASE
DDRC	EQU	$06+REGBASE
DDRD	EQU	$07+REGBASE
PORTE	EQU	$08+REGBASE
DDRE	EQU	$09+REGBASE
PEAR	EQU	$0A+REGBASE
MODE	EQU	$0B+REGBASE
PUCR	EQU	$0C+REGBASE
RDRIV	EQU	$0D+REGBASE
INITRM  EQU     $10+REGBASE     ; IO Registers
INITRG  EQU     $11+REGBASE
INITEE  EQU     $12+REGBASE
MISC    EQU     $13+REGBASE
RTICTL  EQU     $14+REGBASE
RTIFLG  EQU     $15+REGBASE
COPCTL  EQU     $16+REGBASE
COPRST  EQU     $17+REGBASE
ITST0   EQU     $18+REGBASE
ITST1   EQU     $19+REGBASE
ITST2   EQU     $1A+REGBASE
ITST3   EQU     $1B+REGBASE
INTCR   EQU     $1E+REGBASE
HPRIO   EQU     $1F+REGBASE
PORTH   EQU     $24+REGBASE
DDRH    EQU     $25+REGBASE
KWIEH   EQU     $26+REGBASE
KWIFH   EQU     $27+REGBASE
PORTJ   EQU     $28+REGBASE
DDRJ    EQU     $29+REGBASE
KWIEJ   EQU     $2A+REGBASE
KWIFJ   EQU     $2B+REGBASE
KPOLJ   EQU     $2C+REGBASE
PUPSJ   EQU     $2D+REGBASE
PULEJ   EQU     $2E+REGBASE
PORTF   EQU     $30+REGBASE
PORTG   EQU     $31+REGBASE
DDRF    EQU     $32+REGBASE
DDRG    EQU     $33+REGBASE
DPAGE   EQU     $34+REGBASE
PPAGE   EQU     $35+REGBASE
EPAGE   EQU     $36+REGBASE
WINDEF  EQU     $37+REGBASE
MXAR    EQU     $38+REGBASE
CSCTL0  EQU     $3C+REGBASE
CSCTL1  EQU     $3D+REGBASE
CSSTR0  EQU     $3E+REGBASE
CSSTR1  EQU     $3F+REGBASE
LDV     EQU     $40+REGBASE
RDV     EQU     $42+REGBASE
CLKCTL  EQU     $47+REGBASE
ATDCTL0 EQU     $60+REGBASE
ATDCTL1 EQU     $61+REGBASE
ATDCTL2 EQU     $62+REGBASE
ATDCTL3 EQU     $63+REGBASE
ATDCTL4 EQU     $64+REGBASE
ATDCTL5 EQU     $65+REGBASE
ATDSTAT EQU     $66+REGBASE
ATDTEST EQU     $68+REGBASE
PORTAD  EQU     $6F+REGBASE
ADR0H   EQU     $70+REGBASE
ADR1H   EQU     $72+REGBASE
ADR2H   EQU     $74+REGBASE
ADR3H   EQU     $76+REGBASE
ADR4H   EQU     $78+REGBASE
ADR5H   EQU     $7A+REGBASE
ADR6H   EQU     $7C+REGBASE
ADR7H   EQU     $7E+REGBASE
TIOS    EQU     $80+REGBASE
CFORC   EQU     $81+REGBASE
OC7M    EQU     $82+REGBASE
OC7D    EQU     $83+REGBASE
TCNT    EQU     $84+REGBASE
TSCR    EQU     $86+REGBASE
TCTL1   EQU     $88+REGBASE
TCTL2   EQU     $89+REGBASE
TCTL3   EQU     $8A+REGBASE
TCTL4   EQU     $8B+REGBASE
TMSK1   EQU     $8C+REGBASE
TMSK2   EQU     $8D+REGBASE
TFLG1   EQU     $8E+REGBASE
TFLG2   EQU     $8F+REGBASE
TC0     EQU     $90+REGBASE
TC1     EQU     $92+REGBASE
TC2     EQU     $94+REGBASE
TC3     EQU     $96+REGBASE
TC4     EQU     $98+REGBASE
TC5     EQU     $9A+REGBASE
TC6     EQU     $9C+REGBASE
TC7     EQU     $9E+REGBASE
PACTL   EQU     $A0+REGBASE
PAFLG   EQU     $A1+REGBASE
PACNT   EQU     $A2+REGBASE
TIMTST  EQU     $AD+REGBASE
PORTT   EQU     $AE+REGBASE
DDRT    EQU     $AF+REGBASE
SC0BDH  EQU     $C0+REGBASE
SC0BDL  EQU     $C1+REGBASE
SC0CR1  EQU     $C2+REGBASE
SC0CR2  EQU     $C3+REGBASE
SC0SR1  EQU     $C4+REGBASE
SC0SR2  EQU     $C5+REGBASE
SC0DRH  EQU     $C6+REGBASE
SC0DRL  EQU     $C7+REGBASE
SC1BDH  EQU     $C8+REGBASE
SC1BDL  EQU     $C9+REGBASE
SC1CR1  EQU     $CA+REGBASE
SC1CR2  EQU     $CB+REGBASE
SC1SR1  EQU     $CC+REGBASE
SC1SR2  EQU     $CD+REGBASE
SC1DRH  EQU     $CE+REGBASE
SC1DRL  EQU     $CF+REGBASE
SP0CR1  EQU     $D0+REGBASE
SP0CR2  EQU     $D1+REGBASE
SP0BR   EQU     $D2+REGBASE
SP0SR   EQU     $D3+REGBASE
SP0DR   EQU     $D5+REGBASE
PORTS   EQU     $D6+REGBASE
DDRS    EQU     $D7+REGBASE
EEMCR   EQU     $F0+REGBASE
EEPROT  EQU     $F1+REGBASE
EETST   EQU     $F2+REGBASE
EEPROG  EQU     $F3+REGBASE
