gdb noOs.bin \
-ex 'target remote localhost:1234' \
-ex 'layout asm' \
-ex 'layout source' \
-ex 'layout regs' \
-ex 'break _start' \
-ex 'continue'
