# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="glutexto"
PKG_VERSION="1d62f750a0b2f047f460de84f19fcf2fce960bd8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/trngaje/glutexto-sdl2-ogs"
PKG_GIT_CLONE_BRANCH="sdl2_ogs"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="glutexto-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain sparrow3d"
PKG_SECTION="emuelec/mod"
PKG_SHORTDESC="Sparrow3D is an application framework with software renderer especially for open handhelds."
PKG_LONGDESC="Sparrow3D is an application framework with software renderer especially for open handhelds."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="manual"
#PKG_BUILD_FLAGS="+pic"

#PKG_CONFIGURE_OPTS_TARGET="CC=$CC CFLAGS='$CFLAGS' CPPFLAGS='$CXXFLAGS' CPP=$CXX LDFLAGS='$LDFLAGS'"
#PKG_CONFIGURE_SCRIPT="$PKG_BUILD"

#configure_package() {
#sed -i "s|build/main.mk|$PKG_BUILD/build/main.mk|" "$PKG_BUILD/configure"



#  cd $PKG_BUILD/unix
#  autoconf
  # now we know where we're building, assign a value
  #PKG_CONFIGURE_SCRIPT="$PKG_BUILD/unix"
  
  
#}


make_target() {
echo "STRIP=$STRIP"
echo "CC=$CC"
echo "CXX=$CXX"
echo "CFLAGS=$CFLAGS"
echo "CXXFLAGS=$CXXFLAGS"
echo "LDFLAGS=$LDFLAGS"


cd $PKG_BUILD

sed -i 's|SDL = `sdl2-config --cflags`|'"SDL = -I${SYSROOT_PREFIX}/usr/include/SDL2 -D_REENTRANT|" "$PKG_BUILD/Makefile.ogs"
sed -i "s|-I/usr/include/SDL2|-I${SYSROOT_PREFIX}/usr/include/SDL2|" "$PKG_BUILD/Makefile.ogs"
sed -i 's|SPARROW_LIB = $(SPARROW_FOLDER)|'"SPARROW_LIB = ${SYSROOT_PREFIX}/usr/lib|" "$PKG_BUILD/Makefile.ogs"
sed -i 's|INCLUDE += -I$(SPARROW_FOLDER)|'"INCLUDE += -I${SYSROOT_PREFIX}/usr/include|" "$PKG_BUILD/Makefile.ogs"




make -f Makefile.ogs
$STRIP glutexto



#	make
}

makeinstall_target() {
 : not
}


post_make_target() {

echo "PKG_BUILD=$PKG_BUILD"
echo "TARGET_NAME=$TARGET_NAME"
echo "INSTALL=$INSTALL"

mkdir -p $INSTALL/usr/bin
cp $PKG_BUILD/glutexto $INSTALL/usr/bin/

CFLAGS=$OLDCFLAGS
}
