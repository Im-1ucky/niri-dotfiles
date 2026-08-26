#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/theme/themes"

THEME=$(find "$THEMES_DIR" \
  -mindepth 1 \
  -maxdepth 1 \
  -type d \
  -printf '%f\n' |
  sort |
  rofi -dmenu -p "Theme")

[[ -z "$THEME" ]] && exit 0

"$HOME/.config/theme/switch.sh" "$THEME"
