# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="advancemame"
PKG_VERSION="e526141fcbee615c8e4020f37d17625fb71b9df3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/trngaje/advancemame"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="advancemame-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain freetype slang alsa"
PKG_SECTION="emuelec/mod"
PKG_SHORTDESC="A MAME and MESS port with an advanced video support for Arcade Monitors, TVs, and PC Monitors "
PKG_LONGDESC="A MAME and MESS port with an advanced video support for Arcade Monitors, TVs, and PC Monitors "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

pre_configure_target() {
export CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O3|g"`
sed -i "s|#include <slang.h>|#include <$SYSROOT_PREFIX/usr/include/slang.h>|" $PKG_BUILD/configure.ac
}

pre_make_target() {
VERSION="EmuELEC-v$(cat $ROOT/packages/sx05re/emuelec/config/EE_VERSION)-${PKG_VERSION:0:7}"
echo $VERSION > $PKG_BUILD/.version
}

make_target() {
echo "STRIP = $STRIP"
echo "CC = $CC"
echo "CXX = $CXX"
echo "CCFLAGS = $CFLAGS"
echo "CXXFLAGS = $CXXFLAGS"
echo "LINKFLAGS = $LDFLAGS"

cd $PKG_BUILD
./autogen.sh
./configure --prefix=/usr --datadir=/usr/share/ --datarootdir=/usr/share/ --host=${TARGET_NAME} --enable-fb --enable-freetype --with-freetype-prefix=$SYSROOT_PREFIX/usr/ --enable-slang
make mame
}

makeinstall_target() {
mkdir -p $INSTALL/usr/share/advance
if [ "$DEVICE" == "OdroidGoAdvance" ]; then
   cp -r $PKG_DIR/config/advmame.rc_oga $INSTALL/usr/share/advance/advmame.rc
elif [ "$DEVICE" == "GameForce" ]; then
   cp -r $PKG_DIR/config/advmame.rc_gf $INSTALL/usr/share/advance/advmame.rc
else
   cp -r $PKG_DIR/config/advmame.rc $INSTALL/usr/share/advance/advmame.rc
fi
   
mkdir -p $INSTALL/usr/bin
   cp -r $PKG_DIR/bin/* $INSTALL/usr/bin
chmod +x $INSTALL/usr/bin/advmame.sh

cp -r $PKG_BUILD/obj/mame/linux/blend/advmame $INSTALL/usr/bin
cp -r $PKG_BUILD/support/category.ini $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/sysinfo.dat $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/history.dat $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/hiscore.dat $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/event.dat $INSTALL/usr/share/advance
mkdir -p $INSTALL/usr/config/emuelec/configs
ln -sf /storage/.advance $INSTALL/usr/config/emuelec/configs/advmame
CFLAGS=$OLDCFLAGS
}
