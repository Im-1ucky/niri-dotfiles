# LinuxDE

> My personal **Arch Linux desktop environment** and dotfiles — built around **Niri + Hyprland**, with a terminal-first workflow and a minimal, cohesive UI.

---

## ✨ Overview

LinuxDE is my personal Linux desktop configuration, combining two Wayland compositors with a collection of tools for everyday use, development, system management, and customization.

The overall design uses a **dark brown / charcoal palette**, teal accents, and pastel terminal colors.

---

## 📸 Screenshots

| | |
|:---:|:---:|
| ![Screenshot 1](screenshots/1.png) | ![Screenshot 2](screenshots/2.png) |
|**System & Terminal Information** — Customized Fastfetch providing system information alongside a customized terminal, showcasing the terminal-focused environment.| **Neovim / LazyVim** — The development setup featuring Neovim with LazyVim, along with the bash Kitty terminal. |
| ![Screenshot 3](screenshots/3.png) | ![Screenshot 4](screenshots/4.png) |
| **Rofi & SwayNC** — Rofi provides the application launcher, while SwayNC handles notifications and quick system controls. | **Waybar & Powermenu** — The customized Waybar provides system information and controls, including the Rofi-based powermenu for session actions. |

## 🔧 Script Management

All runtime shell scripts are centralized in:

```text
~/.config/scripts/
```

Instead of keeping scripts inside individual application directories such as Waybar, Swaylock, or Rofi, they are maintained in one location.

The repository sync script is:

```bash
~/niri-dotfiles/scripts/sync.sh
```

### Sync workflow

```text
┌─────────────────────┐
│     ~/.config/      │
│  Live configuration │
└──────────┬──────────┘
           │
           │ sync.sh
           ▼
┌─────────────────────┐
│   ~/niri-dotfiles/  │
│      Git repo       │
└──────────┬──────────┘
           │
           ▼
       git add .
           │
           ▼
      git commit
           │
           ▼
       git push
```
---

## 📦 Package Lists

The repository keeps separate package lists for official Arch packages and AUR packages.

| File | Description |
|:---|:---|
| `pkglist.txt` | Official Arch packages |
| `aurlist.txt` | AUR packages |

Regenerate them with:

```bash
pacman -Qqe > pkglist.txt
pacman -Qqem > aurlist.txt
```

---

## 🚀 Installation

> These dotfiles are primarily built for my personal Arch Linux setup. Review the configuration before applying it to another system, especially hardware-specific settings.

### 1. Clone the repository

```bash
git clone https://github.com/Im-1ucky/niri-dotfiles.git
cd niri-dotfiles
```

### 2. Back up your existing configuration

Before copying anything, create a backup of your current configuration:

```bash
cp -r ~/.config ~/.config.backup
```

### 3. Copy the configurations

Copy the repository's `.config` contents into your home configuration directory:

```bash
cp -r .config/* ~/.config/
```

### 4. Install the scripts

All runtime scripts are stored in the repository's `scripts/` directory.

Copy them to the central scripts directory:

```bash
mkdir -p ~/.config/scripts
cp scripts/*.sh ~/.config/scripts/
```

Make them executable:

```bash
chmod +x ~/.config/scripts/*.sh
```

### 5. Install the packages

The repository contains package lists for both official Arch packages and AUR packages.

Install the official packages:

```bash
sudo pacman -S --needed - < pkglist.txt
```

Install the AUR packages using your preferred AUR helper, for example:

```bash
paru -S --needed - < aurlist.txt
```

> Review `pkglist.txt` and `aurlist.txt` before installing. Some packages may be unnecessary or incompatible with another system.
### 6. Restart

Restart your system to ensure all configurations and services are loaded correctly:

```bash
reboot
```

After restarting, the new desktop environment and configurations should be active.

## 🧩 Components

| Component | Purpose |
|:--|:--|
| **Niri** | Scrollable-tiling Wayland compositor |
| **Hyprland** | Dynamic-tiling Wayland compositor |
| **Waybar** | System status bar |
| **SwayNC** | Notifications and quick controls |
| **Kitty** | Terminal emulator |
| **Rofi** | Application launcher and power menu |
| **Neovim / LazyVim** | Code editor |
| **Yazi** | Terminal file manager |
| **Swaylock** | Screen locking |
| **Swayidle** | Idle and display power management |
| **Swaybg** | Wallpaper |
| **Starship** | Shell prompt |
| **Fastfetch** | System information |
| **btop** | Resource monitor |

---

## 🖥️ Desktop Philosophy

It is built around a few simple ideas:

- **Keyboard first** — minimize unnecessary mouse interaction.
- **Terminal first** — prefer powerful CLI tools where practical.
- **Minimal UI** — keep the desktop clean and distraction-free.
- **Centralized scripts** — keep reusable runtime scripts in one place.
- **Reproducible configuration** — keep the environment version-controlled.
- **Flexible compositor setup** — maintain configurations for both Niri and Hyprland.
