PTXCONF_PLATFORM		:= $(call remove_quotes, $(PTXCONF_PLATFORM))
PTXCONF_GNU_TARGET		:= $(call remove_quotes, $(PTXCONF_GNU_TARGET))
PTXCONF_COMPILER_PREFIX		:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX))

PTXCONF_SYSROOT_TARGET		:= $(call remove_quotes, $(PTXCONF_SYSROOT_TARGET))
PTXCONF_SYSROOT_HOST		:= $(call remove_quotes, $(PTXCONF_SYSROOT_HOST))
PTXCONF_SYSROOT_CROSS		:= $(call remove_quotes, $(PTXCONF_SYSROOT_CROSS))

PTX_COMPILER_PREFIX		:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX))
PTX_COMPILER_PREFIX_KERNEL	:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_KERNEL))
PTX_COMPILER_PREFIX_UBOOT	:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_UBOOT))
