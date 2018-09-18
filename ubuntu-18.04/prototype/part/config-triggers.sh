#!/usr/bin/env bash


echo "gsettings set org.freedesktop.ibus.general.hotkey triggers \"['<Control>space']\""
gsettings set org.freedesktop.ibus.general.hotkey triggers "['<Control>space']"
#gsettings reset org.freedesktop.ibus.general.hotkey triggers
#gsettings get org.freedesktop.ibus.general.hotkey triggers
