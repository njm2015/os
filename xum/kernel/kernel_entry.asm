[bits 16]

[extern main]

global pre_kernel
global proc_lock
global proc_cnt

pre_kernel:

push proc_lock
call lock16
add sp, 2 

call switch_to_pm

%include "lock.asm"
%include "pm.asm"

[bits 32]

kernel_entry:

	times 3 nop

	call main
	jmp $

proc_lock db 0x0
proc_cnt db 0x0
