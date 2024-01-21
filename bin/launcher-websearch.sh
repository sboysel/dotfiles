#!/usr/bin/env bash
BROWSER=/usr/bin/google-chrome-stable
CONFIG="-c ${HOME}/.config/wofi/config.websearch"

websearch() {
  QUERY=$(wofi $CONFIG)
  if [ "$QUERY" != "" ]; then
    $BROWSER "https://google.com/search?q=${QUERY}"
  fi
}

websearch
