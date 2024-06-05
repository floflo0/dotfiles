#!/usr/bin/sh

killall polybar

exec polybar default --config="$HOME/.config/polybar/config.ini" --quiet 2>&1 > /dev/null
