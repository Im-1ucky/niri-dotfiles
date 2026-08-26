#!/usr/bin/env bash

set -e

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

INSTALL_PACKAGES=false

if [[ "$1" == "--packages" ]]; then
  INSTALL_PACKAGES=true
fi

echo "Installing niri-dotfiles..."
echo "Repository: $REPO"
echo "Home:       $HOME"
echo

# -----------------------
# Backup
# -----------------------

BACKUP="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

echo "Creating backup at:"
echo "$BACKUP"
echo

mkdir -p "$BACKUP"

# -----------------------
# .config
# -----------------------

echo "Installing .config..."

mkdir -p "$CONFIG_DIR"

for dir in "$REPO/.config"/*; do
  name="$(basename "$dir")"

  if [[ -e "$CONFIG_DIR/$name" ]]; then
    mv "$CONFIG_DIR/$name" "$BACKUP/"
  fi

  cp -r "$dir" "$CONFIG_DIR/"
done

# -----------------------
# Scripts
# -----------------------

echo "Installing scripts..."

mkdir -p "$CONFIG_DIR/scripts"

cp -r "$REPO/scripts/." "$CONFIG_DIR/scripts/"

chmod +x "$CONFIG_DIR/scripts/"*.sh 2>/dev/null || true
chmod +x "$CONFIG_DIR/theme/"*.sh 2>/dev/null || true

# -----------------------
# Root config files
# -----------------------

echo "Installing root config files..."

cp "$REPO/mimeapps.list" "$HOME/"

if [[ -f "$REPO/starship.toml" ]]; then
  cp "$REPO/starship.toml" "$HOME/.config/"
fi

if [[ -f "$REPO/dolphinrc" ]]; then
  cp "$REPO/dolphinrc" "$HOME/.config/"
fi

# -----------------------
# Theme system
# -----------------------

echo "Setting up theme system..."

mkdir -p "$CONFIG_DIR/theme"

# Use Groot as the initial theme on a fresh install.
if [[ ! -f "$CONFIG_DIR/theme/current-theme" ]]; then
  "$CONFIG_DIR/theme/apply-theme.sh" groot
fi

# Generate runtime theme files.
"$CONFIG_DIR/theme/generate.sh"

# -----------------------
# Optional packages
# -----------------------

if [[ "$INSTALL_PACKAGES" == true ]]; then

  echo
  echo "Installing packages..."

  # -----------------------
  # Official Arch packages
  # -----------------------

  if [[ -f "$REPO/pkglist.txt" ]]; then
    echo
    echo "Installing official Arch packages..."

    sudo pacman -S --needed - <"$REPO/pkglist.txt"
  fi

  # -----------------------
  # AUR packages
  # -----------------------

  if [[ -f "$REPO/aurlist.txt" ]]; then

    if command -v yay >/dev/null 2>&1; then

      echo
      echo "Installing AUR packages using yay..."

      yay -S --needed - <"$REPO/aurlist.txt"

    elif command -v paru >/dev/null 2>&1; then

      echo
      echo "Installing AUR packages using paru..."

      paru -S --needed - <"$REPO/aurlist.txt"

    else

      echo
      echo "No AUR helper found."
      echo "Install yay or paru, then run:"
      echo
      echo "  yay -S --needed - < aurlist.txt"
      echo
      echo "or:"
      echo
      echo "  paru -S --needed - < aurlist.txt"
      echo
      echo "Skipping AUR packages."

    fi
  fi

  # -----------------------
  # Flatpak applications
  # -----------------------

  if [[ -f "$REPO/flatpaklist.txt" ]]; then

    if command -v flatpak >/dev/null 2>&1; then

      echo
      echo "Installing Flatpak applications..."

      while IFS= read -r app; do
        [[ -z "$app" ]] && continue

        flatpak install -y flathub "$app"
      done <"$REPO/flatpaklist.txt"

    else

      echo
      echo "Flatpak is not installed."
      echo "Skipping Flatpak applications."

    fi
  fi

  # -----------------------
  # Global npm packages
  # -----------------------

  if [[ -f "$REPO/npmlist.txt" ]]; then

    if command -v npm >/dev/null 2>&1; then

      echo
      echo "Installing global npm packages..."

      while IFS= read -r package; do
        [[ -z "$package" ]] && continue

        npm install -g "$package"
      done <"$REPO/npmlist.txt"

    else

      echo
      echo "npm is not installed."
      echo "Skipping global npm packages."

    fi
  fi
fi

# -----------------------
# Done
# -----------------------

echo
echo "Installation complete."
echo
echo "Backup:"
echo "$BACKUP"

if [[ "$INSTALL_PACKAGES" == false ]]; then
  echo
  echo "Packages were not installed."
  echo "To install packages later, run:"
  echo
  echo "  ./install.sh --packages"
fi
