#!/usr/bin/env bash

SPEAKER_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"
USB_SINK="alsa_output.usb-JieLi_Technology_USB_Audio_2023.06.20-00.analog-stereo"

move_streams() {
  local sink="$1"

  pactl set-default-sink "$sink" || return 1

  pactl list short sink-inputs |
    awk '{print $1}' |
    while read -r stream; do
      pactl move-sink-input "$stream" "$sink" 2>/dev/null
    done
}

# 1. Bluetooth
BT_SINK=$(pactl list short sinks |
  awk '$2 ~ /^bluez_output\./ {print $2; exit}')

if [[ -n "$BT_SINK" ]]; then
  move_streams "$BT_SINK"
  echo "  BT"
  exit 0
fi

# 2. 3.5mm headphones
HEADPHONE_SINK=$(pactl list short sinks |
  awk '$2 ~ /Headphones/ {print $2; exit}')

if [[ -n "$HEADPHONE_SINK" ]]; then
  move_streams "$HEADPHONE_SINK"
  echo "  HP"
  exit 0
fi

# 3. USB-C audio
if pactl list short sinks | grep -Fq "$USB_SINK"; then
  move_streams "$USB_SINK"
  echo "󰋋  USB"
  exit 0
fi

# 4. Laptop speakers
if pactl list short sinks | grep -Fq "$SPEAKER_SINK"; then
  move_streams "$SPEAKER_SINK"
  echo "  SPK"
  exit 0
fi

echo "No audio output"
exit 1
