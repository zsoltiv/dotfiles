feh --bg-scale ~/download.jpeg &
redshift -P -O 3500 &
picom -b &
dunst &
ibus-daemon -x &
([[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources) &
urxvtd --quiet --opendisplay --fork &
