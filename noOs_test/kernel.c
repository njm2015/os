#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "multiboot.h"

#define WIDTH 1920
#define HEIGHT 1080

void kernel_main(uint32_t magic_number, uint32_t mb_addr) {

    multiboot_info_t* mbi = (multiboot_info_t*) mb_addr;
    uint16_t* fb = mbi->framebuffer_addr;

    for (size_t i = 0; i < HEIGHT; ++i) {
        for (size_t j = 0; j < WIDTH; ++j) {
            *(fb + ((i * WIDTH) + j) * 2) = 0xffff;
        }
    }

}
