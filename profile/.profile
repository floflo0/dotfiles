export TERMINAL="/usr/bin/alacritty"
export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/firefox"

if [[ -f "${HOME}/.cargo/env" ]]; then
    source "${HOME}/.cargo/env"
fi
export PATH="${HOME}/.local/bin:${PATH}"

export MYPY_CACHE_DIR="${HOME}/.cache/mypy"

export PATH="${PATH}:/usr/local/go/bin"
