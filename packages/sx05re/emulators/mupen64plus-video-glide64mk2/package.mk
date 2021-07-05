# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-video-glide64mk2"
PKG_VERSION="f0c92d93a29633ca7d9bcbb93a79baaca1f3f353"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-video-glide64mk2"
PKG_URL="$PKG_SITE.git"
PKG_SOURCE_DIR="mupen64plus-video-glide64mk2-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain SDL2-git mupen64plus-core"
PKG_SECTION="emuelec/mod"
PKG_SHORTDESC="Mupen64Plus's Rice Video plugin"
PKG_LONGDESC="Mupen64Plus's Rice Video plugin"
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

$STRIP $PKG_BUILD/projects/unix/mupen64plus-video-glide64mk2.so
}

makeinstall_target() {
 : not
}


post_make_target() {

echo "PKG_BUILD=$PKG_BUILD"
echo "TARGET_NAME=$TARGET_NAME"
echo "INSTALL=$INSTALL"

mkdir -p $INSTALL/usr/share/mupen64plus/
cp -P $PKG_BUILD/projects/unix/mupen64plus-video-glide64mk2.so $INSTALL/usr/share/mupen64plus/

CFLAGS=$OLDCFLAGS
}
