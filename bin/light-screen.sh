#!/bin/sh

get_model() {
  hostnamectl | grep Model | sed 's/\s.*Hardware Model:\s//g'
}

case "$(get_model)" in
   "ThinkPad X1 Carbon 3rd")
     DEVICE=sysfs/backlight/intel_backlight
     ;;
   "MacBookAir7,2")
     DEVICE=sysfs/backlight/acpi_video0
     ;;
esac

get_current() {
  light -s $DEVICE  
}

popup() {
  makoctl dismiss
  notify-send -h string:syncronous:volume -h int:value:$(get_current) -a osd "󰃞"
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
