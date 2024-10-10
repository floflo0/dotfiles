from utils import error, run_command, which

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


def get_package_manager() -> PackageManager:
    for package_manager in PACKAGE_MANAGERS:
        if which(package_manager.executable):
            return package_manager

    error('no package manager found')
