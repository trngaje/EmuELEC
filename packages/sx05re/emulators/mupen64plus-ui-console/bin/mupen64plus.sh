#!/bin/bash

if [ ! -f "/storage/.config/mupen64plus.cfg" ]; then
    cp /usr/share/mupen64plus/mupen64plus.cfg /storage/.config/
fi

mupen64plus --gfx mupen64plus-video-rice.so --plugindir /usr/share/mupen64plus --corelib /usr/share/mupen64plus/libmupen64plus.so.2 --datadir /storage/.config --configdir /storage/.config "$1"
