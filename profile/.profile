export TERMINAL="/usr/bin/xfce4-terminal"
export EDITOR="nvim"
export BROWSER="/usr/bin/firefox"

if [[ -f "${HOME}/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi
export PATH="$HOME/.local/bin:$PATH"
