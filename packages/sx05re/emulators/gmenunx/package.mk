# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="gmenunx"
PKG_VERSION="19cb2fcdded8ac5f79634104c1788a499ea39ae6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/trngaje/GMenuNX-sdl2-ogs"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="gmenunx-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emuelec/mod"
PKG_SHORTDESC="GMenuNX is a fork of GMenu2X developed to Retrogame RS-97"
PKG_LONGDESC="GMenuNX is a fork of GMenu2X developed to Retrogame RS-97"
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

sed -i "s|CC = gcc|CC = $CC|" "$PKG_BUILD/Makefile.ogs"
sed -i "s|CXX = g++|CXX = $CXX|" "$PKG_BUILD/Makefile.ogs"
sed -i "s|STRIP = strip|STRIP = $STRIP|" "$PKG_BUILD/Makefile.ogs"

sed -i 's|-I"/usr/include"|'"-I$SYSROOT_PREFIX/usr/include|" "$PKG_BUILD/Makefile.ogs"
sed -i 's|LDFLAGS = -L"/usr/lib"|'"LDFLAGS = -L$SYSROOT_PREFIX/usr/lib|" "$PKG_BUILD/Makefile.ogs"

sed -i 's|`sdl2-config --cflags`|'"-I${SYSROOT_PREFIX}/usr/include/SDL2 -D_REENTRANT|" "$PKG_BUILD/Makefile.ogs"
sed -i "s|-lSDL | |" "$PKG_BUILD/Makefile.ogs"
sed -i "s|-lSDLmain | |" "$PKG_BUILD/Makefile.ogs"




make -f Makefile.ogs



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
cp $PKG_BUILD/objs/ogs/gmenu2x $INSTALL/usr/bin/

CFLAGS=$OLDCFLAGS
}
