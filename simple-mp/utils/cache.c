#include "cache.h"

bool check_mtrr_enabled() {

    int res;
    __asm__(
        "movl $0x1, %%eax    \n "
        "cpuid              \n "
        "movl %%edx, %0      \n "
        : "=r" (res)
        :
        : "%eax", "%ebx", "%ecx", "%edx"
    );

    return (res >> 12) & 0x1;

}

int read_msr(int reg) {

    int res;
    __asm__(
        "movl %1, %%ecx     \n "
        "rdmsr              \n "
        "movl %%eax, %0     \n "
        : "=r" (res)
        : "r" (reg)
        : "%eax", "%ecx", "%edx"
    );

    return res;

}

void set_msr(int reg, int val) {

    __asm__(
        "movl %0, %%ecx     \n "
        "movl %1, %%eax     \n "
        "xor %%edx, %%edx   \n "
        "wrmsr              \n "
        :
        : "r" (reg), "r" (val)
        : "%eax", "%ecx", "%edx"
    );

}

void set_mtrr_fixed_lower(int reg, int mask) {

    __asm__(
        "movl %0, %%ecx     \n "
        "rdmsr              \n "
        "and %1, %%eax      \n "
        "wrmsr              \n "
        :
        : "r" (reg), "r" (mask)
        : "%eax", "%ecx", "%edx"
    );

}

bool read_cache_cd() {
    
    int res;
    __asm__(
        "movl %%cr0, %0     \n "
        : "=r" (res)
        :
        :
    );

    return (res >> 30) & 0x1;

}

bool read_cache_nw() {

    int res;
    __asm__(
        "movl %%cr0, %0     \n "
        : "=r" (res)
        :
        :
    );

    return (res >> 29) & 0x1;

}

void enable_cache() {

    __asm__(
        "movl %%cr0 ,%%ebx      \n "
        "and 0x9fffffff, %%ebx  \n "
        "movl %%ebx, %%cr0      \n "
        :
        :
        : "%ebx"
    );

}
