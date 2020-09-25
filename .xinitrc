exec dwm &
redshift -P -O 3500 &
picom -b &
dunst &

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -x &

feh --bg-scale ~/background.jpg &

# Statusbar loop
while true; do
   xsetroot -name "  ボリューム: $(pulsemixer --get-volume | awk '{print $1}')% 時間: $(date '+%Y %b %d %a %H:%M:%S')  "
   sleep 1s
done
