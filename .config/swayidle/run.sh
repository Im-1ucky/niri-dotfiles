#!/bin/bash

swayidle -w \
  timeout 60 "$HOME/.config/swaylock/brightness.sh" \
  resume "$HOME/.config/swaylock/brightness.sh restore" \
  timeout 120 "$HOME/.config/swaylock/lock.sh" \
  resume "niri msg action power-on-monitors" \
  before-sleep "$HOME/.config/swaylock/lock.sh"
