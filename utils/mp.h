#ifndef UITLS_MP_H
#define UTILS_MP_H

#include "types.h"
#include "time.h"

#define IA32_APIC_BASE 0xfee00000
#define IA32_APIC_ICR_LOW 0xfee00300
#define IA32_APIC_SVR 0xfee000f0
#define IA32_APIC_ID 0xfee00020
#define IA32_APIC_LVT3 0xfee00370
#define IA32_APIC_BASE_MSR 0x1b
#define IA32_APIC_MTRR 0x26f

bool check_lapic();
int read_apic_id();
int read_apic_base();
void set_apic_base(int new_addr);
int read_lapic_id();
void set_apic_lvt3(int new_vec);
int read_apic_lvt3();
void send_init_sipi_ipi(char exec_vec);

#endif
