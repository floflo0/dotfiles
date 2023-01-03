export TERMINAL="/usr/bin/alacritty"
export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/firefox"

if [[ -f "${HOME}/.cargo/env" ]]; then
    source "${HOME}/.cargo/env"
fi
export PATH="${HOME}/.local/bin:${PATH}"

export NEOVIDE_MULTIGRID="true"
export NEOVIDE_FRAMELESS="true"
export NEOVIDE_FRAME="none"
export MYPY_CACHE_DIR="${HOME}/.cache/mypy"
