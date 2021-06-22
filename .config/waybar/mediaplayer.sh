#!/bin/sh
player_status=$(playerctl --player=ncspot status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    echo " $(playerctl --player=ncspot metadata artist) :: $(playerctl --player=ncspot metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl --player=ncspot metadata artist) :: $(playerctl --player=ncspot metadata title)"
fi
