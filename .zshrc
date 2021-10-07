# completions
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# application titles in kitty windows
precmd () {print -Pn "\e]0;%~\a"}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e

# aliases
alias zsrc="source ~/.zshrc"
alias ysu="yay -Syyu"
alias yss="yay -Ss"
alias yql="yay -Ql"
alias yqs="yay -Qs"
alias sys="systemctl status"
alias syf="systemctl failed"
alias jfu="journalctl -f -u"

# external plugins (managed by sheldon, see ~/.sheldon/plugins.toml)
eval "$(sheldon source)"

# direnv
export DIRENV_LOG_FORMAT=   # turn down verbosity
eval "$(direnv hook zsh)"   # load

# starship prompt
eval "$(starship init zsh)"
