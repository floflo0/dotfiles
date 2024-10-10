import contextlib
import os
import shutil
import subprocess
import sys
from typing import Generator, NoReturn


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


def gsettings_set(schema_dir: str, schema: str, value: str) -> None:
    run_command('gsettings', 'set', schema_dir, schema, value)


def which(executable: str) -> bool:
    return shutil.which(executable) is not None


def is_archlinux() -> bool:
    return os.path.exists('/etc/arch-release')


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
def add_group(user: str, group: str) -> None:
    run_command('sudo', 'gpasswd', '-a', user, group)

