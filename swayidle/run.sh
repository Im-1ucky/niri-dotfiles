#!/bin/bash

swayidle -w \
 timeout 60 "~/.config/swaylock/brightness.sh" \
 resume "~/.config/swaylock/brightness.sh restore" \
 timeout 120 "~/.config/swaylock/lock.sh" \
 timeout 180 "niri msg action power-off-monitors" \
 before-sleep "~/.config/swaylock/lock.sh"
