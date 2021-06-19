# application titles in kitty windows
precmd () {print -Pn "\e]0;%~\a"}

## builtin plugins
# completions
autoload -Uz compinit
compinit

# spaceship prompt
# > yay -S spaceship-prompt
autoload -U promptinit
promptinit
prompt spaceship

## external plugins (managed by sheldon, see ~/.sheldon/plugins.toml)
eval "$(sheldon source)"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e

