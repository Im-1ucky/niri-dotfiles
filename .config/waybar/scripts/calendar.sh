#!/usr/bin/env bash

CAL="gsimplecal"

# If open → close and exit
if pgrep -x "$CAL" >/dev/null; then
  pkill -x "$CAL"
  exit 0
fi

# Get cursor X
read -r CURSOR_X CURSOR_Y <<< "$(hyprctl cursorpos | tr -d ',')"

BAR_HEIGHT=32
CAL_WIDTH=260
CAL_HEIGHT=230
X_OFFSET=$((CAL_WIDTH / 2))
Y_OFFSET=6

FINAL_X=$((CURSOR_X - X_OFFSET))
FINAL_Y=$((BAR_HEIGHT + Y_OFFSET))

# Spawn calendar
hyprctl dispatch exec "[float; size $CAL_WIDTH $CAL_HEIGHT; move $FINAL_X $FINAL_Y]" "$CAL"

# --- GLOBAL CLICK TO CLOSE ---
(
  # wait for calendar to fully map
  sleep 0.1

  # listen for the next pointer click
  hyprctl --batch "subscribeevents input" |
  while read -r line; do
    if echo "$line" | grep -q "pointer_button"; then
      pkill -x "$CAL"
      break
    fi
  done
) &
