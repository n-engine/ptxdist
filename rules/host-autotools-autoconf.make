# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
LAZY_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_AUTOCONF) += host-autotools-autoconf

#
# Paths and names
#
HOST_AUTOTOOLS_AUTOCONF_VERSION	:= 2.69
HOST_AUTOTOOLS_AUTOCONF_MD5	:= 50f97f4159805e374639a73e2636f22e
HOST_AUTOTOOLS_AUTOCONF		:= autoconf-$(HOST_AUTOTOOLS_AUTOCONF_VERSION)
HOST_AUTOTOOLS_AUTOCONF_SUFFIX	:= tar.xz
HOST_AUTOTOOLS_AUTOCONF_URL	:= $(call ptx/mirror, GNU, autoconf/$(HOST_AUTOTOOLS_AUTOCONF).$(HOST_AUTOTOOLS_AUTOCONF_SUFFIX))
HOST_AUTOTOOLS_AUTOCONF_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_AUTOCONF).$(HOST_AUTOTOOLS_AUTOCONF_SUFFIX)
HOST_AUTOTOOLS_AUTOCONF_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_AUTOCONF)
HOST_AUTOTOOLS_AUTOCONF_DEVPKG	:= NO

$(STATEDIR)/autogen-tools: $(STATEDIR)/host-autotools-autoconf.install.post

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_AUTOTOOLS_AUTOCONF_CONF_TOOL	:= autoconf

# vim: syntax=make
