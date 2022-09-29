#!/usr/bin/sh

set -e

for i in {1..10}; do
   dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-${i}" "['<Super>${i}']"
   # remove default binding
   dconf write "/org/gnome/shell/keybindings/switch-to-application-${i}" "@as []"
done
# workspace 10 -> 0
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-10 "['<Super>0']"
