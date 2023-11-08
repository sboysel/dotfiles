#!/bin/sh
LOCK="sh -e ~/bin/river-lock.sh"
LIGHT="light -s sysfs/backlight/intel_backlight -S 10"
swayidle -d -w \
    timeout 60 "$LIGHT" \
    timeout 60 "$LOCK" \
    timeout 600 'systemctl suspend' \
    before-sleep "$LOCK" \
    lock "$LOCK"
