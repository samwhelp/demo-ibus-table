#!/usr/bin/env bash


echo "gsettings set org.freedesktop.ibus.general preload-engines \"['xkb:us::eng', 'table:dayi4']\""
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng', 'table:dayi4']"
#gsettings reset org.freedesktop.ibus.general preload-engines
#gsettings get org.freedesktop.ibus.general preload-engines
