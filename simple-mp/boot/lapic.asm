[bits 32]
 
IA32_APIC_BASE_MSR EQU 0x1b
IA32_APIC_REG_SIV EQU 0xf0
IA32_APIC_REG_ICR_LOW EQU 0x300
IA32_APIC_REG_ICR_HIGH EQU 0x310
IA32_APIC_REG_ID EQU 0x20
IA32_APIC_REG_LVT3 EQU 0x370

WAIT_10_ms EQU 10000
WAIT_200_us EQU 200

us_wait:
    
    mov dx, 0x80
    xor si, si
    rep outsb

    ret

enable_lapic:

    mov ecx, IA32_APIC_BASE_MSR
    rdmsr
    or ah, 0x8
    wrmsr

    and ah, 0xf0
    mov dword [APIC_BASE], eax

    mov ecx, dword [fs: eax + IA32_APIC_REG_SIV]
    or ch, 0x1
    mov dword [fs: eax + IA32_APIC_REG_SIV], ecx

    ret

lapic_lvt3:

    mov eax, dword [APIC_BASE]

    mov ebx, dword [fs: eax + IA32_APIC_REG_LVT3] 
    and ebx, 0xffffff00
    or ebx, 0xff
    mov dword [fs: eax + IA32_APIC_REG_LVT3], ebx

    ret

lapic_send_init:
    
    mov eax, dword [APIC_BASE]
    
    xor ebx, ebx
    mov dword [fs: eax + IA32_APIC_REG_ICR_HIGH], ebx

    mov ebx, 0xc4500
    mov dword [fs: eax + IA32_APIC_REG_ICR_LOW], ebx

    ret

lapic_send_sipi:
    
    mov eax, dword [APIC_BASE]

    xor ebx, ebx
    mov dword [fs: eax + IA32_APIC_REG_ICR_HIGH], ebx

    mov ebx, 0xc4604
    mov dword [fs: eax + IA32_APIC_REG_ICR_LOW], ebx

    ret

APIC_BASE dd 0
