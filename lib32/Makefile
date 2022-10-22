SUBDIRS = $(shell find . -mindepth 1 -maxdepth 1 -type d)
C_SRCS = $(foreach d, $(SUBDIRS), $(wildcard $d/*.c))
C_OBJ = ${C_SRCS:.c=.o}

ASM_SRCS = $(foreach d, $(SUBDIRS), $(wildcard $d/*.asm))
ASM_OBJ = ${ASM_SRCS:.asm=.o}

INCLUDE_DIRS = $(foreach d, $(SUBDIRS), -I$(subst ./,,$d))
CFLAGS = -c -fno-pie -m32 -ffreestanding $(INCLUDE_DIRS)

all: $(C_OBJ) $(ASM_OBJ)

%.o : %.c
	gcc $(CFLAGS) $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

clean:
	rm **/*.o
