nasm boot/boot.asm -f bin -i../lib16 -o boot.bin

dd if=/dev/zero of=disk.img bs=1024 count=1440
dd if=boot.bin of=disk.img conv=notrunc

kvm disk.img
