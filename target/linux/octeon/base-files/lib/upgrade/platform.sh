#
# Copyright (C) 2010 OpenWrt.org
#

. /lib/octeon.sh

platform_do_upgrade() {
	local board=$(octeon_board_name)

	case "$board" in
	wa6x3xn)
		local tar_file="$1"
		local kernel_length=`(tar zxf $tar_file wa6x3xn/vmlinux.64.lzma -O | wc -c) 2> /dev/null`
		local rootfs_length=`(tar zxf $tar_file wa6x3xn/CaviumFus-squashfs -O | wc -c) 2> /dev/null`

		tar zxf $tar_file -C /tmp
		mtd write /tmp/wa6x3xn/vmlinux.64.lzma uImageA
		mtd write /tmp/wa6x3xn/vmlinux.64.lzma uImageB
		mtd write /tmp/wa6x3xn/CaviumFus-squashfs rootfsA
		mtd write /tmp/wa6x3xn/CaviumFus-squashfs rootfsB
		return 0
		;;
	esac

	return 1
	
}

platform_check_image() {
	local board=$(octeon_board_name)

	case "$board" in
	wa6x3xn)
		local tar_file="$1"
		local kernel_length=`(tar zxf $tar_file wa6x3xn/vmlinux.64.lzma -O | wc -c) 2> /dev/null`
		local rootfs_length=`(tar zxf $tar_file wa6x3xn/CaviumFus-squashfs -O | wc -c) 2> /dev/null`
		[ "$kernel_length" = 0 -o "$rootfs_length" = 0 ] && {
			echo "The upgarde image is corrupt."
			return 1
		}
		return 0
		;;
	esac

	echo "Sysupgrade is not yet supported on $board."
	return 1
}
