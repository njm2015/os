#ifndef DRIVER_DISPLAY_H
#define DRIVER_DISPLAY_H

#include "low_level.h"
#include "fixed_width.h"

#define VID_ADDR 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define DEFAULT_ATTR 0xf

#define DISP_BLACK 0
#define DISP_BLUE 1
#define DISP_GREEN 2
#define DISP_CYAN 3
#define DISP_RED 4
#define DISP_MAGENTA 5
#define DISP_BROWN 6
#define color_light(dark_color) (dark_color | 0x8)

uint16_t get_cursor();
void set_cursor(uint16_t pos);
void putc_at(unsigned char c, unsigned short row, unsigned short column, unsigned char attribute);
void putc_attr(unsigned char c, unsigned char attribute);
void putc(unsigned char c);
void putc_adv_cur(unsigned char c);
void puts(unsigned char* s);
void putih(int p);

#endif
