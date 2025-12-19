all: .new

.new: PCJump.bin AisixFSBoot.bin
	$(APTOOL) wb PCJump.bin
	dd if=PCJump.bin of=$(DISTIMAGE) bs=512 conv=notrunc skip=1 seek=1 status=none
	dd if=AisixFSBoot.bin of=$(DISTIMAGE) bs=512 conv=notrunc seek=5 status=none
	touch .new

%.bin: %.S bootcode.lds BootDefs.S LibIO.S LibPrint.S
	$(CC) -nostdinc -nostdlib -static -Wl,--oformat=binary -Wl,--build-id=none -Tbootcode.lds -o $@ $<

cleanup:
	rm -f *.bin
