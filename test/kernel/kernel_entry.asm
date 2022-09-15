[bits 32]

global kernel_entry
kernel_entry:

	xor eax, eax
	mov ds, eax
	mov es, eax
	mov fs, eax
	mov gs, eax

	nop
	nop
	nop
