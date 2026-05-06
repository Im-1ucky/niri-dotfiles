#!/usr/bin/env bash
echo "Ran at $(date)" >> /tmp/reload-test.log

# Kill running instances safely
pkill -x waybar 2>/dev/null
pkill -x rofi 2>/dev/null
pkill -x swaync 2>/dev/null
pkill -x swaybg 2>/dev/null
pkill -x kitty 2>/dev/null

sleep 1

# Relaunch components
waybar >/dev/null 2>&1 &
swaync >/dev/null 2>&1 &

# Relaunch wallpaper
swaybg -i "/home/luckyarch/Photos/Wallpapers/root.png" -m fill >/dev/null 2>&1 &

# Restart persistent clipboard
systemctl --user restart cliphist

# Reload niri config
niri msg action do-screen-transition
