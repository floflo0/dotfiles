#!/usr/bin/python3

import os
import subprocess
import sys


STEP: int = 5
EXPIRE_TIME: int = 1000  # ms
ICONS: list[str] = [
    'display-brightness-off-symbolic',
    'display-brightness-low-symbolic',
    'display-brightness-medium-symbolic',
    'display-brightness-high-symbolic'
]
CACHE_DIR: str = os.getenv('XDG_CACHE_DIR', os.environ['HOME'] + '/.cache')
PREVIOUS_NOTIFICATION_FILE: str = CACHE_DIR + '/brightness-notification-id'


def get_brightness() -> int:
    process = subprocess.run(['brightnessctl', '--machine-readable', 'info'],
                             check=True, capture_output=True)
    return int(process.stdout.decode('utf-8').split(',')[3][:-1])


def inc_brightness() -> None:
    subprocess.run(['brightnessctl', 'set', f'{STEP}%+'], check=True)


def dec_brightness() -> None:
    subprocess.run(['brightnessctl', 'set', f'{STEP}%-'], check=True)


def get_previous_notification_id() -> str:
    if not os.path.isfile(PREVIOUS_NOTIFICATION_FILE):
        return '0'

    with open(PREVIOUS_NOTIFICATION_FILE, 'r', encoding='utf-8') as file:
        return file.read()


def save_notification_id(notification_id: str) -> None:
    with open(PREVIOUS_NOTIFICATION_FILE, 'w', encoding='utf-8') as file:
        file.write(notification_id)


def send_notification() -> None:
    brightness: int = get_brightness()
    icon: str = ICONS[round((brightness / 100.0) * (len(ICONS) - 1))]
    process = subprocess.run([
        'notify-send',
        f'Brightness: {brightness} %',
        '--icon', icon,
        '--expire-time', str(EXPIRE_TIME),
        '--hint', f'int:value:{brightness}',
        '--print-id',
        '--replace-id', get_previous_notification_id()
    ], check=True, capture_output=True)
    save_notification_id(process.stdout.decode('utf-8').strip())


def main() -> None:
    if sys.argv[1] == 'inc':
        inc_brightness()
    elif sys.argv[1] == 'dec':
        dec_brightness()
    send_notification()


if __name__ == '__main__':
    main()
