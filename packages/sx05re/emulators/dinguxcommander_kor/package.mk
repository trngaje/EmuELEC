# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="dinguxcommander_kor"
PKG_VERSION="c33cc7a2002bc99292bba6776b89d0d1fd60dc3a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/trngaje/rs97-commander-sdl2"
PKG_GIT_CLONE_BRANCH="kor"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2-git SDL2_image SDL2_gfx SDL2_ttf freetype"
PKG_SECTION="tools"
PKG_SHORTDESC="Two-pane commander for RetroFW and RG-350 (fork of Dingux Commander)"

pre_configure_target() {
sed -i "s|sdl2-config|${SYSROOT_PREFIX}/usr/bin/sdl2-config|" Makefile64.ogs
sed -i "s|CC=g++|CC=${CXX}|" Makefile64.ogs
cp Makefile64.ogs Makefile

}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp DinguxCommander $INSTALL/usr/bin/DinguxCommander_kor
}
