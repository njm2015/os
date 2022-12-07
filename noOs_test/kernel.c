#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "multiboot.h"

#define WIDTH 1920
#define HEIGHT 1080

void put_pixel(size_t x, size_t y, unsigned int color) {

    

}

void kernel_main(uint32_t magic_number, uint32_t mb_addr) {

    multiboot_info_t* mbi = (multiboot_info_t*) mb_addr;
    uint32_t* fb = mbi->framebuffer_addr;

    size_t count = 0;
    for (size_t i = 0; i < 1000000000; ++i)
        ++count;        

    for (size_t i = 0; i < HEIGHT * WIDTH; ++i) {
        *(fb + i) = 0xffff0000;
    }

}
