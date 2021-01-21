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
PS1="%{$fg[yellow]%}%~ %{$reset_color%}%{$fg[green]%}$%{$reset_color%} %{$fg[white]%}"
export EDITOR="nvim"
export TERMINAL="urxvtc -e"
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=100

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374,bg=#282828,bold,underline"

# nnn
export NNN_USE_EDITOR=1
export NNN_SHOW_HIDDEN=1

export PATH="${PATH}:${HOME}/.local/bin/:$HOME"
# ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=xim
export T_IM_MODULE=xim
# aliases
alias ls="ls --color"
alias myip="ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'"
alias yt="mpv --ytdl-format='bestvideo[height<=?1080]+bestaudio/best'"

mem()
{                                                                                                      
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf $1/1024 "MB"; $1=""; print }'
}

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

clear
