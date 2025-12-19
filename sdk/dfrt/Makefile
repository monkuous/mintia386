ifndef TARGET
	TARGET := xr17032
endif

ifndef DFRTTRANS
	DFRTTRANS := ../../dfrttrans/build/libs/dfrttrans-0.0.jar
endif

ifndef ELFCONVERT
	ELFCONVERT := ../../dfrttrans/build/libs/dfrttrans-0.0-elfconvert.jar
endif

DFILES := $(wildcard ./src/*.df ./src/$(TARGET)/*.df)
SFILES := $(wildcard ./src/$(TARGET)/*.s)
GFILES := $(wildcard ./src/$(TARGET)/*.S)
OBJ    := $(DFILES:.df=.$(TARGET).o)
SOBJ   := $(SFILES:.s=.$(TARGET).o)
GOBJ   := $(GFILES:.S=.$(TARGET).o)

DC  =  ../dragonc.sh
AS  =  ../asm.sh
LD  =  ../link.sh link

all: obj/$(TARGET)/dfrt.f.o

obj/$(TARGET)/dfrt.f.o: $(OBJ) $(SOBJ) $(GOBJ)
	mkdir -p obj/$(TARGET)
	$(LD) -f obj/$(TARGET)/dfrt.f.o $(OBJ) $(SOBJ) $(GOBJ)

%.$(TARGET).o: %.df
	$(DC) target=$(TARGET) $< $@ incdir=./headers/

%.$(TARGET).o: %.s
	$(AS) target=$(TARGET) $< $@

%.$(TARGET).o: %.S
	$(CC) -nostdinc -c -o $@.elf.o $<
	java -jar $(ELFCONVERT) $@.elf.o $@
	rm $@.elf.o

cleanup:
	rm -f $(OBJ) $(SOBJ) obj/*/dfrt.f.o
