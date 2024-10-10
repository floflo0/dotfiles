if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
    exec startx "$HOME/.config/xinitrc"
end

if test -z "$DISPLAY" -a (tty) = "/dev/tty2"
    exec "$HOME/.config/hypr/launch.sh"
end

function e
    $argv &> /dev/null & disown
end
complete -c e -w exec

function nvide
    neovide . $argv
end

function ls
    eza $argv
end

function cd..
    cd ..
end

set -x FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

zoxide init fish | source


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/floris/.opam/opam-init/init.fish' && source '/home/floris/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
