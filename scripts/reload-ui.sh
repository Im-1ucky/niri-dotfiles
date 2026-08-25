#!/usr/bin/env bash

# Regenerate theme files
~/.config/theme/generate.sh

echo "Theme reloaded at $(date)" >>/tmp/reload-test.log

# Kill UI components that need a full restart
pkill -x waybar 2>/dev/null
pkill -x rofi 2>/dev/null
pkill -x swaync 2>/dev/null
pkill -x swaybg 2>/dev/null
pkill -x swayidle 2>/dev/null

sleep 1

# Relaunch UI components
waybar >/dev/null 2>&1 &
swaync >/dev/null 2>&1 &

# Reload Kitty without killing existing terminals
kitty @ load-config 2>/dev/null

# Run your existing startup script
~/.config/scripts/run.sh >/dev/null 2>&1 &

# Relaunch wallpaper
swaybg -i "/home/luckyarch/Photos/Wallpapers/root.png" -m fill >/dev/null 2>&1 &

# Restart persistent clipboard
systemctl --user restart cliphist

# Reload Hyprland if running
if pgrep -x Hyprland >/dev/null; then
  hyprctl reload
fi

# Reload Niri if running
if pgrep -x niri >/dev/null; then
  niri msg action do-screen-transition
fi
