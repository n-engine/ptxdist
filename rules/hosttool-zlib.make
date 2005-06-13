# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Paths and names 
#
HOSTTOOL_ZLIB_BUILDDIR	= $(HOSTTOOL_BUILDDIR)/$(ZLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-zlib_get: $(STATEDIR)/hosttool-zlib.get

$(STATEDIR)/hosttool-zlib.get: $(STATEDIR)/zlib.get
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-zlib_extract: $(STATEDIR)/hosttool-zlib.extract

$(STATEDIR)/hosttool-zlib.extract: $(STATEDIR)/hosttool-zlib.get
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_ZLIB_BUILDDIR))
	@$(call extract, $(ZLIB_SOURCE), $(HOSTTOOL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-zlib_prepare: $(STATEDIR)/hosttool-zlib.prepare

HOSTTOOL_ZLIB_AUTOCONF	=  --shared
HOSTTOOL_ZLIB_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)
HOSTTOOL_ZLIB_MAKEVARS	=  $(HOSTCC_ENV)

$(STATEDIR)/hosttool-zlib.prepare: $(STATEDIR)/hosttool-zlib.extract
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_ZLIB_BUILDDIR) && \
		./configure $(HOSTTOOL_ZLIB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-zlib_compile: $(STATEDIR)/hosttool-zlib.compile

$(STATEDIR)/hosttool-zlib.compile: $(STATEDIR)/hosttool-zlib.prepare 
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_ZLIB_BUILDDIR) && make $(HOSTTOOL_ZLIB_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-zlib_install: $(STATEDIR)/hosttool-zlib.install

$(STATEDIR)/hosttool-zlib.install: $(STATEDIR)/hosttool-zlib.compile
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_ZLIB_BUILDDIR) && make $(HOSTTOOL_ZLIB_MAKEVARS) install
	touch $@
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-zlib_targetinstall: $(STATEDIR)/hosttool-zlib.targetinstall

$(STATEDIR)/hosttool-zlib.targetinstall: $(STATEDIR)/hosttool-zlib.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-zlib_clean:
	rm -rf $(STATEDIR)/hosttool-zlib.*
	rm -rf $(HOSTTOOL_ZLIB_BUILDDIR)

# vim: syntax=make
