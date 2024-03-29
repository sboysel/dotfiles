#!/usr/bin/env bash

as_numeric() {
  echo "scale = 1; ${1}*100" | bc | printf '%.0f\n'
}

get_current() {
  CURRENT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $2 }')
  echo "${CURRENT}*100" | bc
}

is_muted() {
  MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $3 }')
  if [ $MUTED == "[MUTED]" ]; then
    echo "󰝟 "  
  else
    echo "󰕾 " 
  fi
}

popup() {
  makoctl dismiss
  notify-send -h string:syncronous:volume -h int:value:$(get_current) -a osd "${1}"
}

main() {
  OPR="${1}" 
  case ${OPR} in 
     "mute") pactl set-sink-mute @DEFAULT_SINK@ toggle && popup $(is_muted);; 
     "inc") pactl set-sink-volume @DEFAULT_SINK@ +10% && popup "󰝝 ";; 
     "dec") pactl set-sink-volume @DEFAULT_SINK@ -10% && popup "󰝞 ";; 
  esac
}

main $1
