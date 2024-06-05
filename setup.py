#!/usr/bin/python3

import contextlib
import os
import shutil
import subprocess
import sys
import tempfile
from typing import Callable, Generator, NoReturn


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

YAY_URL: str = 'https://aur.archlinux.org/yay-bin.git'

I3_WALLPAPER_NAME: str = 'outset_island'
I3_WALLPAPER_EXT: str = 'jpeg'
I3_WALLPAPERS_DIR: str = HOME + '/dotfiles/i3/.config/i3/wallpapers'
I3_TRANSITIONS_DIR: str = I3_WALLPAPERS_DIR + '/' + 'transitions'
I3_WALLPAPERS_COUNT: int = 4


def error(*args: str) -> NoReturn:
    print(f'{sys.argv[0]}:', 'error:', *args, file=sys.stderr)
    sys.exit(1)


def mkdir(dir_path: str) -> None:
    if os.path.exists(dir_path):
        return

    os.makedirs(dir_path, exist_ok=True)
    print('Create directory:', dir_path)


def run_command(*command: str, silent: bool = False) -> None:
    assert command, 'command is empty'
    if not silent:
        print('$', ' '.join(command))
    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError as err:
        command_name: str = command[0] if command[0] == 'sudo' else command[0]
        error(command_name, f'exit with {err.returncode} code')


class PackageManager:

    executable: str

    def __init__(self) -> None:
        self.repo_synced: bool = False

    def sync_repo(self) -> None:
        raise NotImplementedError('sync_repo')

    def install_packages(self, *packages: str) -> None:
        raise NotImplementedError('install_package')


class AptPackageManager(PackageManager):

    executable: str = 'apt'

    def sync_repo(self) -> None:
        print('Updating repo')
        run_command('sudo', 'apt', 'update')
        self.repo_synced = True

    def install_packages(self, *packages: str) -> None:
        if not self.repo_synced:
            self.sync_repo()

        run_command('sudo', 'apt', 'install', *packages)


class PacmanPackageManager(PackageManager):

    executable: str = 'pacman'

    def sync_repo(self) -> None:
        run_command('sudo', 'pacman', '-Sy')
        self.repo_synced = True

    def install_packages(self, *packages: str) -> None:
        if not self.repo_synced:
            self.sync_repo()

        run_command('sudo', 'pacman', '-S', *packages)


PACKAGE_MANAGERS: list[PackageManager] = [
    AptPackageManager(),
    PacmanPackageManager()
]


def which(executable: str) -> bool:
    return shutil.which(executable) is not None


def is_archlinux() -> bool:
    return os.path.exists('/etc/arch-release')


def get_package_manager() -> PackageManager:
    for package_manager in PACKAGE_MANAGERS:
        if which(package_manager.executable):
            return package_manager

    error('no package manager found')


def ask_yes_no(message: str) -> bool:
    return input(message + ' [y/N] ').lower() == 'y'


@contextlib.contextmanager
def pushd(new_dir: str) -> Generator[None, None, None]:
    previous_dir: str = os.getcwd()
    os.chdir(new_dir)
    try:
        yield
    finally:
        os.chdir(previous_dir)


class Setup:

    def __init__(self) -> None:
        self.package_manager: PackageManager = get_package_manager()
        self.editor: str = self.get_editor()
        print('Found text editor:', self.editor)
        self.stow_found: bool = False
        self.yay_found: bool = False
        self.xdg_user_dirs_found: bool = False
        self.configs: dict[str, Callable[[], None]] = {
            'packages': self.install_packages,
            'packages_aur': self.install_packages_aur,
            'alacritty': self.install_alacritty,
            'bin': self.install_bin,
            'bluetooth': self.install_bluetooth,
            'cava': self.install_cava,
            'clangd': self.install_clangd,
            'fd': self.install_fd,
            'fish': self.insall_fish,
            'git': self.install_git,
            'gnome': self.install_gnome,
            'gtk': self.install_gtk,
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

    def install_packages_aur(self) -> None:
        packages: list[str] = self.ask_list_from_file(PACKAGE_LIST_AUR)
        if not packages:
            return
        self.yay(packages)

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
            'freetype2'
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

    def insall_fish(self) -> None:
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
        run_command('gsettings', 'set', 'org.gnome.desktop.interface',
                    'color-scheme', "'prefer-dark'")

    def i3_make_wallpapers_transitions(self) -> None:
        print('Making wallpapers transitions for i3')
        if os.path.exists(I3_TRANSITIONS_DIR):
            print('Removing existing transitions')
            shutil.rmtree(I3_TRANSITIONS_DIR)

        mkdir(I3_TRANSITIONS_DIR)

        for i in range(I3_WALLPAPERS_COUNT):
            print(f'Generating transition for {I3_WALLPAPER_NAME}_{i}')
            wallpaper_path: str = (
                I3_WALLPAPERS_DIR + '/' +
                I3_WALLPAPER_NAME + '_' +
                f'{i}.{I3_WALLPAPER_EXT}'
            )
            prev_i: int = (i - 1) % I3_WALLPAPERS_COUNT
            prev_wallpaper_path: str = (
                f'{I3_WALLPAPERS_DIR}/'
                f'{I3_WALLPAPER_NAME}_'
                f'{prev_i}.{I3_WALLPAPER_EXT}'
            )

            print('[' + ' ' * 20 + ']   0%', end='\r', flush=True)
            for j in range(5, 100, 5):
                frame_path: str = (
                    I3_TRANSITIONS_DIR + '/' +
                    I3_WALLPAPER_NAME + '_' +
                    f'{i}_{j}.{I3_WALLPAPER_EXT}'
                )
                run_command('composite', '-dissolve', str(j), '-gravity',
                            'Center', wallpaper_path, prev_wallpaper_path,
                            '-alpha', 'Set', frame_path,
                            silent=True)
                print(
                    '[' + '#' * (j // 5) + ' ' * ((100 - j) // 5) + ']',
                    f'{j:3}%',
                    end='\r',
                    flush=True
                )
            print('[' + '#' * 20 + '] 100%')

    def install_i3(self) -> None:
        if not which('convert') or not which('composite'):
            print('imagemagick is needed to setup this config')
            if not ask_yes_no('Install imagemagick ?'):
                sys.exit(0)

            self.package_manager.install_packages('imagemagick')

        print('Making lockscreen background image')
        run_command(
            'convert',
            f'{I3_WALLPAPERS_DIR}/{I3_WALLPAPER_NAME}_2.{I3_WALLPAPER_EXT}',
            '-resize',
            SCREEN_RESOLUTION,
            f'{I3_WALLPAPERS_DIR}/lockscreen.png'
        )

        self.i3_make_wallpapers_transitions()

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
        run_command('sudo', 'gpasswd', '-a', USER, 'adm')

    def install_tmux(self) -> None:
        self.stow_config('tmux', [CONFIG_DIR + '/tmux'])

        tpm_path: str = CONFIG_DIR + '/tmux/plugins/tpm'

        if not os.path.exists(tpm_path):
            run_command('git', 'clone', 'https://github.com/tmux-plugins/tpm',
                        CONFIG_DIR + '/tmux/plugins/tpm')

    def install_touchegg(self) -> None:
        self.stow_config('touchegg', [CONFIG_DIR + '/touchegg'])
        run_command('sudo', 'systemctl', 'enable', 'touchegg')

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
