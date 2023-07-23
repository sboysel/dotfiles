#!/bin/sh

TERM="/usr/bin/kitty"
WOFI="wofi -c ${HOME}/.config/wofi/config.utils"

menu_systemd() {
  MENU="status (all)\nstatus (failed)\njournalctl"
  CHOICE=$(echo -e ${MENU} | ${WOFI})
  TERM_OPTS="--detach --class=floating-systemd"
  CMD="${TERM} ${TERM_OPTS}"
  case $CHOICE in
      "status (all)") $CMD systemctl status;;
      "status (failed)") $CMD systemctl status --state=failed | less;;
      "journalctl") $CMD journalctl;;
      *) echo "nothing";;
  esac 
}

menu_zerotier() {
  MENU="status\nrestart"
  CHOICE=$(echo -e ${MENU} | ${WOFI})
  TERM_OPTS="--detach --class=floating-zerotier"
  CMD="${TERM} ${TERM_OPTS}"
  case $CHOICE in
      "status") $CMD sudo zerotier-cli info | less -f;;
      "restart") $CMD sudo systemctl restart zerotier-one.service;;
      *) echo "nothing";;
  esac 
}

main() {
  MENU="btop\ndocker\nnewsboat\nsystemd\nyadm\nzerotier"
  CHOICE=$(echo -e ${MENU} | ${WOFI})
  TERM_OPTS="--detach --class=floating-${CHOICE}"
  CMD="${TERM} ${TERM_OPTS}"
  case ${CHOICE} in
      "btop") $CMD btop;;
      "docker") $CMD lazydocker;;
      "newsboat") $CMD newsboat;;
      "systemd") menu_systemd;;
      "yadm") $CMD lazygit -g $HOME/.local/share/yadm/repo.git/;;
      "zerotier") menu_zerotier;;
      *) echo "nothing";;
  esac 
}

main
