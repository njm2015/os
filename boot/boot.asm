;
;   Bare bones program to enter 32 bit protected mode
;
;[org 0x7C00]
[bits 16]

section .data
extern kernel_sectors
extern ap_init_sectors
extern kernel_entry

section .boot
global boot
global CODE_SEG
boot:

KERNEL_OFFSET equ 0x1000
AP_INIT_OFFSET equ 0x4000


mov [BOOT_DRIVE], dl        ; system stores boot disk in dl

mov bp, 0x9000              ; }
mov sp, bp                  ; }= set up stack

call cls					; clear the screen
call load_kernel            ; load kernel from disk
call load_ap_init           ; load ap_init_code from disk

call switch_to_pm           ; never return from this

%include "boot/utils.asm"
%include "boot/switch_to_pm.asm"
%include "boot/disk_load.asm"

[bits 16]
load_kernel:
    
    xor bx, bx
    mov es, bx
    mov bx, KERNEL_OFFSET
    mov dh, kernel_sectors
    mov dl, [BOOT_DRIVE]
    mov cl, 0x2
    call disk_load

    ret 

load_ap_init:
    
    xor bx, bx
    mov es, bx
    mov bx, AP_INIT_OFFSET
    mov dh, ap_init_sectors
    mov dl, [BOOT_DRIVE]
    mov cl, 0x2
    add cl, kernel_sectors
    call disk_load

    ret

[bits 32]

BEGIN_PM:
   
    ; set up MP system

    call enable_lapic 

    call lapic_send_init
    mov cx, WAIT_10_ms
    call us_wait

    call lapic_send_sipi
    mov cx, WAIT_200_us
    call us_wait

    call lapic_send_sipi

    call kernel_entry

    jmp $

%include "boot/lapic.asm"

; global vars
BOOT_DRIVE  db 0

times 510-($-$$) db 0
dw 0xaa55
