OUTPUTFILE := OSLoader.bin

LIBS     := L/dfrt/dfrt.f.o
MOVEEXPR := header=0x4000,text=header+header_size,data=text+text_size,bss=data+data_size
MKBINARY := yes
