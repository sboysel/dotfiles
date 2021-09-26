# external plugins (managed by sheldon, see ~/.sheldon/plugins.toml)
eval "$(sheldon source)"

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

# direnv
eval "$(direnv hook zsh)"
