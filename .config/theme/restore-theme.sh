#!/usr/bin/env bash

CURRENT_THEME="$HOME/.config/theme/current-theme"

if [[ ! -f "$CURRENT_THEME" ]]; then
  exit 0
fi

THEME=$(<"$CURRENT_THEME")

if [[ -z "$THEME" ]]; then
  exit 0
fi

"$HOME/.config/theme/apply-theme.sh" "$THEME"
"$HOME/.config/theme/generate.sh"
"$HOME/.config/scripts/reload-ui.sh"
