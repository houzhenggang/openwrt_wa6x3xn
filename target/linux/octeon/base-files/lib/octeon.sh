#!/bin/sh
#
# Copyright (C) 2010-2013 OpenWrt.org
#

OCTEON_BOARD_NAME=
OCTEON_MODEL=

octeon_board_detect() {
	local machine
	local gobomips
	local name

	machine=$(grep "^system type" /proc/cpuinfo | sed "s/system type.*: \(.*\)/\1/g")
	bogomips=$(grep "^BogoMIPS" /proc/cpuinfo | sed "s/BogoMIPS.*: \(.*\)/\1/g")

	case "$machine" in
	"CN3010_EVB_HS5"*)
		name="wa6x3xn"
		;;
	*)
		name="generic"
		;;
	esac

	[ -z "$OCTEON_BOARD_NAME" ] && OCTEON_BOARD_NAME="$name"

	[ -z "$OCTEON_MODEL" ] && OCTEON_MODEL="HuaWei WA603DN"
	[ "$bogomips" = "600.00" ] && OCTEON_MODEL="HuaWei WA633SN"

	[ -e "/tmp/sysinfo/" ] || mkdir -p "/tmp/sysinfo/"

	echo "$OCTEON_BOARD_NAME" > /tmp/sysinfo/board_name
	echo "$OCTEON_MODEL" > /tmp/sysinfo/model
}

octeon_board_name() {
	local name

	[ -f /tmp/sysinfo/board_name ] || octeon_board_detect
	[ -f /tmp/sysinfo/board_name ] && name=$(cat /tmp/sysinfo/board_name)
	[ -z "$name" ] && name="unknown"

	echo "$name"
}
