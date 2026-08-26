#!/usr/bin/env bash

THEME="$1"
THEME_DIR="$HOME/.config/theme/themes/$THEME"
THEME_FILE="$THEME_DIR/theme.sh"
COLORS_FILE="$HOME/.config/theme/colors.sh"

if [[ -z "$THEME" ]]; then
  echo "Usage: $0 <theme>"
  echo
  echo "Available themes:"
  find "$HOME/.config/theme/themes" \
    -mindepth 1 -maxdepth 1 -type d \
    -printf '  %f\n' | sort
  exit 1
fi

if [[ ! -f "$THEME_FILE" ]]; then
  echo "Theme '$THEME' not found."
  exit 1
fi

# Load selected theme
source "$THEME_FILE"

# Update only theme-specific values
sed -i \
  -e "s|^PRIMARY=.*|PRIMARY=\"$PRIMARY\"|" \
  -e "s|^WALLPAPER=.*|WALLPAPER=\"$WALLPAPER\"|" \
  "$COLORS_FILE"

# Update kitty
cp "$THEME_DIR/kitty.conf" "$HOME/.config/kitty/current-theme.conf"

kitty @ load-config 2>/dev/null

#Update nvim
echo "$NVIM_THEME" >"$HOME/.config/theme/current-nvim-theme"

# Reload the UI
"$HOME/.config/scripts/reload-ui.sh"

echo "Switched to theme: $THEME"
