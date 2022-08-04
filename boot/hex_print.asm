;
; simple library for printing register values
;

;[BITS 16]
;[ORG 0X7C00]

;mov esp, 0xffff

;mov ax, 0x0003
;int 0x10

;mov dx, 0x1235
;call print_dx
;mov dx, 0x5431
;call print_dx
;ret

;
; function that prints the value contained in the dx register
; this function serves as the base for most other functions in this file
;
; @param dx: value to be printed in hex to tty
;
print_dx:
    
    push ebp
    mov ebp, esp
    push ax                     ; }
    push bx                     ; } = push all registers used in func
    push cx                     ; }
    push dx                     ; }

    xor cx, cx                  ; zero counter

    .one_op:                    ; sub func for value -> ascii for half byte
        cmp cx, 4               ; }
        jge .done               ; } = if cnt >= 4 jmp .done
        mov ax, dx              ; copy remaining bytes to ax
        and ax, 0xf             ; only examine lsb

        cmp ax, 0x9             ; }
        jg .gt_ten              ; } = if ax > 9 jump to alphabetical ascii

        add ax, 0x30            ; ax <= 9 so only add 0x30 for ord -> char conv
        jmp .place_char         ; done with calculation - jump to copy step
         
        .gt_ten:                
        add ax, 0x57            ; ax > 9, so add 0x57 for ord -> char conv

        .place_char:
        mov bx, temp            ; load addr of temp
        add bx, cx              ; set offset to load char
        mov [bx], al            ; mov char to addr + offset

        inc cx                  ; increment counter
        shr dx, 4               ; shift remaining data right 4 bits (half byte)
 
    jmp .one_op                 ; do .one_op again

    .done:
    
    mov cx, 4                   ; set counter to 4 to print temp backwards

    .print_loop:
        test cx, cx             ; }
        je .return              ; } = if cx == 0 jmp to return

        mov bx, temp            ; move temp addr to bx
        add bx, cx              ; add counter offset
        mov al, [bx-1]          ; bx-1 is true offset, but cmp with 0 is easier than lt zero
        mov ah, 0x0e            ; al contains byte to print - mov tty write int value to ah
        int 0x10                ; tty char write

        dec cx                  ; dec cx since we started at 4

    jmp .print_loop             ; repeat this 4 times

    .return:
    pop dx
    pop cx
    pop bx
    pop ax
    pop ebp

    ret    

temp times 4 db 0   

;times 510-($-$$) db 0
;dw 0xaa55
