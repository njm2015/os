SOURCES_C := $(wildcard *.c)
SOURCES_ASM := $(wildcard *.asm)
OBJS := $(SOURCES_C:%.c=%.o) $(SOURCES_ASM:%.asm=%.o)

all: noOs.iso

.PHONY: run
run:
	qemu-system-i386 -bios /usr/share/ovmf/OVMF.fd -cdrom noOs.iso

noOs.iso: noOs.bin grub.cfg
	bash -c "cp noOs.bin isodir/boot/grub"
	bash -c "cp grub.cfg isodir/boot/grub/grub.cfg"
	bash -c "grub-mkrescue -o $@ isodir"

noOs.bin: linker.ld $(OBJS)
	i686-elf-gcc -T $< -o $@ -ffreestanding -nostdlib $(OBJS) -lgcc 

kernel.o: kernel.c
	i686-elf-gcc -c $< -o $@ -std=gnu99 -ffreestanding -Wall -Wextra

boot.o: boot.asm
	nasm -felf32 $< -o $@

clean:
	rm -f $(OBJS)
	rm -f noOs.bin
	rm -f noOs.iso
