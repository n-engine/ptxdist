# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Daniel Schnell
#		2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIGHTTPD) += lighttpd

#
# Paths and names
#
LIGHTTPD_VERSION	:= 1.4.20
LIGHTTPD		:= lighttpd-$(LIGHTTPD_VERSION)
LIGHTTPD_SUFFIX		:= tar.bz2
LIGHTTPD_URL		:= http://www.lighttpd.net/download/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_SOURCE		:= $(SRCDIR)/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_DIR		:= $(BUILDDIR)/$(LIGHTTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIGHTTPD_SOURCE):
	@$(call targetinfo)
	@$(call get, LIGHTTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIGHTTPD_PATH	:= PATH=$(CROSS_PATH)
LIGHTTPD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIGHTTPD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-valgrind \
	--prefix=/usr

ifdef PTXCONF_LIGHTTPD__ZLIB
LIGHTTPD_AUTOCONF += --with-zlib=$(SYSROOT)/usr
else
LIGHTTPD_AUTOCONF += --without-zlib
endif

ifdef PTXCONF_LIGHTTPD__BZLIB
LIGHTTPD_AUTOCONF += --with-bzip2=FIXME
else
LIGHTTPD_AUTOCONF += --without-bzip2
endif

ifdef PTXCONF_LIGHTTPD__LFS
LIGHTTPD_AUTOCONF += --enable-lfs
else
LIGHTTPD_AUTOCONF += --disable-lfs
endif

ifdef PTXCONF_LIGHTTPD__IPV6
LIGHTTPD_AUTOCONF += --enable-ipv6
else
LIGHTTPD_AUTOCONF += --disable-ipv6
endif

ifdef PTXCONF_LIGHTTPD__MYSQL
LIGHTTPD_AUTOCONF += --with-mysql=FIXME
else
LIGHTTPD_AUTOCONF += --without-mysql
endif

ifdef PTXCONF_LIGHTTPD__LDAP
LIGHTTPD_AUTOCONF += --with-ldap=FIXME
else
LIGHTTPD_AUTOCONF += --without-ldap
endif

ifdef PTXCONF_LIGHTTPD__ATTR
LIGHTTPD_AUTOCONF += --with-attr=FIXME
else
LIGHTTPD_AUTOCONF += --without-attr
endif

ifdef PTXCONF_LIGHTTPD__OPENSSL
LIGHTTPD_AUTOCONF += --with-openssl=FIXME
# --with-openssl-includes=DIR OpenSSL includes
# --with-openssl-libs=DIR OpenSSL libraries
else
LIGHTTPD_AUTOCONF += --without-openssl
endif

ifdef PTXCONF_LIGHTTPD__KERBEROS
LIGHTTPD_AUTOCONF += --with-kerberos=FIXME
else
LIGHTTPD_AUTOCONF += --without-kerberos
endif

ifdef PTXCONF_LIGHTTPD__PCRE
LIGHTTPD_AUTOCONF += --with-pcre
else
LIGHTTPD_AUTOCONF += --without-pcre
endif

ifdef PTXCONF_LIGHTTPD__FAM
LIGHTTPD_AUTOCONF += --with-fam=FIXME
else
LIGHTTPD_AUTOCONF += --without-fam
endif

ifdef PTXCONF_LIGHTTPD__WEBDAV_PROPS
LIGHTTPD_AUTOCONF += --with-webdav-props=FIXME
else
LIGHTTPD_AUTOCONF += --without-webdav-props
endif

ifdef PTXCONF_LIGHTTPD__WEBDAV_LOCKS
LIGHTTPD_AUTOCONF += --with-webdav-locks=FIXME
else
LIGHTTPD_AUTOCONF += --without-webdav-locks
endif

ifdef PTXCONF_LIGHTTPD__GDBM
LIGHTTPD_AUTOCONF += --with-gdbm=FIXME
else
LIGHTTPD_AUTOCONF += --without-gdbm
endif

ifdef PTXCONF_LIGHTTPD__MEMCACHE
LIGHTTPD_AUTOCONF += --with-memcache=FIXME
else
LIGHTTPD_AUTOCONF += --without-memcache
endif

ifdef PTXCONF_LIGHTTPD__LUA
LIGHTTPD_AUTOCONF += --with-lua=FIXME
else
LIGHTTPD_AUTOCONF += --without-lua
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lighttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lighttpd)
	@$(call install_fixup, lighttpd,PACKAGE,lighttpd)
	@$(call install_fixup, lighttpd,PRIORITY,optional)
	@$(call install_fixup, lighttpd,VERSION,$(LIGHTTPD_VERSION))
	@$(call install_fixup, lighttpd,SECTION,base)
	@$(call install_fixup, lighttpd,AUTHOR,"Daniel Schnell <danielsch\@marel.com>")
	@$(call install_fixup, lighttpd,DEPENDS,)
	@$(call install_fixup, lighttpd,DESCRIPTION,missing)

	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/lighttpd, \
		/usr/sbin/lighttpd)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/lighttpd-angel, \
		/usr/sbin/lighttpd-angel)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/spawn-fcgi, \
		/usr/bin/spawn-fcgi)

	@cd $(LIGHTTPD_DIR)/src/.libs && \
	find . \
		-name "*.so" | \
		while read file; do \
		$(call install_copy, lighttpd, 0, 0, 0644, \
			$(LIGHTTPD_DIR)/src/.libs/$$file, \
			/usr/lib/$${file##*/} \
		) \
	done

#	#
#	# config
#	#
	@$(call install_alternative, lighttpd, 0, 0, 0644, /etc/lighttpd/lighttpd.conf, n)
#	# FIXME: withoug PTXCONF_PHP5_SAPI_CGI, we want to install
#	# $(PTXDIST_TOPDIR)/generic/etc/lighttpd/lighttpd-no_php.conf instead?

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_LIGHTTPD_STARTSCRIPT
	@$(call install_alternative, lighttpd, 0, 0, 0755, /etc/init.d/lighttpd, n)
endif
endif

ifdef PTXCONF_PHP5_SAPI_CGI
	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/lighttpd/mod_fastcgi.conf, \
		/etc/lighttpd/mod_fastcgi.conf, n)
endif

ifdef PTXCONF_LIGHTTPD__GENERIC_SITE
ifdef PTXCONF_PHP5_SAPI_CGI
	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/lighttpd.html, \
		/var/www/index.html, n)

	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/bottles.php, \
		/var/www/bottles.php, n)

	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/more_bottles.php, \
		/var/www/more_bottles.php, n)
else
	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/httpd.html, \
		/var/www/index.html, n)
endif
endif

	@$(call install_finish, lighttpd)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lighttpd_clean:
	rm -rf $(STATEDIR)/lighttpd.*
	rm -rf $(PKGDIR)/lighttpd_*
	rm -rf $(LIGHTTPD_DIR)

# vim: syntax=make
