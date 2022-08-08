;
; Use this to switch to pm
;
[BITS 16]

%include "boot/gdt.asm"

switch_to_pm:
    cli

    lgdt [gdt_descriptor]       ; load descriptor

    mov eax, cr0                ; }
    or eax, 0x1                 ; }= flip first bit of cr0 to make the switch
    mov cr0, eax                ; }

    jmp CODE_SEG:init_pm



[BITS 32]

init_pm:

    mov bx, DATA_SEG            ; }
    mov ds, bx                  ; }
    mov ss, bx                  ; }
    mov es, bx                  ; }= update segment registers for 32 bit mode
    mov fs, bx                  ; }`
    mov gs, bx                  ; }

    ;and ax, 0xfffe
    ;mov cr0, eax
    
    ;mov dword [0xb8000], 0x07690748
    ;hlt

    mov ebp, 0x9000             ; }
    mov esp, ebp                ; }= set up stack

    call BEGIN_PM
