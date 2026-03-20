#!/usr/bin/env bash

# --- DEVICE NAMES ---
BT_SINK="bluez_output.41_42_57_94_33_A7.1"
HEADPHONE_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"
SPEAKER_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"

# --- Detect Bluetooth ---
BT_CONNECTED=$(pactl list short sinks | grep "$BT_SINK")

# --- Detect headphones ---
HP_CONNECTED=$(pactl list short sinks | grep "$HEADPHONE_SINK")

# ----------------------------------------------------
# PRIORITY ORDER:
# 1. Bluetooth
# 2. Wired Headphones (3.5mm)
# 3. Speakers (default)
# ----------------------------------------------------

if [[ -n "$BT_CONNECTED" ]]; then
    pactl set-default-sink "$BT_SINK"
    echo "  BT"
    exit 0
fi

if [[ -n "$HP_CONNECTED" ]]; then
    pactl set-default-sink "$HEADPHONE_SINK"
    echo "  HP"
    exit 0
fi

# Fallback → speakers
pactl set-default-sink "$SPEAKER_SINK"
echo "  SPK"
exit 0
