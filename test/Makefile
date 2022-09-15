LIB16=../lib16
TARGET_OBJS=boot/boot.o kernel/kernel.o
KERNEL_OBJS=kernel/kernel_entry.o 
TARGET=boot_image

all: $(TARGET)

run: clean $(TARGET)
	cd bochs && bochs -rc bochs.cmd

$(TARGET): ${TARGET_OBJS}
	ld -o bochs/$@ -m elf_i386 -T os.lds

kernel/kernel.o : ${KERNEL_OBJS}
	ld -relocatable -m elf_i386 $^ -o $@

%.o : %.asm
	nasm $< -f elf -i$(LIB16) -o $@

clean:
	rm -f bochs/$(TARGET)
	rm -f **/*.o
	rm -f **/*.lock

