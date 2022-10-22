unsigned char inb(unsigned short port) {

	unsigned char result;
	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
	
}

void outb(unsigned short port, unsigned char data) {

	__asm__("out %%al, %%dx" : : "a" (data), "d" (port));

}

unsigned short inw(unsigned short port) {

	unsigned short result;
	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return result;

}

void outw(unsigned short port, unsigned short data) {

	__asm("out %%ax, %%dx" : : "a" (data), "d" (port));

}

int read_addr(unsigned int addr) {

	int res;
	__asm__(
		"movl %1, %%esi			\n "
		"movl (%%esi), %%eax	\n "
		"movl %%eax, %0			\n "
		: "=r" (res)
		: "r" (addr)
		: "%eax", "%esi"	
	);

	return res;

}
