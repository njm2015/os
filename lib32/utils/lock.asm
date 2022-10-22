[bits 32]

global _lock32
global _unlock32

_lock32:
	push ebp
	mov ebp, esp

.spin:
	xor al, al
	mov cl, 1
	mov esi, dword [ebp+8]
	lock cmpxchg byte [esi], cl
	jz .done
	pause
	jmp .spin

.done:
	mov esp, ebp
	pop ebp

	ret

_unlock32:
	push ebp
	mov ebp, esp

	mov al, 1
	xor cl, cl
	mov esi, dword [ebp+8]
	lock cmpxchg byte [esi], cl

	mov esp, ebp
	pop ebp

	ret
