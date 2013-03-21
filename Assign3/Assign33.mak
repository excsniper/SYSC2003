CC = icc12w
CFLAGS =  -IC:\icc\include\ -e  -l -g -Wa-g 
ASFLAGS = $(CFLAGS) 
LFLAGS =  -LC:\icc\lib\ -g -btext:0x4000 -bdata:0x1000 -dinit_sp:0x3DFF -fmots19
FILES = assign33.o 

Assign33:	$(FILES)
	$(CC) -o Assign33 $(LFLAGS) @Assign33.lk  
assign33.o:	C:\DOCUME~1\davidyao\Desktop\Lab3\assign33.c
	$(CC) -c $(CFLAGS) C:\DOCUME~1\davidyao\Desktop\Lab3\assign33.c
