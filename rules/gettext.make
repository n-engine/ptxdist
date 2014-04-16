# -*-makefile-*-
#
# Copyright (C) 2003-2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GETTEXT) += gettext

#
# Paths and names
#
GETTEXT_VERSION	:= 0.18.3.2
GETTEXT_MD5	:= 241aba309d07aa428252c74b40a818ef
GETTEXT		:= gettext-$(GETTEXT_VERSION)
GETTEXT_SUFFIX	:= tar.gz
GETTEXT_URL	:= $(call ptx/mirror, GNU, gettext/$(GETTEXT).$(GETTEXT_SUFFIX))
GETTEXT_SOURCE	:= $(SRCDIR)/$(GETTEXT).$(GETTEXT_SUFFIX)
GETTEXT_DIR	:= $(BUILDDIR)/$(GETTEXT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GETTEXT_PATH	:= PATH=$(CROSS_PATH)
GETTEXT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GETTEXT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-java \
	--disable-native-java \
	--disable-csharp \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--enable-static \
	--disable-nls \
	--disable-rpath \
	--disable-c++ \
	--disable-relocatable \
	--enable-libasprintf \
	--disable-openmp \
	--disable-acl \
	--disable-curses \
	--without-emacs \
	--without-bzip2 \
	--without-xz

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gettext)
	@$(call install_fixup, gettext,PRIORITY,optional)
	@$(call install_fixup, gettext,SECTION,base)
	@$(call install_fixup, gettext,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gettext,DESCRIPTION,missing)

	@$(call install_copy, gettext, 0, 0, 0755, -, /usr/bin/xgettext)
	@$(call install_copy, gettext, 0, 0, 0755, -, /usr/bin/gettext)

	@$(call install_copy, gettext, 0, 0, 0644, -, /usr/lib/libgettextlib-0.18.3.so)
	@$(call install_copy, gettext, 0, 0, 0644, -, /usr/lib/libasprintf.so.0.0.0)
	@$(call install_copy, gettext, 0, 0, 0644, -, /usr/lib/libgettextpo.so.0.5.2)
	@$(call install_copy, gettext, 0, 0, 0644, -, /usr/lib/libgettextsrc-0.18.3.so)

	@$(call install_finish, gettext)

	@$(call touch)

# vim: syntax=make
