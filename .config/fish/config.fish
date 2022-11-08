if status is-interactive
    # Commands to run in interactive sessions can go here
end

### environment ###
set -gx LC_ALL en_US.UTF-8
set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive

set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx SUDO_EDITOR /usr/bin/nvim

set -gx XDG_CURRENT_DESKTOP sway
set -gx XDG_SESSION_TYPE wayland
set -gx MOZ_ENABLE_WAYLAND 1
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx QT_QPA_PLATFORM wayland

set -gx GPG_TTY $(tty)

set -gx GOPATH "$HOME/go"
set -gx GOBIN "$HOME/go/bin"
set -gx GOOS "linux"
set -gx GOARCH "amd64" 
set -gx JULIA_PROJECT '@.'
set -gx JULIA_NUM_THREADS 4
set -gx npm_config_prefix "$HOME/.local"
set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx RUSTC_WRAPPER sccache

set -gx NOTES_REPO "$HOME/repos/notes"

### functions (aliases) ###

#
# shell
#

set fish_greeting

function fish_source
    source $HOME/.config/fish/config.fish
end

#
# working with files
#

function exa --description "Alternative to `ls` (pretty, detailed, shows hidden)"
    /usr/bin/exa --icons --group-directories-first -al $argv
end

function ls
    /usr/bin/ls --color -hlX $argv
end

#
# package management
#

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

#
# maintenance
#

function rmcache --description "Clears $HOME/.cache"
    set BEFORE (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "before:\t$BEFORE"
    sudo rm -rf $HOME/.cache/*
    set AFTER (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "after:\t$AFTER"
end

function rmorph --description "Remove orphaned packages"
    sudo pacman -Rns (pacman -Qtdq)
end

function rmjourn --description "Vaccum systemd journal"
    sudo journalctl --vacuum-time=2weeks
end

function pkgdiff --description "changes in packages installed on system"
    yay -Qe | diff $HOME/.pkglist -
end

function nixpkgdiff --description "changes in Nix packages installed on system"
    nix-env -qa --installed "*" | diff $HOME/.nixpkglist -
end

#
# aliases
#

function todo
    $GOBIN/ultralist $argv
end

function tl --description "ultralist list"
    todo l
end

function ta --description "ultralist add [args]"
    todo add $argv
end

function R
    /usr/bin/R --no-save $argv
end

function ptpython
    # python -m venv $HOME/.venv/ptpython
    # source $HOME/.venv/ptpython/bin/activate.fish
    # pip install -U pip ptpython
    source $HOME/.venv/ptpython/bin/activate.fish
    $HOME/.venv/ptpython/bin/ptpython
    deactivate
end

# function zathura
#     GDK_BACKEND=x11 /usr/bin/zathura $argv
# end

function cmatrix
    $HOME/.nix-profile/bin/cmatrix -as 
end

function clock
    # $HOME/.nix-profile/bin/tty-clock -ct
    tock -c
end

function russ
    $HOME/.cargo/bin/russ --database-path $HOME/.config/russ/russ.sqlite
end

function m --description "Alias for `macchina`"
    $HOME/.nix-profile/bin/macchina
end

## utilities

# interactively commit changes to dotfiles
function dots --description "config management"
    set CURRENT_DIR (pwd)
    set CURRENT_BRANCH (yadm branch --show-current)
    cd $HOME
    read -l -P "==> show diff? [y/n]: " reply
    switch $reply
        case Y y
            yadm --no-pager diff origin/$CURRENT_BRANCH
        case '' N n
    end
    # iterate through uncommited changes, add, and commit
    echo ""
    echo "==> Unstaged changes"
    echo ""
    for i in (yadm status --porcelain | awk '{print $2}')
        yadm --no-pager diff $i
        read -l -P "==> add and commit? [y/n]: " reply
        switch $reply
            case Y y
                yadm add $i
                read -l -P "==> message: " message
                yadm commit -m $message
            case '' N n
                continue
        end
    end
    # update list of arch linux packages (yay)
    if test (pkgdiff | wc -l) -gt 0
        pkgdiff
        read -l -P "==> update $HOME/.pkglist? [y/n]: " reply
        switch $reply
            case Y y
                yay -Qe > $HOME/.pkglist
                yadm add $HOME/.pkglist
                yadm commit -m "[packages] bump"
            case '' N n
        end
    end
    # update list nix packages (nix-env)
    if test (nixpkgdiff | wc -l) -gt 0
        nixpkgdiff
        read -l -P "==> update $HOME/.nixpkglist? [y/n]: " reply
        switch $reply
            case Y y
                nix-env -qa --installed "*" > $HOME/.nixpkglist
                yadm add $HOME/.nixpkglist
                yadm commit -m "[nix-packages] bump"
            case '' N n
        end
    end
    # push the commited changes
    if test (yadm status -sb | grep 'ahead' | wc -l) -ge 1
        yadm log origin/$CURRENT_BRANCH..$CURRENT_BRANCH
        # TODO: rebase?
        read -l -P "==> rebase? [y/n]: " reply
        switch $reply
            case Y y
                set COMMITS_AHEAD (yadm rev-list origin/$CURRENT_BRANCH..$CURRENT_BRANCH | wc -l)
                yadm rebase -i HEAD~$COMMITS_AHEAD
            case '' N n
        end
        read -l -P "==> push? [y/n]: " reply
        switch $reply
            case Y y
                yadm push -u origin
            case '' N n
        end
    end
    cd $CURRENT_DIR
end

# notes utility
function n --description "n [title]"
    if not set -q argv[1]
        # search all notes for editing
        nvim (printf %s\n (find $NOTES_REPO/notes -type f) | fzf)
    else
        set REGEX "*$argv*.md"
        set SEARCH_RESULTS (find $NOTES_REPO/notes -type f -name $REGEX)
        echo $SEARCH_RESULTS
        if test (count $SEARCH_RESULTS) -gt 0
            # match title with existing notes
            nvim (printf %s\n $SEARCH_RESULTS | fzf)  
        else
            # new notes
            nvim $NOTES_REPO/notes/(date +"%Y%m%d")_$argv.md
        end
    end
end

# # todo utility
# function todo --description "todo [edit|done] [n]"
#     if not set -q argv[1]
#         /usr/bin/mdcat $HOME/.todo
#     else if [ $argv[1] = "edit" ]
#         $EDITOR $HOME/.todo
#     else if [ $argv[1] = "done" ]
#         set N $argv[2]
#         /usr/bin/sed -i "s/$N\. \[ \]/$N\. \[x\]/g" $HOME/.todo
#         /usr/bin/mdcat $HOME/.todo
#     else
#         set N $argv[1]
#         set REGEX "$N s/$N. \[ \] //p"
#         set MSG (sed -n $REGEX $HOME/.todo)
#         $GOBIN/countdown 2s && /usr/bin/notify-send \
#                 -i $HOME/.local/share/pomo/icon.png \
#                 "TODO $N // pomodoro complete" $MSG \
#             && /usr/bin/paplay /usr/share/sounds/freedesktop/stereo/message.oga
#         echo "TODO $N // pomodoro complete // $MSG"
#     end
# end

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

# crop images for wallpaper
function cropper
    set x_res (swaymsg -t get_outputs | jq '.[0].current_mode.width')
    set y_res (swaymsg -t get_outputs | jq '.[0].current_mode.height')
    set x_img (magick identify -format '%w' $argv[1])
    set y_img (magick identify -format '%h' $argv[1])
    if test $x_img -gt $x_res && test $y_img -gt $y_res
        magick convert -resize $x_res"x"$y_res"^" $argv[1] $argv[2] 
    end
end

### theme / colors ###
# https://github.com/Jomik/fish-gruvbox
#theme_gruvbox dark medium

### plugins ###
set fzf_fd_opts --hidden --exclude=.git --exclude=.cache

### hooks ###
# pyenv
pyenv init - | source

# direnv
set -gx DIRENV_LOG_FORMAT 
direnv hook fish | source

# starship prompt
starship init fish | source
