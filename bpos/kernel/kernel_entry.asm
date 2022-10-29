[bits 16]

[extern main]

global pre_kernel
global proc_lock
global proc_cnt
global print_lock

pre_kernel:

;mov bx, lock_attempt
;call print_string

times 5 nop
;push proc_lock
jmp proclock
;add sp, 2 


proclock_done:

call switch_to_pm

%include "lock.asm"
%include "pm.asm"
%include "print_string.asm"

[bits 32]

kernel_entry:

	times 3 nop

	mov ecx, 0x9000
	mov eax, 0x1000
	xor ebx, ebx
	mov bl, byte [proc_cnt]
	mul ebx
	add eax, ecx
	mov ebp, eax
	mov esp, ebp

	call main
	jmp $

proc_lock dw 0x0
proc_cnt db 0x0
print_lock db 0x0
lock_attempt db "Attempting to get proc_lock...",0
