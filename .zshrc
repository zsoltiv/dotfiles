# Lines configured by zsh-newuser-install
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/zsolti/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt autocd
autoload -U colors && colors
# variables
PS1="%{$bg[blue]%}%{$fg[green]%}%~ %{$fg[yellow]%}-> %{$reset_color%} %{$fg[white]%}"
EDITOR="nvim"
TERMINAL="alacritty -e"
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=100
export PATH="$HOME/Piskel-0.14.0-64bits/piskel:$PATH"
# ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=xim
export T_IM_MODULE=xim
# aliases
alias ls="ls --color"
alias assaultcube="/home/zsolti/AssaultCube/assaultcube.sh"
