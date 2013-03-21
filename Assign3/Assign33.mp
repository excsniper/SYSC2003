
Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   4000   0601 =   1537. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       4000  __start
       4028  _exit
       402A  _displaySystemStatus
       402A  __text_start
       40F0  _main
       4182  _putchar
       41AA  _strcpy
       41B9  __va_start
       41D7  __HC12Setup
       41DC  _itoa
       4264  _islower
       427C  __ctype
       437D  _toupper
       439D  __print
       45D2  _printf
       4601  __text_end

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
assign33.o	[ assign33.c ]
<library>	[ putchar.c, strcpy.s, stdarg.s, setup.s, itoa.s, islower.s, ctype.s, toupper.s, _printf.s, printf.s ]
[ textmode.s ]

User Global Definitions

init_sp = 0x3dff

User Base Address Definitions

text = 0x4000
data = 0x1000

