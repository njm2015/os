[bits 16]

;extern KERNEL_ADDR
;extern KERNEL_SECTORS
;extern DRIVE_NUM

read_kernel_from_disk:
	mov ah, 0x2
	mov al, KERNEL_SECTORS
	mov dl, [DRIVE_NUM]
	mov cx, 0x2
	mov dh, 0x0
	xor bx, bx
	mov es, bx
	mov bx, KERNEL_ADDR
	int 0x13

	ret
