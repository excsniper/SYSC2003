
Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   4000   062C =   1580. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       4000  __start
       4028  _exit
       402A  _collision_detection
       402A  __text_start
       409C  _main
       41AD  _putchar
       41D5  _strcpy
       41E4  __va_start
       4202  __HC12Setup
       4207  _itoa
       428F  _islower
       42A7  __ctype
       43A8  _toupper
       43C8  __print
       45FD  _printf
       462C  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   1000   001B =     27. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       1000  __bss_start
       1019  __textmode
       101B  __bss_end

Files Linked      [ module(s) ]

C:\icc\lib\crt12.o	[ crt12.s ]
assign34.o	[ assign34.c ]
<library>	[ putchar.c, strcpy.s, stdarg.s, setup.s, itoa.s, islower.s, ctype.s, toupper.s, _printf.s, printf.s ]
[ textmode.s ]

User Global Definitions

init_sp = 0x3dff

User Base Address Definitions

text = 0x4000
data = 0x1000

