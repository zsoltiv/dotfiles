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
PS1="%{$fg[yellow]%}%~ %{$reset_color%}%{$fg[green]%}⮕%{$reset_color%} %{$fg[white]%}"
EDITOR="nvim"
TERMINAL="alacritty -e"
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=100
# ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=xim
export T_IM_MODULE=xim
# aliases
alias ls="ls --color"
alias myip="ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'"

mem()
{                                                                                                      
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf $1/1024 "MB"; $1=""; print }'
}
