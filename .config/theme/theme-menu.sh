#!/usr/bin/env bash

THEME=$(printf "blue\ngroot" | rofi -dmenu -p "Theme")

[[ -z "$THEME" ]] && exit 0

~/.config/theme/switch.sh "$THEME"
