import contextlib
import grp
import os
import shutil
import subprocess
import sys
from typing import Generator, NoReturn


EXIT_FAILURE: int = 1


def error(*args: str) -> NoReturn:
    print(f'{sys.argv[0]}:', 'error:', *args, file=sys.stderr)
    sys.exit(EXIT_FAILURE)


def mkdir(dir_path: str) -> None:
    if os.path.exists(dir_path):
        return

    os.makedirs(dir_path, exist_ok=True)
    print('Create directory:', dir_path)


def run_command(*command: str, silent: bool = False,
                env: dict[str, str] | None = None) -> None:
    assert command, 'command is empty'
    if not silent:
        print('$', ' '.join(command))
    try:
        subprocess.run(command, check=True, env=env)
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


def has_group(group: str) -> bool:
    return grp.getgrnam(group).gr_gid in os.getgroups()


def add_group(user: str, group: str) -> None:
    if has_group(group):
        return

    print('Add group {group} to user {user}')
    run_command('sudo', 'gpasswd', '-a', user, group)


def systemctl_enable(service: str, user: bool = False, now: bool = True
                     ) -> None:
    command: list[str] = []
    if not user:
        command.append('sudo')

    command.append('systemctl')
    command.append('enable')
    if user:
        command.append('--user')
    if now:
        command.append('--now')
    command.append(service)
    run_command(*command)

