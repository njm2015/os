[bits 32]

[extern main]

global kernel_entry
kernel_entry:

	nop
	nop
	nop

	call main

	jmp $
