ENTRY(boot)
/* OUTPUT_FORMAT("binary") */
OUTPUT_FORMAT("elf32-i386")

SECTIONS {
	. = 0x7c00;
	.boot :	{

		*(.data)	
		*(.boot)	

	}

  	. = 0x8000;
  	.kernel : AT(0x7e00) {
    
		*(.text)
  	
	}

  	kernel_sectors = (SIZEOF(.kernel) + 511) / 512;

	/DISCARD/ : {
        *(.eh_frame)
  	}
		
}
