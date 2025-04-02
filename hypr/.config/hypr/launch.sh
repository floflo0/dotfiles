#!/usr/bin/bash

source "$HOME/.profile"

USER_RESOURCES="${XDG_CONFIG_HOME}/xresources"
SYS_RESOURCES="/etc/X11/xinit/.Xresources"

if [ -f "$SYS_RESOURCES" ]; then
    xrdb -merge "$SYS_RESOURCES"
fi
if [ -f "$USER_RESOURCES" ]; then
    xrdb -merge "$USER_RESOURCES"
fi

exec Hyprland
