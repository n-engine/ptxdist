# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FAKEROOT) += host-fakeroot

#
# Paths and names
#
HOST_FAKEROOT_VERSION	:= 1.5.10
HOST_FAKEROOT		:= fakeroot-$(HOST_FAKEROOT_VERSION)
HOST_FAKEROOT_SUFFIX	:= tar.gz
HOST_FAKEROOT_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/fakeroot_$(HOST_FAKEROOT_VERSION).$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_SOURCE	:= $(SRCDIR)/fakeroot_$(HOST_FAKEROOT_VERSION).$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_DIR	:= $(HOST_BUILDDIR)/$(HOST_FAKEROOT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_FAKEROOT_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_FAKEROOT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FAKEROOT_PATH	:= PATH=$(HOST_PATH)
HOST_FAKEROOT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_FAKEROOT_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--without-po4a

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-fakeroot_clean:
	rm -rf $(STATEDIR)/host-fakeroot.*
	rm -rf $(HOST_FAKEROOT_DIR)

# vim: syntax=make
