#!/bin/bash

set -e

REPO="$HOME/niri-dotfiles"

echo "Syncing configs..."

# -----------------------
# .config
# -----------------------

mkdir -p "$REPO/.config"

cp -r ~/.config/btop "$REPO/.config/"
cp -r ~/.config/fastfetch "$REPO/.config/"
cp -r ~/.config/ghostty "$REPO/.config/"
cp -r ~/.config/gtk-3.0 "$REPO/.config/"
cp -r ~/.config/gtk-4.0 "$REPO/.config/"
cp -r ~/.config/hypr "$REPO/.config/"
cp -r ~/.config/kitty "$REPO/.config/"
cp -r ~/.config/Kvantum "$REPO/.config/"
cp -r ~/.config/nemo "$REPO/.config/"
cp -r ~/.config/niri "$REPO/.config/"
cp -r ~/.config/nvim "$REPO/.config/"
cp -r ~/.config/nwg-look "$REPO/.config/"
cp -r ~/.config/qt5ct "$REPO/.config/"
cp -r ~/.config/rofi "$REPO/.config/"
cp -r ~/.config/sway "$REPO/.config/"
cp -r ~/.config/swayidle "$REPO/.config/"
cp -r ~/.config/swaylock "$REPO/.config/"
cp -r ~/.config/swaync "$REPO/.config/"
cp -r ~/.config/waybar "$REPO/.config/"
cp -r ~/.config/yazi "$REPO/.config/"

# -----------------------
# Root config files
# -----------------------

cp ~/.config/mimeapps.list "$REPO/"
cp ~/.config/starship.toml "$REPO/" 2>/dev/null || true
cp ~/.config/dolphinrc "$REPO/" 2>/dev/null || true

# -----------------------
# Package lists
# -----------------------

pacman -Qqe >"$REPO/pkglist.txt"
pacman -Qqem >"$REPO/aurlist.txt"

echo "Sync complete."
