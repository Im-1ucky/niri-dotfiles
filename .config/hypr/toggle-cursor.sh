#!/bin/bash
# Replace "Your Mouse Name" with the name from 'libinput list-devices'
DEVICE="Your Mouse Name"

# Check current status (0 = enabled, 1 = disabled)
STATUS=$(libinput quirks list "$DEVICE" --get-prop "libinput Send Events")

if [ "$STATUS" == "0" ]; then
    # If it's ON, turn it OFF
    libinput quirks list "$DEVICE" --set-prop "libinput Send Events" 1
else
    # If it's OFF, turn it ON
    libinput quirks list "$DEVICE" --set-prop "libinput Send Events" 0
fi
