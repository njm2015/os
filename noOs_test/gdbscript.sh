gdb noOs.bin \
-ex 'target remote localhost:1234' \
-ex 'layout asm' \
-ex 'layout regs' \
-ex 'break _start' \
-ex 'break kernel_main' \
-ex 'continue'
