# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="attract"
PKG_VERSION="c6057a2072f94c1fb2544cd0b481e6b639dea493"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="ATTRACT"
PKG_SITE="https://github.com/trngaje/attract"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="attract-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain flac libogg libvorbis openal-soft libjpeg-turbo freetype systemd libgo2 sfml ${OPENGLES}"
PKG_SECTION="emuelec/mod"
PKG_SHORTDESC="Attract-Mode is a graphical frontend for command line emulators"
PKG_LONGDESC="Attract-Mode is a graphical frontend for command line emulators"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"
PKG_MAKE_OPTS_TARGET="USE_GLES=1 EXTRA_CFLAGS=-L${SYSROOT_PREFIX}/usr/lib"



pre_configure_target() {
#sed -i "s|CC=gcc|CC=/home/trngaje/develop/EmuELEC/build.EmuELEC-OdroidGoAdvance.aarch64-4.1/toolchain/bin/aarch64-libreelec-linux-gnueabi-gcc|" "$PKG_BUILD/Makefile"
#sed -i "s|CXX=g++|CXX=/home/trngaje/develop/EmuELEC/build.EmuELEC-OdroidGoAdvance.aarch64-4.1/toolchain/bin/aarch64-libreelec-linux-gnueabi-g++|" "$PKG_BUILD/Makefile"
#sed -i "s|STRIP=strip|STRIP=/home/trngaje/develop/EmuELEC/build.EmuELEC-OdroidGoAdvance.aarch64-4.1/toolchain/bin/aarch64-libreelec-linux-gnueabi-strip|" "$PKG_BUILD/Makefile 
sed -i "s|CC=gcc|CC=$CC|" "$PKG_BUILD/Makefile"
sed -i "s|CXX=g++|CXX=$CXX|" "$PKG_BUILD/Makefile"
sed -i "s|STRIP=strip|STRIP=$STRIP|" "$PKG_BUILD/Makefile" 
sed -i "s|-lGLESv1_CM|-lGLESv2|" "$PKG_BUILD/Makefile"
}

make_target() {
#sed -i "s|CC=gcc|CC=$CC|" "$PKG_BUILD/Makefile"
#sed -i "s|CXX=g++|CXX=$CXX|" "$PKG_BUILD/Makefile"
#sed -i "s|STRIP=strip|STRIP=$STRIP|" "$PKG_BUILD/Makefile" 
#sed -i "s|-lGLESv1_CM|-lGLESv2|" "$PKG_BUILD/Makefile"

echo "STRIP=$STRIP"
echo "CC=$CC"
echo "CXX=$CXX"

	make -j4 USE_GLES=1 EXTRA_CFLAGS="-L${SYSROOT_PREFIX}/usr/lib $CFLAGS"
}

makeinstall_target() {
 : not
}


post_make_target() {

echo "PKG_BUILD=$PKG_BUILD"
echo "TARGET_NAME=$TARGET_NAME"
echo "INSTALL=$INSTALL"

mkdir -p $INSTALL/usr/bin
cp $PKG_BUILD/attract $INSTALL/usr/bin/
#cp $PKG_DIR/bin/* $INSTALL/usr/bin/

#mkdir -p $INSTALL/usr/lib
#cp -P $PKG_DIR/lib/* $INSTALL/usr/lib/

#mkdir -p $INSTALL/usr/sbin
#cp -P $PKG_DIR/sbin/* $INSTALL/usr/sbin/

mkdir -p $INSTALL/usr/share/fonts/truetype
cp $PKG_DIR/font/* $INSTALL/usr/share/fonts/truetype/

mkdir -p $INSTALL/usr/share/attract
cp -r $PKG_DIR/tar/* $INSTALL/usr/share/attract

CFLAGS=$OLDCFLAGS
}

post_install() {
	enable_service attract.service
#	enable_service network-manager.service
#	mkdir -p $INSTALL/usr/share
#	ln -sf /storage/.config/emuelec/configs/locale $INSTALL/usr/share/locale
}
