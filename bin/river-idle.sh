#!/bin/sh
LOCK='sh -e ~/bin/river-lock.sh'
swayidle -d -w \
    timeout 60 "$LOCK" \
    timeout 600 'systemctl suspend' \
    before-sleep "$LOCK" \
    lock "$LOCK"


