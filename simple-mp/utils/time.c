#include "time.h"

void us_wait(int us) {

    __asm__(
        "movl %0, %%ecx         \n "
        "movl $0x80, %%edx      \n "
        "xor %%esi, %%esi       \n "
        "rep outsb"
        :
        : "r" (us)
        : "%edx", "%esi"
    );

    return;

}
