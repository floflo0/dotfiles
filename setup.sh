#!/bin/sh

set -e

install_file () {
    install_path=$HOME/$1
    mkdir -v -p $(dirname $install_path)
    ln -s -f $(realpath $1) $install_path
    echo $1
}

main () {
    for file in $(cat list_file); do
        install_file $file
    done
}

main
