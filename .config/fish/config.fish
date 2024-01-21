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

set -gx MACHINE_VENDOR (hostnamectl | grep Vendor | sed 's/\s.*Hardware Vendor:\s//g')
set -gx MACHINE_MODEL (hostnamectl | grep Model | sed 's/\s.*Hardware Model:\s//g')
set -gx MACHINE "$MACHINE_VENDOR $MACHINE_MODEL" 

set -gx GPG_TTY $(tty)

set -gx EDITOR /usr/bin/helix
set -gx VISUAL /usr/bin/helix
set -gx SUDO_EDITOR /usr/bin/helix
set -gx SYSTEMD_EDITOR /usr/bin/helix

set -gx XDG_CURRENT_DESKTOP sway
set -gx XDG_SESSION_TYPE wayland
set -gx MOZ_ENABLE_WAYLAND 1
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx QT_QPA_PLATFORM wayland

set -gx GOPATH "$HOME/go"
set -gx GOBIN "$HOME/go/bin"
set -gx GOOS "linux"
set -gx GOARCH "amd64" 
set -gx JULIA_PROJECT '@.'
set -gx JULIA_NUM_THREADS 4
set -gx npm_config_prefix "$HOME/.local"
set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx RUSTC_WRAPPER sccache
set -gx NIXPKGS_ALLOW_UNFREE 1

set -gx NOTES_REPO "$HOME/repos/notes"
set -gx OBSIDIAN_REPO "$HOME/doc/obsidian"
set -gx XDG_SCREENSHOTS_DIR "$HOME/img/screenshots"

# remove fish greeting
set fish_greeting

# === simple aliases
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
    /usr/bin/paru -S archlinux-keyring && /usr/bin/paru -Syyu $argv
end

function par --description "[paru] uninstall packages"
    /usr/bin/paru -Rsn $argv
end

function pas --description "[paru] search packages"
    /usr/bin/paru -Ss $argv
end

function pasi --description "[paru] information about installed package"
    /usr/bin/paru -Si $argv
end 

function paql --description "[paru] query files owned by installed package"
    /usr/bin/paru -Ql $argv
end 

# === simple aliases // system maintenance
function rmorph --description "Remove orphaned packages"
    sudo pacman -Rns (pacman -Qtdq)
end

function rmjourn --description "Vaccum systemd journal"
    sudo journalctl --vacuum-time=2weeks
end

function pkgdiff --description "changes in packages installed on system"
    /usr/bin/paru -Qe | diff $HOME/.pkglist -
end

function nixpkgdiff --description "changes in Nix packages installed on system"
    nix-env -qa --installed "*" | diff $HOME/.nixpkglist -
end

# === simple aliases // misc
function tmuxp --description "tmuxp [profile name]"
  /usr/bin/tmuxp load $HOME/.config/tmuxp/$argv.yaml
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
