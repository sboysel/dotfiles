#!/usr/bin/env bash
swayidle -d -w \
    timeout 60 "sh -e ~/bin/light-screen.sh set 10" \
    timeout 60 "sh -e ~/bin/river-lock.sh" \
    timeout 600 'systemctl suspend' \
    before-sleep "sh -e ~/bin/river-lock.sh" \
    lock "sh -e ~/bin/river-lock.sh"
