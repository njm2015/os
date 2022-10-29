[org 0x7c00]
[bits 16] 

section .boot

boot:
	mov ax, 0
	mov cs, ax
	mov bp, 0x2000
	mov sp, bp

	call cls
	mov bx, test_string
	call print_string
	jmp $

%include "display.asm"
%include "print_string.asm"

test_string db "HELP ME SOS",0

times 510-($-$$) db 0				; pad for 512 bytes
dw 0xaa55							; boot_sect magic number
