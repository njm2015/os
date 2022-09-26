LIB16=../lib16
LIB32=../lib32
LIB32_SUBDIRS = $(shell find $(LIB32) -mindepth 1 -maxdepth 1 -type d)
LIB32_INCLUDE = $(foreach d, $(LIB32_SUBDIRS), -I$(subst ,,$d))
LIB32_OBJ = $(foreach d, $(LIB32_SUBDIRS), $(wildcard $d/*.o))

KERNEL_C_SRCS = $(wildcard kernel/*.c)
KERNEL_OBJS = kernel/kernel_entry.o ${KERNEL_C_SRCS:.c=.o}
KERNEL_CFLAGS = -c -fno-pie -m32 -ffreestanding $(LIB32_INCLUDE)

TARGET_OBJS=boot/boot.o kernel/kernel.o
TARGET=boot_image

$(info $(LIB32_OBJ))

all: $(TARGET)

run: clean $(TARGET)
	cd bochs && bochs -rc bochs.cmd

$(TARGET): ${TARGET_OBJS}
	ld -o bochs/$@ -m elf_i386 -T os.lds

kernel/kernel.o : $(KERNEL_OBJS) $(LIB32_OBJ)
	ld -relocatable -m elf_i386 $^ -o $@

%.o : %.c
	gcc $(KERNEL_CFLAGS) $< -o $@

%.o : %.asm
	nasm $< -f elf -i$(LIB16) -o $@

clean:
	rm -f bochs/$(TARGET)
	rm -f **/*.o
	rm -f **/*.lock

