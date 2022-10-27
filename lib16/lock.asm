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

proclock:
.spin_proclock:
	xor ax, ax
	mov cx, 1
;	mov si, word [proc_lock]
	lock cmpxchg word [proc_lock], cx
	jz .done_proclock
	pause
	jmp .spin_proclock

.done_proclock:
	jmp proclock_done

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
