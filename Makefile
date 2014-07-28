DD=dd
NASM=nasm
QEMU=qemu-system-i386
BOOTLOADER_ASM=bootloader.asm
BOOTLOADER_BIN=bootloader.bin
BOOTLOADER_FLP=bootloader.flp


run: make-flopy
	$(QEMU) -fda $(BOOTLOADER_FLP) -curses

kill:
	kill `pidof $(QEMU)`


compile: $(BOOTLOADER_ASM)
	$(NASM) -f bin -o $(BOOTLOADER_BIN) $(BOOTLOADER_ASM)


make-flopy: $(BOOTLOADER_BIN) compile
	$(DD) conv=notrunc bs=512 count=1 if=$(BOOTLOADER_BIN) of=$(BOOTLOADER_FLP)
