#!/usr/bin/env bash

HEADPHONE_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"
SPEAKER_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"

BT_SINK=$(pactl list short sinks | awk '$2 ~ /^bluez_output\./ {print $2; exit}')

move_streams() {
  local sink="$1"

  pactl set-default-sink "$sink"

  pactl list short sink-inputs |
    awk '{print $1}' |
    while read -r stream; do
      pactl move-sink-input "$stream" "$sink"
    done
}

if [[ -n "$BT_SINK" ]]; then
  move_streams "$BT_SINK"
  echo "  BT"
  exit 0
fi

if pactl list short sinks | grep -Fq "$HEADPHONE_SINK"; then
  move_streams "$HEADPHONE_SINK"
  echo "  HP"
  exit 0
fi

move_streams "$SPEAKER_SINK"
echo "  SPK"
