#!/bin/sh

killall polybar

exec polybar default 2>&1

