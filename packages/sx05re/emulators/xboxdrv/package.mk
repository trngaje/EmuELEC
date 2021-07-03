# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="xboxdrv"
PKG_VERSION="c3cf3fe53df2b93b8780146c4693ead68373b052"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/zerojay/xboxdrv"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="xboxdrv-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libX11 dbus dbus-glib glib"
PKG_SECTION="emuelec/mod"
PKG_SHORTDESC="Xboxdrv is a Xbox/Xbox360 gamepad driver for Linux that works in userspace. "
PKG_LONGDESC="Xboxdrv is a Xbox/Xbox360 gamepad driver for Linux that works in userspace. "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="manual"


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
cd $PKG_BUILD

echo "STRIP = $STRIP"
echo "CC = $CC" 
echo "CXX = $CXX" 
echo "CCFLAGS = $CFLAGS" 
echo "CXXFLAGS = $CXXFLAGS" 
echo "LINKFLAGS = $LDFLAGS" 

#export CC=$CC
#export CXX=$CXX



#sed -i 's|SDL = `sdl2-config --cflags`|'"SDL = -I${SYSROOT_PREFIX}/usr/include/SDL2 -D_REENTRANT|" "$PKG_BUILD/Makefile.ogs"
#sed -i "s|-I/usr/include/SDL2|-I${SYSROOT_PREFIX}/usr/include/SDL2|" "$PKG_BUILD/Makefile.ogs"
#sed -i 's|SPARROW_LIB = $(SPARROW_FOLDER)|'"SPARROW_LIB = ${SYSROOT_PREFIX}/usr/lib|" "$PKG_BUILD/Makefile.ogs"
#sed -i 's|INCLUDE += -I$(SPARROW_FOLDER)|'"INCLUDE += -I${SYSROOT_PREFIX}/usr/include|" "$PKG_BUILD/Makefile.ogs"

sed -i "s|print target|print(target)|" "$PKG_BUILD/SConstruct"
sed -i "s|print source|print(source)|" "$PKG_BUILD/SConstruct"
sed -i 's|print "g++ must be installed!"|print("g++ must be installed!")|' "$PKG_BUILD/SConstruct"
sed -i "s|print 'libx11-dev must be installed!'|print('libx11-dev must be installed!')|" "$PKG_BUILD/SConstruct"
sed -i "s|if not conf.CheckLibWithHeader('X11', 'X11/Xlib.h', 'C++'):|if False:|" "$PKG_BUILD/SConstruct"
sed -i "s|string.maketrans|str.maketrans|" "$PKG_BUILD/SConstruct"
sed -i "s|ord(c)|c|" "$PKG_BUILD/SConstruct"
sed -i "s|xrange|range|" "$PKG_BUILD/SConstruct"
sed -i "s|, xml)|, xml.decode('ascii'))|" "$PKG_BUILD/SConstruct"
sed -i "s#| sed 's/-I/-isystem/g'# #" "$PKG_BUILD/SConstruct"
sed -i 's/\x0C//g' "$PKG_BUILD/src/evdev_helper.cpp"
sed -i "s|'-g', ||" "$PKG_BUILD/SConstruct"

scons CXX="$CXX" CXXFLAGS="$CXXFLAGS -I${SYSROOT_PREFIX}/usr/include" LIBPATH="${SYSROOT_PREFIX}/usr/lib" LINKFLAGS="$LDFLAGS -lgio-2.0" LIBDIRPREFIX="${SYSROOT_PREFIX}/usr/lib" LIBS="X11"

$STRIP xboxdrv

}

makeinstall_target() {
 : not
}


post_make_target() {

echo "PKG_BUILD=$PKG_BUILD"
echo "TARGET_NAME=$TARGET_NAME"
echo "INSTALL=$INSTALL"

mkdir -p $INSTALL/usr/bin
cp $PKG_BUILD/xboxdrv $INSTALL/usr/bin/

CFLAGS=$OLDCFLAGS
}
