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
    if [ -x "$HOME/.config/swaylock/lock.sh" ]; then
      "$HOME/.config/swaylock/lock.sh"
    else
      notify-send "Lockscreen not available"
    fi
    ;;

  "$reboot")
    systemctl reboot
    ;;

  "$shutdown")
    systemctl poweroff
    ;;

  "$logout")
    if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
      hyprctl dispatch exit
    elif [ -n "$NIRI_SOCKET" ]; then
      niri msg quit
    else
      notify-send "Unknown compositor"
    fi
    ;;

  *)
    exit 0
    ;;
esac
