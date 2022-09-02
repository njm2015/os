[bits 16]

cls:
	push ax
	mov ax, 0x0003
	int 0x10
	pop ax
	ret
