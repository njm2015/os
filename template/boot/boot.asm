;[org 0x7c00]
[bits 16] 

extern KERNEL_SECTORS
KERNEL_ADDR equ 0x1000

section .boot

global boot
boot:
	mov [DRIVE_NUM], dl
	call read_kernel_from_disk
	call switch_to_pm
 
%include "disk.asm"
%include "pm.asm"

DRIVE_NUM db 0

times 510-($-$$) db 0
dw 0xaa55
