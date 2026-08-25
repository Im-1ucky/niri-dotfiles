#!/bin/bash

source ~/.config/theme/colors.sh

swaylock -f \
  --screenshots \
  --indicator \
  --indicator-radius 100 \
  --indicator-thickness 8 \
  --effect-blur 8x5 \
  --ring-color ffffff \
  --inside-color "${PRIMARY#\#}88" \
  --line-color 00000000 \
  --separator-color 00000000 \
  --text-color 00000000 \
  --font-size 0 \
  --key-hl-color "${PRIMARY#\#}" \
  --bs-hl-color "${PRIMARY#\#}" \
  --ring-ver-color "${PRIMARY#\#}" \
  --inside-ver-color "${PRIMARY#\#}88" \
  --line-ver-color "${PRIMARY#\#}" \
  --text-ver-color 00000000 \
  --text-clear-color 00000000 \
  --text-wrong-color 00000000 \
  --ring-wrong-color ff4444 \
  --inside-wrong-color ff4444 \
  --line-wrong-color ff4444
