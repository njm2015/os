[bits 16]

;
; Prints a string ending in null byte
; bx <-- pointer to start of string
;
print_string:
    
    mov ah, 0x0e                ; BIOS print char index

    .iter_start:

        mov al, byte [bx]       ; load char to print into al
        test al, al             ; if al == 0
        jz .end                 ;     goto .end

        int 0x10                ; BIOS interrupt
        inc bx                  ; ++dx
        jmp .iter_start         ; loop again

    .end:
        ret
