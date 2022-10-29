#!/usr/bin/bash

set -e

run_sudo () {
    echo sudo "${@}"
    sudo ${@}
}

is_archlinux () {
    [[ -f "/etc/arch-release" ]]
}

assert_neovim () {
    if which nvim > /dev/null 2>&1; then
        return
    fi

    if is_archlinux; then
        run_sudo pacman -S neovim
    else
        echo "install neovim is not implemented"
        exit 1
    fi
}

# install the package if it's not installed
# $1: the package name
assert_install () {
    if is_archlinux; then
        pacman -Q "${1}" > /dev/null 2>&1 || run_sudo pacman -S "${1}"
    else
        if apt list --installed 2>&1 | cut -d "/" -f1 | grep -Fx "${1}" > /dev/null; then
            run_sudo apt install "${1}"
        fi
    fi
}

# install yay if it's not install
assert_yay () {
    if which yay > /dev/null 2>&1; then
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
    cp "${1}" "${LIST_TMP}"
    nvim "${LIST_TMP}"
}

# read the list and remove comment
load_list () {
    cat "${LIST_TMP}" | cut -d \# -f1 | awk '{print $1}' | awk NF
    rm "${LIST_TMP}"
}

unstow () {
    stow --verbose --delete "${1}" 2>&1 | grep -v "BUG in find_stowed_path" || true
}

# remove config directory
# $1: the directory to delete
# $2: the directpry to unstow
remove_config () {
    if [[ -d "${1}" ]]; then
        if [[ -L "${1}" ]]; then
            unstow "${2}"
        else
            rm --verbose --recursive --force "${1}"
        fi
    fi
}

# the install function are call when there name are in the
# install_config list

install_packages () {
    select_list package_list
    if is_archlinux; then
        run_sudo pacman -S $(load_list)
    else
        run_sudo apt install $(load_list)
    fi
}

install_packages_aur () {
    select_list package_list_aur
    assert_yay
    yay -S $(load_list)
}

install_packages_npm () {
    select_list package_list_npm
    run_sudo npm install -g $(load_list)
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
    unstow scrcpy
    mkdir --parents --verbose ~/.local/share/applications
    stow scrcpy
}

install_tmux () {
    stow -D tmux
    stow tmux
}

install_xfce4_terminal () {
    assert_install imagemagick
    # resize the background image to reduce the startup time
    if [[ -f "/etc/arch-release" ]]; then
        background="extern/dracula/wallpaper/arch.png"
    else
        background="extern/dracula/wallpaper/pop.png"
    fi
    resolution=$(xrandr | grep " connected" | cut -d " " -f4 | cut -d + -f1)
    convert \
        "${background}" \
        -resize "${resolution}" \
        xfce4-terminal/.config/xfce4/terminal/background.png
    remove_config ~/.config/xfce4/terminal xfce4-terminal
    remove_config ~/.locl/share/xfce4/terminal xfce4-terminal
    mkdir --verbose --parents ~/.config/xfce4
    mkdir --verbose --parents ~/.local/share/xfce4
    stow --verbose xfce4-terminal
}

install_xresources () {
    stow -D xresources
    stow xresources
}

# install the configuration choosed by the user
main () {
    assert_neovim
    assert_install stow
    select_list install_config
    for el in $(load_list); do
        install_${el}
    done
}

main
