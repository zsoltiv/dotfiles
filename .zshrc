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
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt autocd
autoload -U colors && colors
# variables
PS1="%{$fg[yellow]%}%~%{$reset_color%}%{$fg[green]%} %% %{$reset_color%}%{$fg[blue]%}"
export EDITOR="nvim"
export TERMINAL="urxvtc -e"
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=100

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bold,underline"

# nnn
export NNN_USE_EDITOR=1
export NNN_SHOW_HIDDEN=1

export PATH="${PATH}:${HOME}/.local/bin/:$HOME:$HOME/projects/scripts/"
# ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULExim
export QT_IM_MODULE=xim

# npm
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
# dwm isn't a reparenting WM
export _JAVA_AWT_WM_NONREPARENTING=1


#export MANPAGER="nvim -c 'set ft=man' -"
# aliases
alias sudo="doas"
alias ls="ls --color"
alias myip="ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'"
alias yt="mpv --ytdl-format='bestvideo[height<=?1080][vcodec!=vp9]+bestaudio/best'"
alias sync="doas emerge --sync"
alias update="doas emerge -avNUD --with-bdeps=y --keep-going @world"
alias USE="doas nvim /etc/portage/package.use/neovim"
alias MASK="doas nvim /etc/portage/package.accept_keywords"
alias nas="doas mount -t cifs -o username=zsolti,uid=$(id -u),gid=$(id -g) //neuromancer.corp/neuromancer /mnt/smb"
# functions
mem()
{                                                                                                      
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf $1/1024 "MB"; $1=""; print }'
}

# start Xorg if not already running
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx -- vt1; fi

clear

# perl stuff
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
