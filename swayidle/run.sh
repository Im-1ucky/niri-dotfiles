#!/bin/bash

swayidle -w \
 timeout 60 "powerprofilesctl set power-saver && ~/.config/swaylock/brightness.sh dim" \
 timeout 120 "~/.config/swaylock/lock.sh" \
 timeout 180 "niri msg dpms off" \
 resume "~/.config/swaylock/brightness.sh restore && powerprofilesctl set balanced" \
 resume "niri msg dpms on"
