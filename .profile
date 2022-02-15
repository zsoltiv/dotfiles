export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

#export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=gtk

export PATH="$PATH:$HOME/projects/scripts:$HOME:$HOME/.local/bin"
# start Xorg if not already running
[ -z $DISPLAY ] && [ `tty` = /dev/tty1 ] && exec startx -- vt1;
