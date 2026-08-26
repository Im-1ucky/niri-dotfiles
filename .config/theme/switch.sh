#!/usr/bin/env bash

THEME="$1"
THEMES_DIR="$HOME/.config/theme/themes"

if [[ -z "$THEME" ]]; then
  echo "Usage: $0 <theme>"
  echo
  echo "Available themes:"
  find "$THEMES_DIR" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -printf '  %f\n' |
    sort
  exit 1
fi

if [[ ! -d "$THEMES_DIR/$THEME" ]]; then
  echo "Theme '$THEME' not found."
  exit 1
fi

# Apply selected theme
"$HOME/.config/theme/apply-theme.sh" "$THEME"

# Reload UI
"$HOME/.config/scripts/reload-ui.sh"

echo "Switched to theme: $THEME"
