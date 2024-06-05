#!/usr/bin/sh

set -e

screenshot="${HOME}/Images/screenshots/$(date '+%Y-%m-%d-%H-%M-%S')-$(shuf -i10-100 -n1).png"

mkdir --parents $(dirname $screenshot)

maim --quality 1 $@ $screenshot

exec notify-send --app-name Screenshot --icon image "Screenshot saved"
