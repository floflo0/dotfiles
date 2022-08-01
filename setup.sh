#!/bin/sh

set -xe

assert_install () {
    pacman -Q $1 || sudo pacman -S $1
}

install_xfce4_terminal () {
    assert_install imagemagick
    convert \
        extern/dracula/wallpaper/arch.png \
        -resize 1366x1768 \
        xfce4-terminal/.config/xfce4/terminal/background.png
    stow -D xfce4-terminal
    stow xfce4-terminal
}

main () {
    install_xfce4_terminal
}

main

