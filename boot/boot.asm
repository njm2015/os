;
;   Bare bones program to enter 32 bit protected mode
;
;[org 0x7C00]
[bits 16]

section .data
extern kernel_sectors

section .boot
global boot

boot:

KERNEL_OFFSET equ 0x8000

mov [BOOT_DRIVE], dl        ; system stores boot disk in dl

mov bp, 0x9000              ; }
mov sp, bp                  ; }= set up stack



call cls					; clear the screen
call load_kernel            ; load kernel from disk

call switch_to_pm           ; never return from this

jmp $

%include "boot/utils.asm"
%include "boot/print_string_32.asm"
%include "boot/switch_to_pm.asm"
%include "boot/disk_load.asm"
%include "boot/hex_print.asm"

[bits 16]
load_kernel:
    
    xor bx, bx
    mov es, bx
    mov bx, KERNEL_OFFSET
    mov dh, kernel_sectors
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret 

[bits 32]

BEGIN_PM:
    
    call KERNEL_OFFSET

    jmp $


; global vars
BOOT_DRIVE  db 0
MSG_PROT_MODE db "Successfully entered 32 bit protected mode", 0

times 510-($-$$) db 0
dw 0xaa55
