# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="duckstation"
PKG_VERSION="4a017bd1"
PKG_SHA256="c0c05dec5c96e92320d0c0c4278ba2809f3809b669ecd637450b50a12946ca89"
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
