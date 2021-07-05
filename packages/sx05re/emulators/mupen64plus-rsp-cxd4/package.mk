# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-rsp-cxd4"
PKG_VERSION="11edb7a785621d507968898a100420072076d71d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-rsp-cxd4"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="mupen64plus-rsp-cxd4-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain SDL2-git mupen64plus-core"
PKG_SECTION="emuelec/mod"
PKG_SHORTDESC="the mupen64plus program will look for a user configuration file called mupen64plus.cfg"
PKG_LONGDESC="the mupen64plus program will look for a user configuration file called mupen64plus.cfg"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="manual"


make_target() {
cd $PKG_BUILD

echo "STRIP = $STRIP"
echo "CC = $CC" 
echo "CXX = $CXX" 
echo "CCFLAGS = $CFLAGS" 
echo "CXXFLAGS = $CXXFLAGS" 
echo "LINKFLAGS = $LDFLAGS" 

export CROSS_COMPILE=${CC:0:-3}
export VC=0
export NEW_DYNAREC=1

export SDL_CFLAGS="-D_REENTRANT -I$SYSROOT_PREFIX/usr/include/SDL2"
export SDL_LDLIBS="-L$SYSROOT_PREFIX/usr/lib -Wl,-rpath,$SYSROOT_PREFIX/usr/lib -Wl,--enable-new-dtags -lSDL2"


DISTCC_HOSTS="" make -C "$PKG_BUILD/projects/unix" all -j7 BITS=64 USE_GLES=1 NEW_DYNAREC=1 V=1 HOST_CPU=aarch64 PIE=1 OPTFLAGS="$CFLAGS -O3 -flto" APIDIR=${SYSROOT_PREFIX}/usr/include/mupen64plus/api

$STRIP $PKG_BUILD/projects/unix/mupen64plus-rsp-cxd4.so
}

makeinstall_target() {
 : not
}


post_make_target() {

echo "PKG_BUILD=$PKG_BUILD"
echo "TARGET_NAME=$TARGET_NAME"
echo "INSTALL=$INSTALL"

mkdir -p $INSTALL/usr/share/mupen64plus/
cp -P $PKG_BUILD/projects/unix/mupen64plus-rsp-cxd4.so $INSTALL/usr/share/mupen64plus/

CFLAGS=$OLDCFLAGS
}
