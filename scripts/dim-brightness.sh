#!/bin/bash

STATE_FILE="/tmp/brightness_prev"

restore() {
  if [ -f "$STATE_FILE" ]; then
    brightnessctl set "$(cat "$STATE_FILE")" -q
    rm -f "$STATE_FILE"
  fi
  exit 0
}

# if called with restore
if [ "$1" = "restore" ]; then
  restore
fi

# store current brightness ONLY if not already stored
if [ ! -f "$STATE_FILE" ]; then
  brightnessctl get > "$STATE_FILE"
fi

# set dim level instantly (20%)
brightnessctl set 20% -q
