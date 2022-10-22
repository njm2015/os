[bits 16]

lock16:
	push bp
	mov bp, sp

.spin:
	xor ax, ax
	mov cx, 1
	mov si, word [bp+4]
	lock cmpxchg byte [si], cl
	jz .done
	pause
	jmp .spin

.done:
	mov sp, bp
	pop bp
	
	ret

unlock16:
	push bp
	mov bp, sp

	mov ax, 1
	xor cx, cx
	mov si, word [bp+4]
	lock cmpxchg byte [si], cl
	
	mov sp, bp
	pop bp

	ret
