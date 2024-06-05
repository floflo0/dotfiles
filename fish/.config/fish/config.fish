if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
    exec startx "$HOME/.config/xinitrc"
end

function e
    $argv &> /dev/null & disown
end
complete -c e -w exec

alias nvide="neovide ."
alias ls="exa"

function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

zoxide init fish | source
