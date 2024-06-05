# Dotfiles

## Install

In the home directory:
```sh
git clone --recurse-submodules https://github.com/floflo0/dotfiles.git
cd dotfiles
./setup.sh
```

## Flash iso

```sh
sudo dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/disk/by-id/usb-My_flash_drive conv=fsync oflag=direct status=progress
```

## ArchLinux

### Install ArchLinux

Set the keyboard to azerty:
```sh
loadkeys fr
```

Enable parallel downloads for speed up the installation:
```sh
vim /etc/pacman.conf
```

Install archlinux:
```
archinstall
```

### Pacman config

```
Color
VerbosePkgLists
ParallelDownloads = 10
ILoveCandy
```

## Pop_OS!

### Dual Boot

Set up dual boot with windows on Pop_OS!:
<https://github.com/spxak1/weywot/blob/main/Pop_OS_Dual_Boot.md>

## Samba

```
client min protocol = CORE
```

## Changing vm.max_map_count

Change in `/usr/lib/sysctl.d/10-arch.conf`:
```
vm.max_map_count = 2147483642
```

## Mouse settings

In `/etc/X11/xorg.conf.d/10-floris.conf`:
```
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "NaturalScrolling" "true"
    Option "Tapping" "true"
EndSection

Section "InputClass"
    Identifier "mouse"
    MatchIsPointer "on"
    Driver "libinput"
    Option "AccelProfile" "flat"
EndSection
```

## Credits

- [Outset Island Wallpapers](https://steamcommunity.com/workshop/filedetails/?id=2197078124)
- [Revenant Wallpaper](https://wall.alphacoders.com/big.php?i=1150938)
- [Theme used](https://github.com/catppuccin/catppuccin)
