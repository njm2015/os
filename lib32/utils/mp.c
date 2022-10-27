#include "mp.h"

bool check_lapic() {

    int res;
    __asm__(
        "movl $0x1, %%eax   \n "
        "cpuid              \n "
        "movl %%edx, %0     \n "
        : "=r" (res)
        : 
        : "%eax", "%ebx", "%ecx", "%edx"
    );

    return (res >> 9) & 0x1;

}

bool check_x2apic() {

	int res;
	__asm__(
		"movl $0x1, %%eax	\n "
		"cpuid				\n "
		"movl %%ecx, %0		\n "
		: "=r" (res)
		:
		: "%eax", "%ebx", "%ecx", "%edx"
	);

	return (res >> 21) & 0x1;

}

bool is_bsp() {

	int res;
	__asm__(
		"movl %1, %%ecx	\n "
		"rdmsr				\n "
		"movl %%eax, %0		\n "
		: "=r" (res)
		: "r" (IA32_APIC_BASE_MSR)
		: "%eax", "%ecx"
	);

	return (res >> 8) & 0x1;

}

int read_apic_id() {

    int res;
    __asm__(
        "movl $0x1, %%eax   \n "
        "cpuid              \n "
        "movl %%ebx, %0     \n "
        : "=r" (res)
        :
        : "%eax", "%ebx", "%ecx", "%edx"
    );

    return (res);

}

int read_apic_base() {

    int res;
    __asm__(
        "movl %1, %%ecx         \n "
        "rdmsr                  \n "
        "movl %%eax, %0         \n "
        : "=r" (res)
        : "i" (IA32_APIC_BASE_MSR)
        : "%eax", "%ecx", "%edx"
    );

    return res & 0xfffff000;

}

void set_apic_base(int new_addr) {

    __asm__(
        "movl %1, %%ecx         \n "
        "rdmsr                  \n "
        "and $0xfff, %%eax      \n "
        "movl %0, %%ebx         \n "
        "and $0xfffff000, %%ebx \n "
        "or $0x800, %%ebx       \n "
        "or %%ebx, %%eax        \n "
        "wrmsr                  \n "
        :
        : "r" (new_addr), "r" (IA32_APIC_BASE_MSR)
        : "%eax", "%ebx", "%ecx", "%edx"
    );

}

int read_lapic_id() {

    int res;
    __asm__(
        "movl %1, %%esi         \n "
        "movl (%%esi), %%eax    \n "
        "movl %%eax, %0         \n "
        : "=r" (res)
        : "r" (IA32_APIC_ID)
        : "%eax", "%esi"
    );

    return res;

}

int read_lapic_svr() {

	int res;
	__asm__(
		"movl %1, %%esi			\n "
		"movl (%%esi), %%eax	\n "
		"movl %%eax, %0			\n "
		: "=r" (res)
		: "r" (IA32_APIC_SVR)
		: "%eax", "%esi"
	);

	return res;

}

void enable_lapic() {

	__asm__(
		"movl %0, %%esi			\n "
		"movl (%%esi), %%eax	\n "
		"or %1, %%eax			\n "
		"movl %%eax, (%%esi)	\n "
		:
		: "r" (IA32_APIC_SVR), "r" (IA32_APIC_ENABLE)
		: "%eax", "%esi"
	);

}

void set_apic_lvt3(int new_vec) {

    __asm__(
        "movl %0, %%esi         \n "
        "movl (%%esi), %%eax    \n "
        "and $0xffffff00, %%eax \n "
        "or %1, %%eax           \n "
        "mov %%eax, (%%esi)     \n "
        :
        : "r" (IA32_APIC_LVT3), "r" (new_vec)
        : "%eax", "%esi"
    );

}

int read_apic_lvt3() {

    int res;
    __asm__(
        "movl %0, %%esi         \n "
        "movl (%%esi), %0       \n "
        : "=r" (res)
        : "r" (IA32_APIC_LVT3)
        : "%esi"
    );

    return res;

}

void send_init_sipi_ipi(char exec_vec) {

    __asm__(
        "movl %0, %%esi         \n "
        "movl $0xc4500, %%eax   \n "
        "movl %%eax, (%%esi)    \n "
        :
        : "r" (IA32_APIC_ICR_LOW)
        : "%eax", "%esi"
    );

    //*((char*) 0xb8020) = 'z';

    us_wait(WAIT_10_ms);

    //*((char*) 0xb8022) = 'y';

    __asm__(
        "movl %0, %%esi         \n "
        "movl $0xc4601, %%eax   \n "
        "movl %%eax, (%%esi)    \n "
        :
        : "r" (IA32_APIC_ICR_LOW)
        : "%eax", "%esi"
    );

    us_wait(WAIT_200_us);

    __asm__(
        "movl %0, %%esi         \n "
        "movl $0xc4601, %%eax   \n "
        "movl %%eax, (%%esi)    \n "
        :
        : "r" (IA32_APIC_ICR_LOW)
        : "%eax", "%esi"     
    );

}
