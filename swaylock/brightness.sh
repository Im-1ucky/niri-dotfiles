#!/bin/bash

STATE_FILE="/tmp/brightness_prev"

case "$1" in
dim)
  brightnessctl get >"$STATE_FILE"
  brightnessctl set 20%
  ;;
restore)
  if [ -f "$STATE_FILE" ]; then
    brightnessctl set "$(cat $STATE_FILE)"
  else
    brightnessctl set 70%
  fi
  ;;
esac
