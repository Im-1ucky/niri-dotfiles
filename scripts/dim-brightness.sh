#!/bin/bash
STATE_FILE="/tmp/brightness_prev"
restore() {
  if [ -f "$STATE_FILE" ]; then
    brightnessctl set "$(cat "$STATE_FILE")" -q
    rm -f "$STATE_FILE"
  fi
  exit 0
}
if [ "$1" = "restore" ]; then
  restore
fi
if [ ! -f "$STATE_FILE" ]; then
  brightnessctl get > "$STATE_FILE"
fi
brightnessctl set 20% -q
