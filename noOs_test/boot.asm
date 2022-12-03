MBALIGN equ 1 << 0
MEMINFO equ 1 << 1
MBVIDEO equ 1 << 2
FLAGS equ MBALIGN | MEMINFO | MBVIDEO
MAGIC equ 0x1BADB002
CHECKSUM equ -(MAGIC + FLAGS)

section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM
    dd 0 ; header_addr
    dd 0 ; load_addr
    dd 0 ; load_end_addr
    dd 0 ; bss_end_addr
    dd 0 ; entry_addr
    dd 0 ; mode_type
    dd 1024 ; video width
    dd 768  ; video height
    dd 16   ; video depth

section .bss
align 16
stack_bottom:
resb 16384 ; 16 KB
stack_top:

section .text
global _start:function (_start.end - _start)
_start:
	mov esp, stack_top
	
	extern kernel_main
	call kernel_main

	cli
.hang:
	hlt
	jmp .hang
.end:
