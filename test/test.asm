[org 0x7c00]
[bits 16]

main:
    
    mov bx, test_str
    call print_string

    ret

%include 'print_string.asm'

test_str: db "Hello, World!", 0

times 510-($-$$) db 0
dw 0xaa55
