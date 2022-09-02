[bits 16]

section .ap_init

extern CODE_SEG
extern kernel_entry

global start_ap

start_ap:

    mov ax, word [ap_counter]

    .try:
        mov bx, ax
        inc bx
        lock cmpxchg word [ap_counter], bx
    jnz .try

    mov word [counter], ax

    shl ax, 12
    mov bx, cs
    add ax, bx
    mov ss, ax 

    call switch_to_pm_ap

    jmp $

%include "boot/switch_to_pm_ap.asm"

[bits 32]

BEGIN_PM_AP:

    ;mov eax, dword [counter]
    
    ;mov ebx, eax
    ;add ebx, 0x30
    ;mov byte [0xb8000 + 2*eax], bl

    ;mov eax, 80
    ;mov ecx, [counter]
    ;mul ecx
    ;add eax, 0xb8000
    ;mov byte [eax], cl

    call kernel_entry

global ap_counter
global counter
ap_counter dw 1
counter dw 0
