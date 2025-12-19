ifndef MINTIA_CC
	PLATFORM := PC
endif

ifndef MINTIA_CC
	MINTIA_CC := gcc -m32 -march=i486 -mgeneral-regs-only
endif

CC := $(MINTIA_CC)

include mintia/$(PLATFORM).mk

TARGET := $(ARCHITECTURE)

export PLATFORM
export TARGET
export CC

REPO := $(shell pwd)

export DFRTTRANS := $(REPO)/dfrttrans/build/libs/dfrttrans-0.0.jar
export ELFCONVERT := $(REPO)/dfrttrans/build/libs/dfrttrans-0.0-elfconvert.jar

ifeq ($(TARGET),xr17032)
RTA3X := rta3x
else
RTA3X :=
endif

all: $(DFRTTRANS) $(ELFCONVERT) dfrt $(RTA3X) os

os: $(DFRTTRANS) $(ELFCONVERT) dfrt $(RTA3X)
	$(MAKE) -C mintia

ifeq ($(TARGET),xr17032)
rta3x: $(DFRTTRANS) $(ELFCONVERT) dfrt
	cd a3x && ./build-rta3x.sh
endif

dfrt: $(DFRTTRANS) $(ELFCONVERT)
	sdk/build-dfrt.sh TARGET=$(TARGET)

$(DFRTTRANS): $(wildcard $(REPO)/dfrttrans/src/main/java/**/*.java)
	cd dfrttrans && ./gradlew jar

$(ELFCONVERT): $(wildcard $(REPO)/dfrttrans/src/elfconvert/java/**/*.java)
	cd dfrttrans && ./gradlew elfconvertJar

cleanup:
	cd dfrttrans && ./gradlew clean
	$(MAKE) -C sdk/dfrt cleanup
	$(MAKE) -C a3x/rta3x cleanup
	$(MAKE) -C mintia cleanup
