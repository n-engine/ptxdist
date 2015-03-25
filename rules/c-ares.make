# -*-makefile-*-
#
# Copyright (C) 2014 Dr. Neuhaus Telekommunikation GmbH, Hamburg Germany, Oliver Graute <oliver.graute@neuhaus.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_C_ARES) += c-ares

#
# Paths and names
#
C_ARES_VERSION	:= 1.10.0
C_ARES_MD5	:= 1196067641411a75d3cbebe074fd36d8
C_ARES		:= c-ares-$(C_ARES_VERSION)
C_ARES_SUFFIX	:= tar.gz
C_ARES_URL	:= http://c-ares.haxx.se/download/$(C_ARES).$(C_ARES_SUFFIX)
C_ARES_SOURCE	:= $(SRCDIR)/$(C_ARES).$(C_ARES_SUFFIX)
C_ARES_DIR	:= $(BUILDDIR)/$(C_ARES)
C_ARES_LICENSE	:= MIT


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
C_ARES_CONF_TOOL      := autoconf
C_ARES_CONF_OPT              := \
 	$(CROSS_AUTOCONF_USR) \
 	--enable-nonblocking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/c-ares.targetinstall:
	@$(call targetinfo)

	@$(call install_init, c-ares)
	@$(call install_fixup, c-ares,PRIORITY,optional)
	@$(call install_fixup, c-ares,SECTION,base)
	@$(call install_fixup, c-ares,AUTHOR,"<oliver.graute@neuhaus.de>")
	@$(call install_fixup, c-ares,DESCRIPTION,missing)

	@$(call install_lib, c-ares, 0, 0, 0644, libcares)

	@$(call install_finish, c-ares)


	@$(call touch)

# vim: syntax=make
