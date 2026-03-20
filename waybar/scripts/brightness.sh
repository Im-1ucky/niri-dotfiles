#!/usr/bin/env bash

current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( current * 100 / max ))

new_percent=$(printf "" | rofi -dmenu -slider -p "Brightness: $percent%" -width 300)

if [[ "$new_percent" =~ ^[0-9]+$ ]]; then
    brightnessctl set "${new_percent}%"
fi
