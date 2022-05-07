if status is-interactive
    # Commands to run in interactive sessions can go here
end

### environment ###
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx EDITOR /usr/bin/vim
set -gx VISUAL /usr/bin/vim
set -gx SUDO_EDITOR /usr/bin/vim
set -gx GPG_TTY $(tty)
set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx GOHOME "$HOME/go"
set -gx GOBIN "$HOME/go/bin"
set -gx JULIA_PROJECT '@.'
set -gx JULIA_NUM_THREADS 4
set -gx RUSTC_WRAPPER sccache
set -gx npm_config_prefix "$HOME/.local"
set -gx XDG_CURRENT_DESKTOP sway
set -gx XDG_SESSION_TYPE wayland

### functions (aliases) ###
function fish_greeting
    fish_logo
end

function m
    /usr/bin/macchina
end

# working with files
function exa
    /usr/bin/exa --icons --group-directories-first -a $argv
end

function ls
    /usr/bin/ls --color -hlX $argv
end

# yay
function yu
    yay -Syyu
end

function yo
    yay -Qtdq
end

function yc
    yay -Scc
end

function yd
    yay -Yc
end

# maintenance
function rmcache
    rm -rf $HOME/.cache/*
end

function rmorph
    sudo pacman -Rns (pacman -Qtdq)
end

function rmjourn
    sudo journalctl --vacuum-time=2weeks
end

# applications
function R
    /usr/bin/R --no-save $argv
end

function zathura
    GDK_BACKEND=x11 /usr/bin/zathura $argv
end

### theme / colors ###
# https://github.com/Jomik/fish-gruvbox
theme_gruvbox dark medium

### hooks ###
# direnv
set -gx DIRENV_LOG_FORMAT 
direnv hook fish | source

# starship prompt
starship init fish | source
