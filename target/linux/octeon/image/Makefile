#
# Copyright (C) 2009-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Image/BuildKernel
	# Workaround pre-SDK-1.9.0 u-boot versions not handling the .notes section
	$(TARGET_CROSS)strip -R .notes $(KDIR)/vmlinux.elf -o $(KDIR)/vmlinux.64
	$(STAGING_DIR_HOST)/bin/lzma e $(KDIR)/vmlinux.64 $(KDIR)/vmlinux.64.lzma
	dd if=$(KDIR)/vmlinux.64.lzma of=$(BIN_DIR)/vmlinux.64.lzma bs=65536 conv=sync
endef

define Image/Build/squashfs
    $(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
endef

define Image/Build
	$(call Image/Build/$(1))
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/CaviumFus-squashfs bs=128k conv=sync
endef

$(eval $(call BuildImage))
