#!/usr/bin/env bash

source ~/.config/theme/app.sh

current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current * 100 / max))

new_percent=$(printf "" | "$MENU" -dmenu -slider -p "Brightness: $percent%" -width 300)

if [[ "$new_percent" =~ ^[0-9]+$ ]]; then
  brightnessctl set "${new_percent}%"
fi
