#include "io.h"

uint16_t get_cursor() {

	uint16_t pos = 0;

	outb(0x3d4, 0xf);
	pos |= inb(0x3d5);

	outb(0x3d4, 0xe);
	pos |= (inb(0x3d5) << 8);

	return pos;

}

void set_cursor(uint16_t pos) {

	if (++pos >= MAX_ROWS * MAX_COLS) {
		//scroll_line();
	}

	outb(0x3d4, 0xf);
	outb(0x3d5, pos & 0xff);
	outb(0x3d4, 0xe);
	outb(0x3d5, (pos >> 8) & 0xff);

}

void putc_at(unsigned char c, unsigned short row, unsigned short column, unsigned char attribute) {

	if (row > MAX_ROWS || column > MAX_COLS)
		return;

	*((uint16_t*) VID_ADDR + (column + row * MAX_COLS) * 2) = attribute << 8 | c;

}

void putc_attr(unsigned char c, unsigned char attribute) {

	uint16_t pos = get_cursor();
	*((uint16_t*) VID_ADDR + pos) = attribute << 8 | c;	

}

void putc(unsigned char c) {

	putc_attr(c, DEFAULT_ATTR);

}

void putc_adv_cur(unsigned char c) {

	putc(c);	
	uint16_t pos = get_cursor();
	set_cursor(pos);
	
}

void puts(unsigned char* s) {

	uint16_t pos = get_cursor();

	while (*s != 0)
		*((uint16_t*) VID_ADDR + pos++) = DEFAULT_ATTR << 8 | *s++;

	set_cursor(pos - 1);

}

void putih(int p) {

	puts("0x");
	
	for (int i = 0; i < 8; ++i) {
	
		int c = (p >> (7 - i) * 4) & 0xf;
		putc_adv_cur(c + ((c < 10) ? 0x30 : 0x57));

	}

}
