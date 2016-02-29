#!/bin/sh

do_octeon() {
	. /lib/octeon.sh

	octeon_board_detect
}

boot_hook_add preinit_main do_octeon
