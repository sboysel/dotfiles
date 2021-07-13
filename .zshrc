## external plugins (managed by sheldon, see ~/.sheldon/plugins.toml)
eval "$(sheldon source)"

# application titles in kitty windows
precmd () {print -Pn "\e]0;%~\a"}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e

