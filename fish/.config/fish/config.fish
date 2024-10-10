if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
    exec "$HOME/.config/hypr/launch.sh"
end

if test -z "$DISPLAY" -a (tty) = "/dev/tty2"
    exec startx "$HOME/.config/xinitrc"
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

function rm
    /usr/bin/rm -I $argv
end

function macro-expand
    gcc -E -P -nostdinc -I- -C -dI $argv 2> /dev/null| clang-format --style="{BasedOnStyle: Google, IndentWidth: 4, SeparateDefinitionBlocks: Always}"  | bat --language c --style numbers,grid
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
