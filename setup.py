#!/usr/bin/python3

import os
import shutil
import subprocess
import sys
import tempfile
from typing import Callable

from package_manager import get_package_manager, PackageManager
from utils import (
    add_group,
    ask_yes_no,
    error,
    gsettings_set,
    is_archlinux,
    mkdir,
    pushd,
    run_command,
    which
)


EDITOR: str | None = os.getenv('EDITOR')
HOME: str = os.environ['HOME']
USER: str = os.environ['USER']

CONFIG_DIR: str = HOME + '/.config'

# Config
SCREEN_RESOLUTION: str = '1920x1080'
BASE_DIRS: list[str] = [
    CONFIG_DIR,
    HOME + '/.local/bin',
    HOME + '/.local/share/applications',
    HOME + '/Games'
]

EDITORS: list[str] = ['nvim', 'vim', 'vi', 'nano']
DEFAULT_EDITOR: str = 'nvim'
DEFAULT_EDITOR_PACKAGE: str = 'neovim'

PACKAGE_LIST: str = 'package_list'
PACKAGE_LIST_AUR: str = 'package_list_aur'
PACKAGE_LIST_NPM: str = 'package_list_npm'

YAY_URL: str = 'https://aur.archlinux.org/yay-bin.git'

WALLPAPER_NAME: str = 'outset_island'
WALLPAPER_EXT: str = 'jpeg'
WALLPAPERS_DIR: str = HOME + '/dotfiles/i3/.config/i3/wallpapers'
WALLPAPERS_COUNT: int = 4


class Setup:

    def __init__(self) -> None:
        self.package_manager: PackageManager = get_package_manager()
        self.editor: str = self.get_editor()
        print('Found text editor:', self.editor)
        self.stow_found: bool = False
        self.yay_found: bool = False
        self.npm_found: bool = False
        self.xdg_user_dirs_found: bool = False
        self.configs: dict[str, Callable[[], None]] = {
            'packages': self.install_packages,
            'packages_aur': self.install_packages_aur,
            'packages_npm': self.install_packages_npm,
            'alacritty': self.install_alacritty,
            'bin': self.install_bin,
            'bluetooth': self.install_bluetooth,
            'cava': self.install_cava,
            'clangd': self.install_clangd,
            'fd': self.install_fd,
            'fish': self.install_fish,
            'git': self.install_git,
            'gnome': self.install_gnome,
            'gtk': self.install_gtk,
            'hypr': self.install_hypr,
            'i3': self.install_i3,
            'neovide': self.install_neovide,
            'nvim': self.install_neovim,
            'picom': self.install_picom,
            'polybar': self.install_polybar,
            'profile': self.install_profile,
            'rofi': self.install_rofi,
            'scrcpy': self.install_scrcpy,
            'system76': self.install_system76,
            'tmux': self.install_tmux,
            'touchegg': self.install_touchegg,
            'swaync': self.install_swaync,
            'swayosd': self.install_swayosd,
            'waybar': self.install_waybar,
            'xinit': self.install_xinit,
            'xresources': self.install_xresources,
            'yazi': self.install_yazi
        }

    def get_editor(self) -> str:
        if EDITOR and which(EDITOR):
            return EDITOR

        for editor in EDITORS:
            if which(editor):
                return editor

        print('No text editor found')
        if ask_yes_no(f'Install {DEFAULT_EDITOR_PACKAGE} ?'):
            self.package_manager.install_packages(DEFAULT_EDITOR_PACKAGE)
            return DEFAULT_EDITOR

        sys.exit(0)

    def xdg_user_dirs_update(self) -> None:
        if not self.xdg_user_dirs_found:
            if not which('xdg-user-dirs-update'):
                print('Could not find xdg-user-dirs-update')
                if ask_yes_no('Install xdg-user-dirs-update ?'):
                    self.package_manager.install_packages('xdg-user-dirs')
                    self.xdg_user_dirs_found = True
                else:
                    sys.exit(0)

        run_command('xdg-user-dirs-update')

    def create_base_dirs(self) -> None:
        print('Creating base directories')
        self.xdg_user_dirs_update()

        for directory in BASE_DIRS:
            mkdir(directory)

    def stow_command(self, *args: str) -> None:
        if not self.stow_found:
            if not which('stow'):
                print('stow not found')
                if ask_yes_no('Install stow ?'):
                    self.package_manager.install_packages('stow')
                    self.stow_found = True
                else:
                    sys.exit(0)

        run_command('stow', *args)

    def unstow(self, config_dir: str) -> None:
        self.stow_command('-D', config_dir)

    def stow(self, config_dir: str) -> None:
        self.stow_command(config_dir)

    def parse_list(self, file_path: str) -> list[str]:
        selected_items: list[str] = []
        with open(file_path, 'r', encoding='utf-8') as file:
            for line in file.readlines():
                line = line.split('#')[0].strip()
                if line:
                    selected_items.append(line)
        os.remove(file_path)
        return selected_items

    def ask_list(self, items: list[str], comment: bool = False) -> list[str]:
        tmp: str = tempfile.mktemp()
        with open(tmp, 'w', encoding='utf-8') as file:
            comment_string: str = ''
            if comment:
                file.write('# Uncomment the lines to install\n\n')
                comment_string = '# '
            for item in items:
                file.write(comment_string + item + '\n')
        run_command(self.editor, tmp)
        return self.parse_list(tmp)

    def ask_list_from_file(self, file_path: str) -> list[str]:
        tmp: str = tempfile.mktemp()
        shutil.copyfile(file_path, tmp)
        run_command(self.editor, tmp)
        return self.parse_list(tmp)

    def install_yay(self) -> None:
        run_command('git', 'clone', YAY_URL, '--depth', '1')
        with pushd('yay-bin'):
            run_command('makepkg', '--install', '--syncdeps')
        shutil.rmtree('yay-bin')
        run_command('yay', '-Y', '--gendb')
        run_command('yay', '-Y', '--devel', '--save')
        run_command('yay', '-Y', '--combinedupgrade', '--save')

    def yay(self, packages: list[str]) -> None:
        if not is_archlinux():
            error('could not use yay: not on archlinux')

        if not self.yay_found:
            if which('yay'):
                self.yay_found = True
            else:
                print('yay not found')
                if not ask_yes_no('Install yay ?'):
                    sys.exit(0)

                self.install_yay()

        run_command('yay', '-S', *packages)

    def stow_config(self, name: str, paths: list[str]) -> None:
        for path in paths:
            if os.path.exists(path):
                print(f'Found existing config for {name}: {path}')
                if os.path.islink(path):
                    self.unstow(name)
                elif os.path.isdir(path):
                    shutil.rmtree(path)
                else:
                    os.remove(path)

                print('Removed:', path)

        print('Install config for', name)
        self.stow(name)

    def install_packages(self) -> None:
        packages: list[str] = self.ask_list_from_file(PACKAGE_LIST)
        if not packages:
            return
        self.package_manager.install_packages(*packages)

    def npm(self, packages: list[str]) -> None:
        if not self.npm_found:
            if which('npm'):
                self.npm_found = True
            else:
                print('npm not found')
                if not ask_yes_no('Install npm ?'):
                    sys.exit(0)

                self.package_manager.install_packages('npm')

        run_command('sudo', 'npm', 'install', '--global', *packages)

    def install_packages_aur(self) -> None:
        packages: list[str] = self.ask_list_from_file(PACKAGE_LIST_AUR)
        if not packages:
            return
        self.yay(packages)

    def install_packages_npm(self) -> None:
        packages: list[str] = self.ask_list_from_file(PACKAGE_LIST_NPM)
        if not packages:
            return

        self.npm(packages)

    def install_alacritty(self) -> None:
        self.stow_config('alacritty', [CONFIG_DIR + '/alacritty'])

    def install_bin(self) -> None:
        self.stow_config('bin', [])

    def install_bluetooth(self) -> None:
        run_command('sudo', 'systemctl', 'enable', 'bluetooth.service')

    def install_cava(self) -> None:
        self.stow_config('cava', [CONFIG_DIR + '/cava'])

    def install_clangd(self) -> None:
        libs: list[str] = [
            'gtk4',
            'sdl2',
            'SDL2_ttf',
            'SDL2_image',
            'libadwaita-1',
            'glfw3',
            'gl',
            'glew',
            'freetype2',
            'libevdev'
        ]
        command: list[str] = ['pkg-config', '--cflags-only-I', *libs]
        print('$', *command)
        try:
            process = subprocess.run(command, capture_output=True, check=True)
        except subprocess.CalledProcessError as err:
            error(f'pkg-config exit with {err.returncode} code')
        print('Creating .clangd')
        with open(HOME + '/.clangd', 'w', encoding='utf-8') as file:
            file.write('CompileFlags:\n')
            file.write('  Add:\n')
            for line in process.stdout.decode('utf-8').split(' '):
                file.write(f'    - {line}\n')

    def install_fd(self) -> None:
        self.stow_config('fd', [CONFIG_DIR + '/fd'])

    def install_fish(self) -> None:
        print(CONFIG_DIR + '/fish')
        self.stow_config('fish', [CONFIG_DIR + '/fish'])

        if not os.path.isfile('/usr/bin/fish'):
            print('fish not found')
            if not ask_yes_no('Install fish ?'):
                sys.exit(0)

            self.package_manager.install_packages('fish')

        print('Changing default shell to fish')
        run_command('chsh', '--shell', '/usr/bin/fish')

        process = subprocess.run(['fish', '-c', 'fisher --version'],
                                 check=False)
        if process.returncode != 0:
            print('fisher not found')
            if not ask_yes_no('Install fisher ?'):
                sys.exit(0)

            self.package_manager.install_packages('fisher')

        run_command('fish', '-c', 'fisher install pure-fish/pure')
        run_command('fish', '-c', 'set --universal pure_show_jobs true')

        run_command('fish', '-c', 'fisher install catppuccin/fish')
        run_command('fish', '-c',
                    'fish_config theme save "Catppuccin Macchiato"')

    def install_git(self) -> None:
        self.stow_config('git', [CONFIG_DIR + '/git'])

    def install_gnome(self) -> None:
        run_command('./gnome.sh')

    def install_gtk(self) -> None:
        self.stow_config('gtk', [CONFIG_DIR + '/gtk-3.0',
                                 CONFIG_DIR + '/gtk-4.0'])
        gsettings_set('org.gnome.desktop.interface', 'color-scheme',
                      "'prefer-dark'")
        gsettings_set('org.gnome.desktop.interface', 'gtk-theme',
                      'catppuccin-macchiato-blue-standard+default')
        gsettings_set('org.gnome.desktop.interface', 'icon-theme',
                      'Papirus-Dark')
        gsettings_set('org.gnome.desktop.interface', 'cursor-theme',
                      'catppuccin-macchiato-dark-cursors')
        gsettings_set('org.gnome.desktop.interface', 'font-name',
                      'Cantarell 10')

    def install_hypr(self) -> None:
        self.stow_config('hypr', [CONFIG_DIR + '/hypr'])
        add_group(USER, 'input')
        run_command('systemctl', 'disable', '--user',
                    'libinput-gestures.service')

    def install_i3(self) -> None:
        if not which('convert') or not which('composite'):
            print('imagemagick is needed to setup this config')
            if not ask_yes_no('Install imagemagick ?'):
                sys.exit(0)

            self.package_manager.install_packages('imagemagick')

        print('Making lockscreen background image')
        run_command(
            'convert',
            f'{WALLPAPERS_DIR}/{WALLPAPER_NAME}_2.{WALLPAPER_EXT}',
            '-resize',
            SCREEN_RESOLUTION,
            f'{WALLPAPERS_DIR}/lockscreen.png'
        )

        self.stow_config('i3', [CONFIG_DIR + '/i3'])

    def install_neovide(self) -> None:
        self.stow_config('neovide', [CONFIG_DIR + '/neovide'])

    def install_neovim(self) -> None:
        self.stow_config('nvim', [CONFIG_DIR + '/nvim'])

    def install_picom(self) -> None:
        self.stow_config('picom', [CONFIG_DIR + '/picom'])

    def install_polybar(self) -> None:
        self.stow_config('polybar', [CONFIG_DIR + '/polybar'])

    def install_profile(self) -> None:
        self.stow_config('profile', [HOME + '/.profile'])

    def install_rofi(self) -> None:
        self.stow_config('rofi', [CONFIG_DIR + '/rofi'])
#
    def install_scrcpy(self) -> None:
        self.stow_config('scrcpy', [])

    def install_system76(self) -> None:
        run_command('sudo', 'systemctl', 'enable',
                    'com.system76.PowerDaemon.service')
        add_group(USER, 'adm')

    def install_tmux(self) -> None:
        self.stow_config('tmux', [CONFIG_DIR + '/tmux'])

        tpm_path: str = CONFIG_DIR + '/tmux/plugins/tpm'

        if not os.path.exists(tpm_path):
            run_command('git', 'clone', 'https://github.com/tmux-plugins/tpm',
                        CONFIG_DIR + '/tmux/plugins/tpm')

    def install_touchegg(self) -> None:
        self.stow_config('touchegg', [CONFIG_DIR + '/touchegg'])
        run_command('sudo', 'systemctl', 'enable', 'touchegg')

    def install_swaync(self) -> None:
        self.stow_config('swaync', [CONFIG_DIR + '/swaync'])

    def install_swayosd(self) -> None:
        run_command('sudo', 'systemctl', 'enable', '--now',
                    'swayosd-libinput-backend.service')

    def install_waybar(self) -> None:
        self.stow_config('waybar', [CONFIG_DIR + '/waybar'])

    def install_xinit(self) -> None:
        self.stow_config('xinit', [HOME + '/xinitrc'])

    def install_xresources(self) -> None:
        self.stow_config('xresources', [HOME + '/.Xresources'])

    def install_yazi(self) -> None:
        self.stow_config('yazi', [CONFIG_DIR + '/yazi'])

    def run(self) -> None:
        self.create_base_dirs()
        print('Choose config to install')
        configs: list[str] = self.ask_list(list(self.configs.keys()),
                                           comment=True)
        for config in configs:
            if config not in self.configs:
                error('unknown config to install:', config)

            print('Installing config', config)
            self.configs[config]()


def main() -> None:
    setup: Setup = Setup()
    setup.run()


if __name__ == '__main__':
    main()
