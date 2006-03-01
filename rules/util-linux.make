# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTIL-LINUX) += util-linux

#
# Paths and names
#
UTIL-LINUX_VERSION	= 2.12j
UTIL-LINUX		= util-linux-$(UTIL-LINUX_VERSION)
UTIL-LINUX_SUFFIX	= tar.gz
UTIL-LINUX_URL		= http://ftp.cwi.nl/aeb/util-linux/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTIL-LINUX_SOURCE	= $(SRCDIR)/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTIL-LINUX_DIR		= $(BUILDDIR)/$(UTIL-LINUX)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

util-linux_get: $(STATEDIR)/util-linux.get

$(STATEDIR)/util-linux.get: $(util-linux_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(UTIL-LINUX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(UTIL-LINUX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

util-linux_extract: $(STATEDIR)/util-linux.extract

$(STATEDIR)/util-linux.extract: $(util-linux_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL-LINUX_DIR))
	@$(call extract, $(UTIL-LINUX_SOURCE))
	@$(call patchin, $(UTIL-LINUX))

	perl -i -p -e 's/^CPU=.*$$/CPU=$(PTXCONF_ARCH)/g' $(UTIL-LINUX_DIR)/MCONFIG
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

util-linux_prepare: $(STATEDIR)/util-linux.prepare

UTIL-LINUX_PATH	=  PATH=$(CROSS_PATH)
UTIL-LINUX_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/util-linux.prepare: $(util-linux_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(UTIL-LINUX_DIR) && \
		$(UTIL-LINUX_PATH) $(UTIL-LINUX_ENV) \
		./configure
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

util-linux_compile: $(STATEDIR)/util-linux.compile

$(STATEDIR)/util-linux.compile: $(util-linux_compile_deps_default)
	@$(call targetinfo, $@)

	cd $(UTIL-LINUX_DIR)/lib && $(UTIL-LINUX_PATH) make all
ifdef PTXCONF_UTIL-LINUX_MKSWAP
	cd $(UTIL-LINUX_DIR)/disk-utils && $(UTIL-LINUX_PATH) make mkswap
endif
ifdef PTXCONF_UTIL-LINUX_SWAPON
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make swapon
endif
ifdef PTXCONF_UTIL-LINUX_MOUNT
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make mount
endif
ifdef PTXCONF_UTIL-LINUX_UMOUNT
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make umount
endif
ifdef PTXCONF_UTIL-LINUX_IPCS
	cd $(UTIL-LINUX_DIR)/sys-utils && $(UTIL-LINUX_PATH) make ipcs
endif
ifdef PTXCONF_UTIL-LINUX_READPROFILE
	cd $(UTIL-LINUX_DIR)/sys-utils && $(UTIL-LINUX_PATH) make readprofile
endif
ifdef PTXCONF_UTIL-LINUX_FDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make fdisk
endif
ifdef PTXCONF_UTIL-LINUX_SFDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make sfdisk
endif
ifdef PTXCONF_UTIL-LINUX_CFDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make cfdisk
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

util-linux_install: $(STATEDIR)/util-linux.install

$(STATEDIR)/util-linux.install: $(util-linux_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

util-linux_targetinstall: $(STATEDIR)/util-linux.targetinstall

$(STATEDIR)/util-linux.targetinstall: $(util-linux_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, util-linux)
	@$(call install_fixup, util-linux,PACKAGE,util-linux)
	@$(call install_fixup, util-linux,PRIORITY,optional)
	@$(call install_fixup, util-linux,VERSION,$(UTIL-LINUX_VERSION))
	@$(call install_fixup, util-linux,SECTION,base)
	@$(call install_fixup, util-linux,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, util-linux,DEPENDS,)
	@$(call install_fixup, util-linux,DESCRIPTION,missing)

ifdef PTXCONF_UTIL-LINUX_MKSWAP
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/disk-utils/mkswap, /sbin/mkswap)
endif
ifdef PTXCONF_UTIL-LINUX_SWAPON
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/mount/swapon, /sbin/swapon)
endif
ifdef PTXCONF_UTIL-LINUX_MOUNT
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/mount/mount, /sbin/mount)
endif
ifdef PTXCONF_UTIL-LINUX_UMOUNT
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/mount/umount, /sbin/umount)
endif
ifdef PTXCONF_UTIL-LINUX_IPCS
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/sys-utils/ipcs, /usr/bin/ipcs)
endif
ifdef PTXCONF_UTIL-LINUX_READPROFILE
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/sys-utils/readprofile, /usr/sbin/readprofile)
endif
ifdef PTXCONF_UTIL-LINUX_FDISK
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/fdisk, /usr/sbin/fdisk)
endif
ifdef PTXCONF_UTIL-LINUX_SFDISK
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/sfdisk, /usr/sbin/sfdisk)
endif
ifdef PTXCONF_UTIL-LINUX_CFDISK
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/cfdisk, /usr/sbin/cfdisk)
endif
	@$(call install_finish, util-linux)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

util-linux_clean:
	rm -rf $(STATEDIR)/util-linux.*
	rm -rf $(IMAGEDIR)/util-linux_*
	rm -rf $(UTIL-LINUX_DIR)

# vim: syntax=make
