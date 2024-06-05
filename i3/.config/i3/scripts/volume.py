#!/usr/bin/python3

import os
import subprocess
import sys


STEP: int = 3
MAX_VOLUME: float = 1.5
EXPIRE_TIME: int = 50  # ms
ICON_MUTE: str = 'audio-volume-muted'
ICONS: list[str] = [
    'audio-volume-low',
    'audio-volume-medium',
    'audio-volume-high'
]
SOUND_INDICATOR: str = \
    '/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga'

CACHE_DIR: str = os.getenv('XDG_CACHE_DIR', os.environ['HOME'] + '/.cache')
PREVIOUS_NOTIFICATION_FILE: str = CACHE_DIR + '/volume-notification-id'

def is_mute() -> bool:
    env: dict[str, str] = dict(os.environ)
    # The output of pact change depending on the lang.
    env['LANG'] = 'en'
    process = subprocess.run(['pactl', 'get-sink-mute', '@DEFAULT_SINK@'],
                             check=True, capture_output=True, env=env)
    return process.stdout.decode('utf-8').split()[1] == 'yes'


def get_volume() -> float:
    process = subprocess.run(['pactl', 'get-sink-volume', '@DEFAULT_SINK@'],
                             check=True, capture_output=True)
    return float(process.stdout.decode('utf-8').split()[4][:-1]) / 100.0


def toggle_mute() -> None:
    subprocess.run(['pactl', 'set-sink-mute', '@DEFAULT_SINK@', 'toggle'],
                   check=True)


def inc_volume() -> None:
    if is_mute():
        toggle_mute()
        return

    volume: float = get_volume()
    if volume >= MAX_VOLUME:
        return
    subprocess.run(['pactl', 'set-sink-volume', '@DEFAULT_SINK@', f'+{STEP}%'],
                   check=True)


def dec_volume() -> None:
    if is_mute():
        toggle_mute()
        return

    subprocess.run(['pactl', 'set-sink-volume', '@DEFAULT_SINK@', f'-{STEP}%'],
                   check=True)


def get_previous_notification_id() -> str:
    if not os.path.isfile(PREVIOUS_NOTIFICATION_FILE):
        return '0'

    with open(PREVIOUS_NOTIFICATION_FILE, 'r', encoding='utf-8') as file:
        return file.read()


def save_notification_id(notification_id: str) -> None:
    with open(PREVIOUS_NOTIFICATION_FILE, 'w', encoding='utf-8') as file:
        file.write(notification_id)


def send_notification() -> None:
    volume: float = get_volume()
    icon: str
    if is_mute():
        icon = ICON_MUTE
    else:
        icon = ICONS[round(min(volume, 1.0) * (len(ICONS) - 1))]
    process = subprocess.run([
        'notify-send',
        f'Volume: {round(volume * 100)} %',
        '--icon', icon,
        '--expire-time', str(EXPIRE_TIME),
        '--hint', f'int:value:{round(volume * 100)}',
        '--print-id',
        '--replace-id', get_previous_notification_id()
    ], check=True, capture_output=True)
    save_notification_id(process.stdout.decode('utf-8').strip())

def play_sound() -> None:
    subprocess.run(['paplay', SOUND_INDICATOR], check=True,
                   capture_output=False)


def main() -> None:
    if sys.argv[1] == 'inc':
        inc_volume()
    elif sys.argv[1] == 'dec':
        dec_volume()
    elif sys.argv[1] == 'toggle_mute':
        toggle_mute()
    send_notification()
    play_sound()


if __name__ == '__main__':
    main()
