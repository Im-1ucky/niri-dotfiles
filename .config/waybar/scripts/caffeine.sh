#!/bin/bash

if [[ "$1" == "toggle" ]]; then
  if pgrep -x swayidle >/dev/null; then
    pkill -x swayidle
  else
    ~/.config/swayidle/run.sh &
  fi
fi

if pgrep -x swayidle >/dev/null; then
  echo '{"text":"󰾫","tooltip":"Caffeine: OFF"}'
else
  echo '{"text":"","tooltip":"Caffeine: ON"}'
fi
