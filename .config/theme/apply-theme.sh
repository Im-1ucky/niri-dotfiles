#!/usr/bin/env bash

THEME="$1"
THEME_DIR="$HOME/.config/theme/themes/$THEME"
THEME_FILE="$THEME_DIR/theme.sh"

COLORS_FILE="$HOME/.config/theme/colors.sh"
CURRENT_THEME="$HOME/.config/theme/current-theme"

if [[ -z "$THEME" || ! -f "$THEME_FILE" ]]; then
  exit 1
fi

source "$THEME_FILE"

echo "$THEME" >"$CURRENT_THEME"

sed -i \
  -e "s|^PRIMARY=.*|PRIMARY=\"$PRIMARY\"|" \
  -e "s|^INACTIVE=.*|INACTIVE=\"$INACTIVE\"|" \
  -e "s|^FOREGROUND=.*|FOREGROUND=\"$FOREGROUND\"|" \
  -e "s|^RED=.*|RED=\"$RED\"|" \
  -e "s|^WALLPAPER=.*|WALLPAPER=\"$WALLPAPER\"|" \
  "$COLORS_FILE"

cp "$THEME_DIR/kitty.conf" \
  "$HOME/.config/kitty/current-theme.conf"

echo "$NVIM_THEME" >"$HOME/.config/theme/current-nvim-theme"
