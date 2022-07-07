[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

#doas mount -t cifs -o username=zsolti,uid=$(id -u),gid=$(id -g) //neuromancer.corp/neuromancer /mnt/smb

redshift -P -O 3500 &
picom -cb &
dunst &

# use zsh in terminal emulators
export SHELL=/bin/zsh
urxvtd --quiet --opendisplay --fork

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
ibus-daemon -drx

# pipewire
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi
unset XDG_RUNTIME_DIR
export XDG_RUNTIME_DIR=$(mktemp -d /tmp/$(id -u)-runtime-dir.XXX)
/usr/bin/pipewire &

~/projects/scripts/random-wp &
~/projects/scripts/status &

# start mpd if it isn't already started
[ ! -s ~/.config/mpd/pid ] && mpd

# emacs --daemon &

# restart dwm if you quit
while type dwm >/dev/null ; do dwm && continue || break ; done
