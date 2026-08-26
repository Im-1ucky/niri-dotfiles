#!/bin/bash

source ~/.config/theme/colors.sh
source ~/.config/theme/app.sh

# Remove # from hex values where needed
PRIMARY_HEX="${PRIMARY#\#}"
INACTIVE_HEX="${INACTIVE#\#}"

mkdir -p ~/.config/theme/generated

# SwayNC
cat >~/.config/theme/generated/swaync.css <<EOF
@define-color primary $PRIMARY;
@define-color foreground $FOREGROUND;
@define-color red $RED;
EOF

# Waybar
cat >~/.config/theme/generated/waybar.css <<EOF
@define-color primary $PRIMARY;
EOF

# Kitty
cat >~/.config/theme/generated/kitty.conf <<EOF
# Generated from ~/.config/theme/colors.sh

cursor $PRIMARY
cursor_trail_color $PRIMARY
active_border_color $PRIMARY
EOF

# Rofi
cat >~/.config/theme/generated/rofi.rasi <<EOF
* {
    primary: $PRIMARY;
    foreground: $FOREGROUND;
    urgent: $RED;
}
EOF

# Rofi Power Menu
cat >~/.config/theme/generated/powermenu.rasi <<EOF
* {
    primary: $PRIMARY;
}
EOF

# Hyprland
cat >~/.config/theme/generated/hyprland.conf <<EOF
\$primary = rgb(${PRIMARY#\#})
\$inactive = rgb(${INACTIVE#\#})

\$terminal = $TERMINAL
\$fileManager = $FILE_MANAGER
\$menu = $MENU -show drun
EOF

# Niri colors
cat >~/.config/theme/generated/niri.kdl <<EOF
// Generated from ~/.config/theme/colors.sh

layout {
    focus-ring {
        active-color "$PRIMARY"
    }
}
EOF
