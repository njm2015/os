#include "io.h"
#include "mp.h"
#include "low_level.h"

extern char proc_cnt;
extern char proc_lock;
extern void _unlock32(char* l_addr);
extern char needs_init;

void main() {

	putc_adv_cur(0x61 + proc_cnt++);
	_unlock32(&proc_lock);


	*((char*) 0xb8026) = 'w';
	if (is_bsp() && needs_init == 1) {

		needs_init = 0;
		*((char*) 0xb8024) = 'x';
		send_init_sipi_ipi(0x1);

		putc_adv_cur(0x62);

	}

	putc_adv_cur(0x63);

}
