#!/bin/sh
CURRENT=$(light -s sysfs/leds/tpacpi::kbd_backlight)

makoctl dismiss

if (( $(echo "$CURRENT > 0" | bc -l) )); then
  light -s sysfs/leds/tpacpi::kbd_backlight -S 0
  notify-send "keyboard backlight" "inactive" -i input-keyboard
else
  light -s sysfs/leds/tpacpi::kbd_backlight -S 100
  notify-send "keyboard backlight" "active" -i input-keyboard
fi
