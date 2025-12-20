INCLUDES := $(subst :, ,$(INCDIR))
INCLUDEFILES := $(foreach incdir,$(INCLUDES),$(shell find $(incdir) -type f -name "*.h"))

SFILES := $(foreach component,$(COMPONENTS),$(wildcard $(component)/$(ARCHITECTURE)/*.s))
GFILES := $(foreach component,$(COMPONENTS),$(wildcard $(component)/$(ARCHITECTURE)/*.S))

DFILES := $(foreach component,$(COMPONENTS),$(wildcard $(component)/*.df)) \
			$(foreach component,$(COMPONENTS),$(wildcard $(component)/$(ARCHITECTURE)/*.df))
CFILES := $(foreach component,$(COMPONENTS),$(wildcard $(component)/*.c)) \
			$(foreach component,$(COMPONENTS),$(wildcard $(component)/$(ARCHITECTURE)/*.c))

OBJ    := $(DFILES:.df=.$(ARCHITECTURE).$(CHKFRE).o)
COBJ   := $(CFILES:.c=.$(ARCHITECTURE).$(CHKFRE).o)
SOBJ   := $(SFILES:.s=.$(ARCHITECTURE).$(CHKFRE).o)
GOBJ   := $(GFILES:.S=.$(ARCHITECTURE).$(CHKFRE).o)

ifndef EXECFILEMODE
	EXECFILEMODE := 493
endif

FULLOUTPUTFILE = $(BUILDROOT)/$(OUTPUTFILE).$(ARCHITECTURE).$(CHKFRE)

all: $(FULLOUTPUTFILE)

$(FULLOUTPUTFILE): $(COBJ) $(OBJ) $(SOBJ) $(GOBJ)
	$(LNK) link $(LINKOPT) $(FULLOUTPUTFILE) $(PRELIBS) $(GOBJ) $(SOBJ) $(COBJ) $(OBJ) $(LIBS) -d $(DYLIBS)

ifdef MOVEEXPR
	$(LNK) move $(FULLOUTPUTFILE) $(MOVEEXPR)
else
	$(LNK) move $(FULLOUTPUTFILE) mintia
endif

ifdef MKBINARY
	$(LNK) binary -nobss $(FULLOUTPUTFILE)
	echo "$(OUTPUTFILE) $(FULLOUTPUTFILE)" >> $(DELTA)
else
	$(LNK) istrip $(FULLOUTPUTFILE)
	echo "$(OUTPUTFILE) $(FULLOUTPUTFILE) $(EXECFILEMODE)" >> $(DELTA)
endif

define COMPONENT_TEMPLATE

$(1)/%.$$(ARCHITECTURE).$$(CHKFRE).o: $(1)/%.c $$(wildcard $(1)/*.h)
	$$(CC) -Wall -Wextra -Wno-multichar -ffreestanding -fno-asynchronous-unwind-tables -fno-pie -fno-stack-protector -nostdinc -std=gnu23 -O3 -c -o $$@.elf.o $$<
	java -jar $(ELFCONVERT) $$@.elf.o $$@
	rm $$@.elf.o

$(1)/%.$$(ARCHITECTURE).$$(CHKFRE).o: $(1)/%.df $$(INCLUDEFILES) $$(wildcard $(1)/*.h)
	$$(DFC) $$< $$@ incdir=$$(INCDIR) libdir=$$(LIBDIR)

endef

$(foreach component,$(COMPONENTS), \
	$(eval $(call COMPONENT_TEMPLATE,$(component))) \
)

%.$(ARCHITECTURE).$(CHKFRE).o: %.S
	$(CC) -nostdinc -c -o $@.elf.o $<
	java -jar $(ELFCONVERT) $@.elf.o $@
	rm $@.elf.o

%.$(ARCHITECTURE).$(CHKFRE).o: %.s
	$(ASM) $< $@

cleanup:
	rm -f ${OBJ} ${SOBJ} $(FULLOUTPUTFILE)
