#!/usr/bin/env bash

BAT="/sys/class/power_supply/BAT0"

CAP=$(cat "$BAT/capacity")
STATUS=$(cat "$BAT/status")
PROFILE=$(powerprofilesctl get)

ICON=""
CLASS="normal"

if [ "$STATUS" = "Charging" ]; then
    ICON="󱐌"
else
    if [ "$CAP" -le 20 ]; then
        ICON=""
    elif [ "$CAP" -le 50 ]; then
        ICON=""
    elif [ "$CAP" -le 75 ]; then
        ICON=""
    else
        ICON=""
    fi
fi

case "$PROFILE" in
    "performance")
        CLASS="performance"
        PROFILE_NAME="Performance"
        ;;
    "balanced")
        CLASS="balanced"
        PROFILE_NAME="Balanced"
        ;;
    "power-saver")
        CLASS="power-saver"
        PROFILE_NAME="Power Saver"
        ;;
    *)
        CLASS="unknown"
        PROFILE_NAME="Unknown"
        ;;
esac

if [[ "$1" == "--switch" ]]; then
    case "$PROFILE" in
        performance) powerprofilesctl set balanced ;;
        balanced) powerprofilesctl set power-saver ;;
        power-saver) powerprofilesctl set performance ;;
    esac
    exit 0
fi

TIME_STR="N/A"

if command -v acpi >/dev/null 2>&1; then
    ACPI_OUT=$(acpi -b 2>/dev/null | head -n1)
    TIME_RAW=$(echo "$ACPI_OUT" | grep -oE '[0-9]{1,2}:[0-9]{2}(:[0-9]{2})?')
    if [ -n "$TIME_RAW" ]; then
        TIME_STR="$TIME_RAW"
    fi
fi


TOOLTIP="Mode: $PROFILE_NAME\\nStatus: $STATUS\\nTime: $TIME_STR"


STATE_DIR="$HOME/.cache/battery_notify"
mkdir -p "$STATE_DIR"

notify_once() {
    local level="$1"
    local message="$2"
    local flag="$STATE_DIR/$level"

    if [ ! -f "$flag" ]; then
        notify-send -u critical "🔋 Battery Low" "$message"
        touch "$flag"
    fi
}

# Reset notifications when charging
if [ "$STATUS" = "Charging" ]; then
    rm -f "$STATE_DIR/"*
fi

# Trigger notifications
if [ "$STATUS" != "Charging" ]; then
    if [ "$CAP" -le 10 ]; then
        notify_once "10" "Battery at ${CAP}% — plug in immediately!"
    elif [ "$CAP" -le 20 ]; then
        notify_once "20" "Battery at ${CAP}% — consider charging."
    fi
fi


echo "{\"text\":\"$ICON $CAP%\", \"tooltip\":\"$TOOLTIP\", \"class\":\"$CLASS\"}"
