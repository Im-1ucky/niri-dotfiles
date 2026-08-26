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
rm -f "$REPO/.config/hypr/generated-theme.conf"

# Kitty - exclude runtime-generated/selected theme
rm -rf "$REPO/.config/kitty"
mkdir -p "$REPO/.config/kitty"
cp -r ~/.config/kitty/. "$REPO/.config/kitty/"
rm -f "$REPO/.config/kitty/current-theme.conf"
rm -f "$REPO/.config/kitty/generated-theme.conf"

cp -r ~/.config/Kvantum "$REPO/.config/"

# Niri
rm -rf "$REPO/.config/niri"
mkdir -p "$REPO/.config/niri"
cp -r ~/.config/niri/. "$REPO/.config/niri/"
rm -f "$REPO/.config/niri/generated-theme.kdl"

cp -r ~/.config/nvim "$REPO/.config/"
cp -r ~/.config/nwg-look "$REPO/.config/"
cp -r ~/.config/qt5ct "$REPO/.config/"

# Rofi
rm -rf "$REPO/.config/rofi"
mkdir -p "$REPO/.config/rofi"
cp -r ~/.config/rofi/. "$REPO/.config/rofi/"
rm -f "$REPO/.config/rofi/generated-theme.rasi"
rm -f "$REPO/.config/rofi/generated-powermenu.rasi"

# SwayNC
rm -rf "$REPO/.config/swaync"
mkdir -p "$REPO/.config/swaync"
cp -r ~/.config/swaync/. "$REPO/.config/swaync/"
rm -f "$REPO/.config/swaync/generated-theme.css"

# Waybar
rm -rf "$REPO/.config/waybar"
mkdir -p "$REPO/.config/waybar"
cp -r ~/.config/waybar/. "$REPO/.config/waybar/"
rm -f "$REPO/.config/waybar/generated-theme.css"

cp -r ~/.config/yazi "$REPO/.config/"

# -----------------------
# Theme system
# -----------------------

rm -rf "$REPO/.config/theme"
mkdir -p "$REPO/.config/theme"

cp ~/.config/theme/app.sh "$REPO/.config/theme/"
cp ~/.config/theme/colors.sh "$REPO/.config/theme/"
cp ~/.config/theme/generate.sh "$REPO/.config/theme/"
cp ~/.config/theme/switch.sh "$REPO/.config/theme/"
cp ~/.config/theme/theme-menu.sh "$REPO/.config/theme/"
cp ~/.config/theme/apply-theme.sh "$REPO/.config/theme/"
cp ~/.config/theme/restore-theme.sh "$REPO/.config/theme/"
cp -r ~/.config/theme/themes "$REPO/.config/theme/"

# -----------------------
# Scripts
# -----------------------

mkdir -p "$REPO/scripts"

find ~/.config/scripts -maxdepth 1 -type f -name "*.sh" ! -name "sync.sh" \
  -exec cp {} "$REPO/scripts/" \;

# -----------------------
# Root config files
# -----------------------

cp ~/.config/mimeapps.list "$REPO/"
cp ~/.config/starship.toml "$REPO/" 2>/dev/null || true
cp ~/.config/dolphinrc "$REPO/" 2>/dev/null || true

# -----------------------
# Package lists
# -----------------------

echo "Updating package lists..."

# Official Arch packages
pacman -Qqe >"$REPO/pkglist.txt"

# AUR packages
pacman -Qqem >"$REPO/aurlist.txt"

# Flatpak applications
if command -v flatpak >/dev/null 2>&1; then
  flatpak list --app --columns=application | sort >"$REPO/flatpaklist.txt"
else
  echo "Flatpak not installed, skipping flatpaklist.txt"
fi

# Global npm packages
if command -v npm >/dev/null 2>&1; then
  npm list -g --depth=0 --parseable 2>/dev/null |
    tail -n +2 |
    sed 's|.*/node_modules/||' |
    sort >"$REPO/npmlist.txt"
else
  echo "npm not installed, skipping npmlist.txt"
fi

echo "Package lists updated."
