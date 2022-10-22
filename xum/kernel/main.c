#include "io.h"
#include "mp.h"
#include "low_level.h"

extern char proc_cnt;
extern char proc_lock;
extern void _lock32(char* l_addr);
extern void _unlock32(char* l_addr);
extern char needs_init;
char print_lock;

void main() {

	_lock32(&print_lock);
	putc_adv_cur(0x61 + proc_cnt++);
	//_unlock32(&print_lock);

	_unlock32(&proc_lock);


	*((char*) 0xb8026) = 'w';
	if (is_bsp() && needs_init == 1) {

		needs_init = 0;
		*((char*) 0xb8024) = 'x';
		send_init_sipi_ipi(0x1);

		_lock32(&print_lock);
		putc_adv_cur(0x62);
		_unlock32(&print_lock);

	}

	_lock32(&print_lock);
	putc_adv_cur(0x63);
	_unlock32(&print_lock);

	while (true) {}

}
