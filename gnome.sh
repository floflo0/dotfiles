#!/usr/bin/bash

set -xe

dconf write /org/gnome/shell/overrides/dynamic-workspaces false
dconf write /org/gnome/mutter/dynamic-workspaces false
dconf write /org/gnome/desktop/wm/preferences/num-workspaces 10

for i in {1..10}; do
   dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-${i}" "['<Super>${i}']"
   dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-${i}" "['<Super><Shift>${i}']"
   # Remove default binding
   dconf write "/org/gnome/shell/keybindings/switch-to-application-${i}" "@as []"
done
# workspace 10 -> 0
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-10 "['<Super>0']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-10 "['<Super><Shift>0']"
