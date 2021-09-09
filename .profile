export PATH=$PATH:$HOME/projects/scripts:$HOME:$HOME/.local/bin
# start Xorg if not already running
[ -z $DISPLAY ] && [ `tty` = /dev/tty1 ] && exec startx -- vt1;
