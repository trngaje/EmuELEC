# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="duckstation"
PKG_VERSION="8b234c06"
PKG_SHA256="d8f248563846ff079f83b6b0d37cb814fda780874ef9bc7511e06706e747aaa2"
PKG_LICENSE="NON-COMMERCIAL"
PKG_ARCH="aarch64"
PKG_SITE="https://www.duckstation.org/libretro"
PKG_URL="${PKG_SITE}/duckstation_libretro_linux_aarch64.zip"
PKG_SHORTDESC="Fast PlayStation 1 emulator for PC and Android "
PKG_TOOLCHAIN="manual"

pre_unpack() {
	unzip sources/duckstation/duckstation-${PKG_VERSION}.zip -d $PKG_BUILD
}

makeinstall_target() {
	mkdir -p $INSTALL/usr/lib/libretro
	cp $PKG_BUILD/duckstation_libretro.so $INSTALL/usr/lib/libretro
}
