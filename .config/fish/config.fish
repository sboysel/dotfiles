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
set -gx NOTES_REPO "$HOME/repos/notes"

### functions (aliases) ###
# fish
function fish_source
    source $HOME/.config/fish/config.fish
end

# function fish_greeting
#     fish_logo
# end

# working with files
function exa --description "Alternative to `ls` (pretty, detailed, shows hidden)"
    /usr/bin/exa --icons --group-directories-first -al $argv
end

function ls
    /usr/bin/ls --color -hlX $argv
end

# yay
function yu --description "Update system"
    yay -Syyu
end

function yo --description "List orphaned packages"
    yay -Qtdq
end

function yc --description "Clean yay package cache"
    yay -Scc
end

function yd --description "Removed unneeded yay dependencies"
    yay -Yc
end

function ye --description "Show explicitly installed packages"
    yay -Qe
end

function ym --description "Show manually installed packages"
    yay -Qm
end

# maintenance
function rmcache --description "Clears $HOME/.cache"
    sudo rm -rf $HOME/.cache/*
end

function rmorph --description "Remove orphaned packages"
    sudo pacman -Rns (pacman -Qtdq)
end

function rmjourn --description "Vaccum systemd journal"
    sudo journalctl --vacuum-time=2weeks
end

# applications
function R
    /usr/bin/R --no-save $argv
end

function zathura
    GDK_BACKEND=x11 /usr/bin/zathura $argv
end

function cmatrix
    /usr/bin/cmatrix -as 
end

function russ
    $HOME/.cargo/bin/russ --database-path $HOME/.config/russ/russ.sqlite
end

function m --description "Alias for `macchina`"
    /usr/bin/macchina
end

# utilities
function n --description "Opens a new timestamped note for editing"
    vim $NOTES_REPO/(date +"%Y%m%d")_$argv.md
end

function cdn --description "List notes in $HOME/repos/notes "
    cd $NOTES_REPO
end

function lsn --description "List notes in $HOME/repos/notes "
    lf $NOTES_REPO
end

# connect to wifi
# source: https://gist.github.com/guyzmo/146423d0cf7d3c0a46e10eeb66883905
function wifi --description "Combine nmcli with fzf to connect to wifi networks"
    set SSID ''
    set PASSWORD ''
    nmcli device wifi rescan > /dev/null
    # get SSID from list
    set SSID $(nmcli device wifi list | \
        tail -n +2 | \
        grep -v '^  *\B--\B' | \
        fzf -m | \
        sed 's/^ *\*//' | \
        awk '{print $2}')
    echo "SSID: $SSID"
    # user input password
    while true
        # read -l -s -P "password: " INPUT
        read -l -P "password: " INPUT
        if [ $INPUT != '' ]
            set PASSWORD $INPUT
            break
        else
            echo "ERROR: password cannot be empty"
        end
    end
    # connect
    nmcli device wifi connect $SSID password "$PASSWORD"
end

### theme / colors ###
# https://github.com/Jomik/fish-gruvbox
theme_gruvbox dark medium

### plugins ###
set fzf_fd_opts --hidden --exclude=.git --exclude=.cache

### hooks ###
# direnv
set -gx DIRENV_LOG_FORMAT 
direnv hook fish | source

# starship prompt
starship init fish | source
