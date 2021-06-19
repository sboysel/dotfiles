# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec systemd-cat --identifier=sway sway
fi

# # GNOME
# if [[ -z $DISPLAY && $(tty) == /dev/tty1 && $XDG_SESSION_TYPE == tty ]]; then
#   MOZ_ENABLE_WAYLAND=1 QT_QPA_PLATFORM=wayland XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
# fi
