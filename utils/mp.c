#include "mp.h"

#define IA32_APIC_BASE_MSR 0x1b

bool check_lapic() {

    int res;
    __asm__(
        "movl $0x1, %%eax   \n "
        "cpuid              \n "
        "movl %%edx, %0     \n "
        : "=r" (res)
        : 
        : "%eax", "%edx"
    );

    return (res >> 9) & 0x1;

}

int read_apic_msr() {

    int res;
    __asm__(
        "movl %2, %%ecx         \n "
        "rdmsr                  \n "
        "movl %%edx, %0         \n "
        "movl %%eax, %1         \n "
        : "=r" (res), "=r" (res)
        : "i" (IA32_APIC_BASE_MSR)
        : "%eax", "%ecx", "%edx"
    );

    return res;

}
