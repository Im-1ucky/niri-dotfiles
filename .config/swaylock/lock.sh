#!/bin/bash

swaylock \
  --screenshots \
  --indicator \
  --indicator-radius 100 \
  --indicator-thickness 8 \
  --effect-blur 8x5 \
  --ring-color ffffff \
  --inside-color 5f514e88 \
  --line-color 00000000 \
  --separator-color 00000000 \
  --text-color 00000000 \
  --font-size 0 \
  --key-hl-color 5f514e \
  --bs-hl-color 5f514e \
  --ring-ver-color 5f514e \
  --inside-ver-color 5f514e88 \
  --line-ver-color 5f514e \
  --text-ver-color 00000000 \
  --text-clear-color 00000000 \
  --text-wrong-color 00000000 \
  --ring-wrong-color ff4444 \
  --inside-wrong-color ff4444 \
  --line-wrong-color ff4444


# THIS RUNS AFTER UNLOCK
~/.config/swaylock/brightness.sh restore
powerprofilesctl set balanced
niri msg action power-on-monitors
