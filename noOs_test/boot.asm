MBALIGN equ 1 << 0
MEMINFO equ 1 << 1
FRAMEBUFFER equ 1 << 2
FLAGS equ MBALIGN | MEMINFO | FRAMEBUFFER
MAGIC    equ  0x1BADB002
CHECKSUM equ -(MAGIC + FLAGS)

section .multiboot
align 4
        dd MAGIC
        dd FLAGS
        dd CHECKSUM
        dd 0,0,0,0,0
        dd 0
        dd 760
        dd 1024
        dd 16

section .bss
align 16
        stack_bottom:
        resb 16384          ; 16 KB stack.
        stack_top:

section .text
extern kernel_main
global _start:function (_start.end - _start)
_start:
        mov esp, stack_top  ; small kernel stack
       
        push ecx
        push edx
        push ebx            ; Multiboot Info Struct Address.
        push eax            ; Multiboot MAGIC number.

        call kernel_main    ; call kernel C entry point

        cli
.hang:  hlt
        jmp .hang
.end:
times 1000 db 0
