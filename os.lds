ENTRY(boot)
OUTPUT_FORMAT("binary")
/*OUTPUT_FORMAT("elf32-i386")*/

SECTIONS {
	. = 0x7c00;
	.boot :	{

		*(.data)	
		*(.boot)	

	}

  	. = 0x1000;
  	.kernel : AT(0x7e00) {
    
		*(.text)
        *(.rodata)
  	
	}

  	kernel_sectors = (SIZEOF(.kernel) + 511) / 512;

    . = 0x4000;
    .ap_init : AT(0x7e00 + (kernel_sectors * 512)) {

        *(.text)
        . = ALIGN(512);
    }

    ap_init_sectors = (SIZEOF(.ap_init) + 511) / 512;

	/DISCARD/ : {
        *(.eh_frame)
  	}
		
}
