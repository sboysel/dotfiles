# $HOME/.config/fish/config.fish
# author: Sam Boysel <sboysel@gmail.com>

# === interactive
if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "Tomorrow Night"
end

# === environment
set -gx LC_ALL en_US.UTF-8
set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive

set -gx GPG_TTY $(tty)

set -gx EDITOR /usr/bin/helix
set -gx VISUAL /usr/bin/helix
set -gx SUDO_EDITOR /usr/bin/helix
set -gx SYSTEMD_EDITOR /usr/bin/helix

set -gx XDG_CURRENT_DESKTOP river
set -gx XDG_SESSION_TYPE wayland
set -gx MOZ_ENABLE_WAYLAND 1
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx QT_QPA_PLATFORM wayland

set -gx GOPATH "$HOME/.go"
set -gx GOBIN "$GOPATH/bin"
set -gx GOOS linux
set -gx GOARCH amd64

set -gx JULIA_PROJECT '@.'
set -gx JULIA_NUM_THREADS 4

set -gx npm_config_prefix "$HOME/.local"

set -gx RUSTC_WRAPPER sccache
set -gx NIXPKGS_ALLOW_UNFREE 1

set -gx RANGER_LOAD_DEFAULT_RC FALSE

set -gx NOTES_HOME "$HOME/doc/notes"
set -gx OBSIDIAN_REPO "$HOME/doc/obsidian"
set -gx XDG_SCREENSHOTS_DIR "$HOME/img/screenshots"


# remove fish greeting
set fish_greeting

# === simple aliases
function fish_source --description "Reload fish configuration"
    source $HOME/.config/fish/config.fish
end

function hx
    /usr/bin/helix $argv
end

function cl
    /sbin/clear
end

function R
    /usr/bin/R --no-save $argv
end

# === simple aliaes // working with files
function e --description "Alternative to `ls` (pretty, detailed)"
    /usr/bin/exa -o --icons --group-directories-first --total-size --time-style long-iso -lg $argv
end

function ls
    /usr/bin/ls --color -hlX $argv
end

function mime
    file --mime-type $argv -b
end

# === simple aliases // package management
function pa --description "[paru] update system and install packages"
    /usr/bin/paru -Syyu $argv
end

# === simple aliases // system maintenance
function rmorph --description "Remove orphaned packages"
    sudo pacman -Rns (pacman -Qtdq)
end

function rmjourn --description "Vaccum systemd journal"
    sudo journalctl --vacuum-time=2weeks
end

function rmcache --description "Clears $HOME/.cache"
    set -l BEFORE (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "before:\t$BEFORE"
    sudo rm -rf $HOME/.cache/*
    set -l AFTER (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "after:\t$AFTER"
end

# === utilities
# notes
function n --description "n [-b/--browse]"
    argparse --name=note b/browse -- $argv
    or return

    if set -q _flag_browse
        ranger $NOTES_HOME
    else
        set -l NOTE $NOTES_HOME/(date +'%Y%m%d').md
        $EDITOR $NOTE
    end

end

# save links
function slink --description "save URL to ~/sync/links"
    if set -q argv[1]
        echo $argv >>$HOME/sync/links
    else
        cat $HOME/sync/links
    end
end

# === plugins
# === plugins // fzf
set fzf_fd_opts --hidden --exclude=.git --exclude=.cache

# === hooks
# === hooks // pyenv
pyenv init - | source

# === hooks // direnv
set -gx DIRENV_LOG_FORMAT
direnv hook fish | source

# === hooks // starship
starship init fish | source
