# -*-sh-*-
RULESDIR=${PTXDIST_TOPDIR}/rules
SCRIPTSDIR=${PTXDIST_TOPDIR}/scripts
PTXDIST_LIB_DIR=${SCRIPTSDIR}/lib
PTX_MIGRATEDIR=${SCRIPTSDIR}/migrate

# created dirs during build
BUILDDIR=${PTXDIST_PLATFORMDIR}/build-target
KLIBC_BUILDDIR=${PTXDIST_PLATFORMDIR}/build-klibc-target
CROSS_BUILDDIR=${PTXDIST_PLATFORMDIR}/build-cross
HOST_BUILDDIR=${PTXDIST_PLATFORMDIR}/build-host
PKGDIR=${PTXDIST_PLATFORMDIR}/packages
STATEDIR=${PTXDIST_PLATFORMDIR}/state
IMAGEDIR=${PTXDIST_PLATFORMDIR}/images
ROOTDIR=${PTXDIST_PLATFORMDIR}/root
ROOTDIR_DEBUG=${PTXDIST_PLATFORMDIR}/root-debug

# we put generated config files here
PTXDIST_GEN_CONFIG_DIR=${STATEDIR}/config

# generated files by "dgen"
PTX_DGEN_DEPS_PRE=${STATEDIR}/ptx_dgen_deps.pre
PTX_DGEN_DEPS_POST=${STATEDIR}/ptx_dgen_deps.post
PTX_DGEN_RULESFILES_MAKE=${STATEDIR}/ptx_dgen_rulesfiles.make

PTX_MAP_ALL=${STATEDIR}/ptx_map_all.sh
PTX_MAP_ALL_MAKE=${PTX_MAP_ALL}.make
PTX_MAP_DEPS=${STATEDIR}/ptx_map_deps.sh
