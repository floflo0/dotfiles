#!/bin/sh

set -e

# check if a package is install and install it if necessary
assert_install () {
    pacman -Q "${1}" > /dev/null || sudo pacman -S "${1}"
}

# install yay if it's not install
assert_yay () {
    if which yay; then
        return
    fi

    assert_install git
    sudo pacman -S base-devel

    git clone https://aur.archlinux.org/yay.git --depth 1
    pushd yay
    makepkg -si
    popd
    rm -rf yay
    yay -Y --gendb
    yay -Y --devel --save
    yay -Y --combinedupgrade --save
}

LIST_TMP="list.tmp"

# open the file in neovim to edit the list
select_list () {
    cp -v "${1}" "${LIST_TMP}"
    nvim "${LIST_TMP}"
}

# read the list and remove comment
load_list () {
    cat "${LIST_TMP}" | cut -d \# -f1
    rm "${LIST_TMP}"
}

# the install function are call when the name after it are if the install_config
# list

install_packages () {
    select_list package_list
    sudo pacman -S $(load_list)
}

install_packages_aur () {
    select_list package_list_aur
    assert_yay
    yay -S $(load_list)
}

install_packages_npm () {
    select_list package_list_npm
    sudo npm install -g $(load_list)
}

install_nvim () {
    stow -D nvim
    stow nvim
}

install_git () {
    stow -D git
    stow git
}

install_i3 () {
    stow -D i3
    stow i3
}

install_nvim () {
    stow -D nvim
    stow nvim
}

install_polybar () {
    stow -D polybar
    stow polybar
}

install_profile () {
    stow -D profile
    stow profile
}

install_rofi () {
    stow -D rofi
    stow rofi
}

install_scrcpy () {
    stow -D scrcpy
    stow scrcpy
}

install_tmux () {
    stow -D tmux
    stow tmux
}

install_xfce4_terminal () {
    assert_install imagemagick
    # resize the background image to reduce the startup time
    convert \
        extern/dracula/wallpaper/arch.png \
        -resize 1366x1768 \
        xfce4-terminal/.config/xfce4/terminal/background.png
    stow -D xfce4-terminal
    stow xfce4-terminal
}

install_xresources () {
    stow -D xresources
    stow xresources
}

# install the configuration choosed by the user
main () {
    assert_install neovim
    assert_install stow
    select_list install_config
    for el in $(load_list); do
        install_${el}
    done
}

main
