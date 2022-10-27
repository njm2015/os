[bits 16]

;extern kernel_entry

switch_to_pm:

	cli
	lgdt [gdt_descriptor]
	mov eax, cr0
	or al, 1
	mov cr0, eax

	jmp CODE_SEG:init_pm

%include "gdt.asm"

[bits 32]

init_pm:

	mov bx, DATA_SEG
	mov ds, bx
	mov ss, bx
	mov es, bx
	mov fs, bx
	mov gs, bx

	;mov ebp, 0x9000
	;mov esp, ebp

	call kernel_entry
