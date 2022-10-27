#include "io.h"
#include "mp.h"
#include "low_level.h"

extern char proc_cnt;
extern char proc_lock;
extern void _lock32(char* l_addr);
extern void _unlock32(char* l_addr);
extern char needs_init;
extern char print_lock;

void main() {

	char proc_num = proc_cnt;

	++proc_cnt;
	_unlock32(&proc_lock);

	if (is_bsp() && needs_init == 1) {
		
		needs_init = 0;
		send_init_sipi_ipi(0x1);

	} else {


	}

	_lock32(&print_lock);
	putc_adv_cur(0x30 + proc_num);
	_unlock32(&print_lock);

	while (true) {}

}
