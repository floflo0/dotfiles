#!/usr/bin/bash

set -e

assert_neovim () {
    if which nvim > /dev/null; then
        return
    fi

    if which apt > /dev/null; then
        echo "neovim is required"
        exit 1
    else
        sudo pacman -S neovim
    fi
}

assert_install () {
    if which apt > /dev/null; then
        if apt list --installed 2>&1 | cut -d "/" -f1 | grep -Fx "${1}" > /dev/null; then
            sudo apt install "${1}"
        fi
    else
        pacman -Q "${1}" || sudo pacman -S "${1}"
    fi
}

# install yay if it's not install
assert_yay () {
    if which yay > /dev/null; then
        return
    fi

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

# the install function are call when there name are in the
# install_config list

install_packages () {
    select_list package_list
    if which apt > /dev/null; then
        sudo apt install $(load_list)
    else
        sudo pacman -S $(load_list)
    fi
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
    if [ -f "/etc/arch-release" ]; then
        background="extern/dracula/wallpaper/arch.png"
    else
        background="extern/dracula/wallpaper/pop.png"
    fi
    convert \
         "${background}" \
        -resize 1920x1080 \
        xfce4-terminal/.config/xfce4/terminal/background.png
    mkdir --parents ~/.config/xfce4
    stow -D xfce4-terminal
    stow xfce4-terminal
}

install_xresources () {
    stow -D xresources
    stow xresources
}

# install the configuration choosed by the user
main () {
    assert_neovim
    assert_install stoww
    select_list install_config
    for el in $(load_list); do
        install_${el}
    done
}

main
