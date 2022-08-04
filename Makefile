C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
SUBDIRS = $(shell find . -mindepth 1 -maxdepth 1 -type d)
OBJ = ${C_SOURCES:.c=.o}
INCLUDE_DIRS = $(foreach d, $(SUBDIRS), -I$(subst ./,,$d))
CFLAGS = -c -fno-pie -m32 -ffreestanding $(INCLUDE_DIRS)

all: os-image

run: clean all
	kvm os-image

os-image: kernel.o boot/boot.o
	ld -o $@ -m elf_i386 -T os.lds $^

kernel.o: ${OBJ}
	ld -relocatable -m elf_i386 $^ -o $@

%.o : %.c ${HEADERS}
	gcc $(CFLAGS)  $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

clean :
	rm -fr os-image kernel.o
	rm -fr boot/*.o
	rm -fr kernel/*.o drivers/*.o
