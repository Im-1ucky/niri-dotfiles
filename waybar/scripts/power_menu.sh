#!/usr/bin/env bash

choice=$(printf " Power Off\n Reboot\n Suspend\n󰍃 Logout" | rofi -dmenu -i -p "System")

case "$choice" in
  " Power Off") systemctl poweroff ;;
  " Reboot") systemctl reboot ;;
  " Suspend") systemctl suspend ;;
  " Logout") hyprctl dispatch exit ;;
esac
