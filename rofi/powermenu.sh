#!/usr/bin/env bash

lock=""
reboot=""
shutdown=""
logout="󰍃"

options="$lock\n$reboot\n$shutdown\n$logout"

choice="$(printf "%b" "$options" | rofi -dmenu \
  -p "Power" \
  -theme ~/.config/rofi/powermenu.rasi)"

case "$choice" in
  "$lock")
    if command -v hyprlock >/dev/null 2>&1; then
      hyprlock
    elif command -v swaylock >/dev/null 2>&1; then
      swaylock
    else
      notify-send "Lockscreen not available" "Install hyprlock or swaylock to use the lock option."
    fi
    ;;
  "$reboot")
    systemctl reboot
    ;;
  "$shutdown")
    systemctl poweroff
    ;;
  "$logout")
    if command -v hyprctl >/dev/null 2>&1 && hyprctl version >/dev/null 2>&1; then
      hyprctl dispatch exit
    else
      niri msg action quit
    fi
    ;;
  *)
    exit 0
    ;;
esac
