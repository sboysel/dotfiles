#!/bin/sh
DEVICE=sysfs/backlight/intel_backlight

get_current() {
  light -s $DEVICE  
}

popup() {
  makoctl dismiss
  notify-send -h string:syncronous:volume -h int:value:$(get_current) "󰃞 "
}

main() {
  OPR="${1}" 
  case ${OPR} in 
     "set") light -s $DEVICE -S $2 && popup;; 
     "inc") light -s $DEVICE -A $2 && popup;; 
     "dec") light -s $DEVICE -U $2 && popup;; 
  esac
}

main $1 $2
