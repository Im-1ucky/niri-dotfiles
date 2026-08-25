#!/usr/bin/env bash

source ~/.config/theme/apps.sh

choice=$(printf " Power Off\n Reboot\n Suspend\n󰍃 Logout" | "$MENU" -dmenu -i -p "System")

case "$choice" in
" Power Off") systemctl poweroff ;;
" Reboot") systemctl reboot ;;
" Suspend") systemctl suspend ;;
" Logout") hyprctl dispatch exit ;;
esac
