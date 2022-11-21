[org 0x7c00]
[bits 16] 

section .boot

boot:

	in al, 0x92
	or al, 2
	out 0x92, al

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov bx, 0x9000

    cli
    mov ss, bx
    mov sp, ax 
    sti

    cld
   
    mov dx, test_string
    call print_string
    
    jmp $

%include "print_string.asm"

pre_string db "abcdefg"
test_string db "HELP ME SOS",0

times 510-($-$$) db 0				; pad for 512 bytes
dw 0xaa55							; boot_sect magic number
