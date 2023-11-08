#!/bin/sh
DEVICE=sysfs/leds/tpacpi::kbd_backlight

get_current() {
  light -s $DEVICE
}

popup() {
  makoctl dismiss
  notify-send -h int:value:$(get_current) $1 
}

main() {
  if (( $(echo "$(get_current) > 0" | bc -l) )); then
    light -s $DEVICE -S 0
    popup "󰃞  "
  else
    light -s $DEVICE -S 100
    popup "󰃞  "
  fi
}

main
