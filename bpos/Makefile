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

VM_UUID=0b68c50f-ee4b-4d47-abea-10ab2215524b

all: $(TARGET)

rund: clean $(TARGET)
	cd bochs && bochs -rc abochs.cmd -f .bochsrc_debug -q

run: clean $(TARGET)
	cd bochs && bochs -rc abochs.cmd -f .bochsrc_nodebug -q

runvb: clean attach_vdi
	VBoxManage startvm $(VM_UUID)

.PHONY: elf
elf: ${TARGET_OBJS}
	ld -o debug/$@ -m elf_i386 -T ./scripts/elf.lds && objdump -M intel -d ./debug/elf > ./debug/tmp

.PHONY: attach_vdi
attach_vdi: tmp/$(TARGET).vdi
	$(info $(VM_UUID)) 

tmp/$(TARGET).vdi : tmp/$(TARGET).img
	VBoxManage convertdd $< $@

tmp/$(TARGET).img : clean $(TARGET)
	dd if=/dev/zero of=$@ bs=1024 count=1440 && dd if=bochs/$(TARGET) of=$@ conv=notrunc

$(TARGET): ${TARGET_OBJS}
	ld -o bochs/$@ -m elf_i386 -T ./scripts/os.lds

kernel/kernel.o : $(KERNEL_OBJS) $(LIB32_OBJ)
	ld -relocatable -m elf_i386 $^ -o $@

%.o : %.c
	gcc $(KERNEL_CFLAGS) $< -o $@

%.o : %.asm
	nasm $< -f elf -i$(LIB16) -o $@

clean:
	rm -f tmp/*
	rm -f bochs/bochsout.txt
	rm -f bochs/$(TARGET)
	rm -f **/*.o
	rm -f **/*.lock

