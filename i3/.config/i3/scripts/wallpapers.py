#!/usr/bin/python3 -OO

import datetime
import os
import subprocess
import time


HOME: str = os.getenv('HOME', '/home/floris')

WALLPAPER_NAME: str = 'outset_island'
WALLPAPER_EXT: str = 'jpeg'
WALLPAPERS_DIR: str = HOME + '/dotfiles/i3/.config/i3/wallpapers'
TRANSITIONS_DIR: str = WALLPAPERS_DIR + '/' + 'transitions'

SLEEP_TIME: float = 300.0  # s

INTERVALS: list[datetime.time] = [
    datetime.time(hour=11),
    datetime.time(hour=19),
    datetime.time(hour=22),
    datetime.time(hour=8)
]


def set_wallpaper(wallpaper_path: str) -> None:
    subprocess.run([
        'feh',
        '--no-fehbg',
        '--bg-fill',
        wallpaper_path
    ], check=False)


def get_wallpaper_path(wallpaper: int) -> str:
    return f'{WALLPAPERS_DIR}/{WALLPAPER_NAME}_{wallpaper}.{WALLPAPER_EXT}'


def change_wallpaper(wallpaper: int) -> None:
    transition_path: str = f'{TRANSITIONS_DIR}/{WALLPAPER_NAME}_{wallpaper}_'
    for i in range(5, 100, 5):
        set_wallpaper(f'{transition_path}{i}.{WALLPAPER_EXT}')
    set_wallpaper(get_wallpaper_path(wallpaper))


def next_index(wallpaper: int) -> int:
    return (wallpaper + 1) % len(INTERVALS)

def get_current_interval() -> int:
    now: datetime.time = datetime.datetime.now().time()
    for i, interval in enumerate(INTERVALS):
        next_interval: datetime.time = INTERVALS[next_index(i)]
        if interval < next_interval:
            if interval <= now <= next_interval:
                return i
        elif interval <= now or now <= next_interval:
            return i

    assert False, 'unreachable'


def get_next_change(next_interval: int) -> float:
    now: datetime.datetime = datetime.datetime.now()
    next_time: datetime.datetime = datetime.datetime.combine(
        now,
        INTERVALS[next_interval]
    )
    if next_time <= now:
        next_time += datetime.timedelta(days=1)
    return next_time.timestamp()


def main() -> None:
    current_interval: int = get_current_interval()
    previous_interval: int = current_interval
    set_wallpaper(get_wallpaper_path(current_interval))
    next_interval: int = next_index(current_interval)

    while True:
        next_change: float = get_next_change(next_interval)
        sleep_time: float
        if next_change - time.time() < SLEEP_TIME:
            sleep_time = next_change - time.time()
        else:
            sleep_time = SLEEP_TIME
        time.sleep(sleep_time)
        current_interval = get_current_interval()
        while current_interval != previous_interval:
            print('change', next_interval)
            change_wallpaper(next_interval)
            previous_interval = next_interval
            next_interval = next_index(next_interval)


if __name__ == '__main__':
    main()
