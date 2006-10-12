# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_PELTS) += host-pelts

#
# Paths and names
#
HOST_PELTS_VERSION	:= 1.0.6
HOST_PELTS		:= pelts-$(HOST_PELTS_VERSION)
HOST_PELTS_SUFFIX	:= tar.bz2
HOST_PELTS_URL		:= http://www.pengutronix.de/software/pelts/download/v1/$(HOST_PELTS).$(HOST_PELTS_SUFFIX)
HOST_PELTS_SOURCE	:= $(SRCDIR)/$(HOST_PELTS).$(HOST_PELTS_SUFFIX)
HOST_PELTS_DIR		:= $(HOST_BUILDDIR)/$(HOST_PELTS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-pelts_get: $(STATEDIR)/host-pelts.get

$(STATEDIR)/host-pelts.get: $(host-pelts_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_PELTS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_PELTS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-pelts_extract: $(STATEDIR)/host-pelts.extract

$(STATEDIR)/host-pelts.extract: $(host-pelts_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PELTS_DIR))
	@$(call extract, HOST_PELTS, $(HOST_BUILDDIR))
	@$(call patchin, HOST_PELTS, $(HOST_PELTS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-pelts_prepare: $(STATEDIR)/host-pelts.prepare

HOST_PELTS_PATH	:= PATH=$(HOST_PATH)
HOST_PELTS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PELTS_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-pelts.prepare: $(host-pelts_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PELTS_DIR)/config.cache)
	cd $(HOST_PELTS_DIR) && \
		$(HOST_PELTS_PATH) $(HOST_PELTS_ENV) \
		./configure $(HOST_PELTS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-pelts_compile: $(STATEDIR)/host-pelts.compile


$(STATEDIR)/host-pelts.compile: $(host-pelts_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_PELTS_DIR) && $(HOST_PELTS_ENV) $(HOST_PELTS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-pelts_install: $(STATEDIR)/host-pelts.install

$(STATEDIR)/host-pelts.install: $(host-pelts_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_PELTS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-pelts_clean:
	rm -rf $(STATEDIR)/host-pelts.*
	rm -rf $(HOST_PELTS_DIR)

# vim: syntax=make
