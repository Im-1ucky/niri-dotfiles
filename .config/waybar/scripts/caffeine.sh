#!/bin/bash

if [[ "$1" == "toggle" ]]; then
  if pgrep -x swayidle >/dev/null; then
    pkill -x swayidle
  else
    ~/.config/scripts/run.sh &
  fi
fi

if pgrep -x swayidle >/dev/null; then
  echo '{"text":"󰾫","tooltip":"Caffeine: OFF"}'
else
  echo '{"text":"","tooltip":"Caffeine: ON"}'
fi
