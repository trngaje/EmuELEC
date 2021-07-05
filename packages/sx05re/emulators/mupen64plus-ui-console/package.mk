# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-ui-console"
PKG_VERSION="32e27344214946f0dce3cd2b4fff152a3538bd8f"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-ui-console"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="mupen64plus-ui-console-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain SDL2-git mupen64plus-core mupen64plus-audio-sdl mupen64plus-input-sdl mupen64plus-rsp-cxd4 mupen64plus-rsp-hle mupen64plus-rsp-z64 mupen64plus-video-glide64mk2 mupen64plus-video-rice"
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
#"/home/trngaje/mygit/EmuELEC/build.EmuELEC-OdroidGoAdvance.aarch64-4.2/toolchain/bin/aarch64-libreelec-linux-gnueabi-"
export VC=0
export NEW_DYNAREC=1

export SDL_CFLAGS="-D_REENTRANT -I$SYSROOT_PREFIX/usr/include/SDL2 "
export SDL_LDLIBS="-L$SYSROOT_PREFIX/usr/lib -Wl,-rpath,$SYSROOT_PREFIX/usr/lib -Wl,--enable-new-dtags -lSDL2 "

#export APIDIR="$SYSROOT_PREFIX/usr/include/mupen64plus/api"
export APIDIR="$PKG_DIR/api"


#sed -i 's|#include "m64p_types.h"|#include "'${SYSROOT_PREFIX}'/usr/include/mupen64plus/api/m64p_types.h"|' "$PKG_BUILD/src/main.c"

DISTCC_HOSTS="" make -C "$PKG_BUILD/projects/unix" all -j7 BITS=64 USE_GLES=1 NEW_DYNAREC=1 V=1 HOST_CPU=aarch64 PIE=1 OPTFLAGS="$CFLAGS -O3 -flto "

$STRIP $PKG_BUILD/projects/unix/mupen64plus
}

makeinstall_target() {
 : not
}


post_make_target() {

echo "PKG_BUILD=$PKG_BUILD"
echo "TARGET_NAME=$TARGET_NAME"
echo "INSTALL=$INSTALL"

mkdir -p $INSTALL/usr/share/mupen64plus/
mkdir -p $INSTALL/usr/bin/
cp -P $PKG_BUILD/projects/unix/mupen64plus $INSTALL/usr/bin/
cp -r $PKG_DIR/bin/* $INSTALL/usr/bin/
cp -r $PKG_DIR/config/* $INSTALL/usr/share/mupen64plus/

CFLAGS=$OLDCFLAGS
}
