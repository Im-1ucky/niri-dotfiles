#!/bin/bash

source "$HOME/.config/theme/colors.sh"
source "$HOME/.config/theme/app.sh"

PRIMARY_HEX="${PRIMARY#\#}"
INACTIVE_HEX="${INACTIVE#\#}"

# -----------------------
# SwayNC
# -----------------------

cat >"$HOME/.config/swaync/generated-theme.css" <<EOF
@define-color primary $PRIMARY;
@define-color foreground $FOREGROUND;
@define-color red $RED;
EOF

# -----------------------
# Waybar
# -----------------------

cat >"$HOME/.config/waybar/generated-theme.css" <<EOF
@define-color primary $PRIMARY;
EOF

# -----------------------
# Kitty
# -----------------------

cat >"$HOME/.config/kitty/generated-theme.conf" <<EOF
# Generated from ~/.config/theme/colors.sh

cursor $PRIMARY
cursor_trail_color $PRIMARY
active_border_color $PRIMARY
EOF

# -----------------------
# Rofi
# -----------------------

cat >"$HOME/.config/rofi/generated-theme.rasi" <<EOF
* {
    primary: $PRIMARY;
    foreground: $FOREGROUND;
    urgent: $RED;
}
EOF

# -----------------------
# Rofi Power Menu
# -----------------------

cat >"$HOME/.config/rofi/generated-powermenu.rasi" <<EOF
* {
    primary: $PRIMARY;
}
EOF

# -----------------------
# Hyprland
# -----------------------

cat >"$HOME/.config/hypr/generated-theme.conf" <<EOF
\$primary = rgb(${PRIMARY#\#})
\$inactive = rgb(${INACTIVE#\#})

\$terminal = $TERMINAL
\$fileManager = $FILE_MANAGER
\$menu = $MENU -show drun
EOF

# -----------------------
# Niri
# -----------------------

cat >"$HOME/.config/niri/generated-theme.kdl" <<EOF
// Generated from ~/.config/theme/colors.sh

layout {
    focus-ring {
        active-color "$PRIMARY"
    }
}
EOF
