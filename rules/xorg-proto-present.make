# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_PROTO_PRESENT) += xorg-proto-present

#
# Paths and names
#
XORG_PROTO_PRESENT_VERSION	:= 1.0
XORG_PROTO_PRESENT_MD5		:= 2d569c75884455c7148d133d341e8fd6
XORG_PROTO_PRESENT		:= presentproto-$(XORG_PROTO_PRESENT_VERSION)
XORG_PROTO_PRESENT_SUFFIX	:= tar.bz2
XORG_PROTO_PRESENT_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_PRESENT).$(XORG_PROTO_PRESENT_SUFFIX))
XORG_PROTO_PRESENT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_PRESENT).$(XORG_PROTO_PRESENT_SUFFIX)
XORG_PROTO_PRESENT_DIR		:= $(BUILDDIR)/$(XORG_PROTO_PRESENT)
XORG_PROTO_PRESENT_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_PRESENT_CONF_TOOL	:= autoconf

# vim: syntax=make
