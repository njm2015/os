#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "multiboot.h"

void kernel_main(uint32_t magic_number, uint32_t mb_addr) {

    multiboot_info_t* mbi = (multiboot_info_t*) mb_addr;
    uint16_t* fb = mbi->framebuffer_addr;

    for (size_t i = 100 * 760; i < 105 * 760; ++i)
        *(fb + i) = 0x7800;

}
