## path
typeset -U PATH path
path=("$HOME/bin" "$HOME/bin/go" "/opt/sonar-scanner" $path)
export PATH

## environment
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export SUDO_EDITOR=/usr/bin/vim
export RANGER_LOAD_DEFAULT_RC=FALSE
export GOHOME='~/go'
export GOBIN='~/go/bin'
export JULIA_PROJECT='@.'
export JULIA_NUM_THREADS=4
export RUSTC_WRAPPER=sccache
export SONAR_SCANNER_HOME="/opt/sonar-scanner"

## alias
alias ls='ls --color -hlX'
