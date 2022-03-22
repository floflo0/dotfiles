#!/bin/sh

# check for update in the archlinux repository and in the AUR

check_all_updates () {
    checkupdates
    yay -Sua &>/dev/null
    yay -Qua
}

main () {
    updates=$(check_all_updates | wc -l)
    if [ "${updates}" -gt 0 ]; then
        text="${updates} updates availables"
        echo " ${text}"
        notify-send "${text}" -i distributor-logo-archlinux
    fi;
}

main

