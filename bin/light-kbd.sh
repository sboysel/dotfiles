#!/bin/sh

get_model() {
  hostnamectl | grep Model | sed 's/\s.*Hardware Model:\s//g'
}

case "$(get_model)" in
   "ThinkPad X1 Carbon 3rd")
     DEVICE=sysfs/leds/tpacpi::kbd_backlight
     ;;
    "MacBookAir7,2")
     DEVICE=sysfs/leds/smc::kbd_backlight
     ;;
esac

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
