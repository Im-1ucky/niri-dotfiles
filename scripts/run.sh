#!/bin/bash

swayidle -w \
  timeout 60 "$HOME/.config/scripts/dim-brightness.sh" \
    resume "$HOME/.config/scripts/dim-brightness.sh restore" \
  timeout 120 "$HOME/.config/scripts/lock.sh" \
  timeout 180 "niri msg action power-off-monitors" \
    resume "niri msg action power-on-monitors" \
  before-sleep "$HOME/.config/scripts/lock.sh"
