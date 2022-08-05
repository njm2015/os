#include "io.h"
#include "mp.h"

void main() {

    if (check_lapic())
        puts("APIC enabled...");
    else
        puts("APIC disabled...");

    putih(read_apic_msr());

}
