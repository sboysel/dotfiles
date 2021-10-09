## path
typeset -U PATH path
path=("$HOME/bin" "$HOME/go/bin" "/opt/sonar-scanner" $path)
export PATH

## environment
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export SUDO_EDITOR=/usr/bin/vim
export GPG_TTY=$(tty)
export RANGER_LOAD_DEFAULT_RC=FALSE
export GOHOME="$HOME/go"
export GOBIN="$HOME/go/bin"
export JULIA_PROJECT='@.'
export JULIA_NUM_THREADS=4
export RUSTC_WRAPPER=sccache
export SONAR_SCANNER_HOME="/opt/sonar-scanner"

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland


