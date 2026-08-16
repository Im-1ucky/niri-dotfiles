#!/usr/bin/env bash

# ---------- CPU (INTEGER ONLY) ----------
CPU_RAW=$(sensors | awk '/Package id 0:/ {print $4; exit}')
CPU_NUM=$(echo "$CPU_RAW" | tr -d '+°C' | awk '{printf "%.0f", $1}')

# Fallback if sensors fails
if [ -z "$CPU_NUM" ] || [ "$CPU_NUM" = "0" ]; then
  if [ -r /sys/class/thermal/thermal_zone0/temp ]; then
    RAW=$(cat /sys/class/thermal/thermal_zone0/temp)
    CPU_NUM=$(awk "BEGIN { printf \"%.0f\", $RAW/1000 }")
  else
    CPU_NUM="0"
  fi
fi

# ---------- NVMe (INTEGER ONLY) ----------
NVME_RAW=$(sensors | awk '/Composite:/ {print $2; exit}')
NVME_NUM=$(echo "$NVME_RAW" | tr -d '+°C' | awk '{printf "%.0f", $1}')
[ -z "$NVME_NUM" ] && NVME_NUM="N/A"

# ---------- External SSD (/dev/sda) ----------
SSD_NUM="N/A"
if command -v smartctl >/dev/null 2>&1; then
  T=$(sudo smartctl -a -d sat /dev/sda 2>/dev/null | awk '/Temperature_Celsius/ {print $NF; exit}')
  if [ -n "$T" ]; then
    SSD_NUM="$T"
  fi
fi

# ---------- FAN SPEEDS ----------
FAN1=$(sensors | awk '/fan1:/ {print $2; exit}')
FAN2=$(sensors | awk '/fan2:/ {print $2; exit}')

[ -z "$FAN1" ] && FAN1="N/A"
[ -z "$FAN2" ] && FAN2="N/A"

TOOLTIP="CPU: ${CPU_NUM}°C | NVMe: ${NVME_NUM}°C | SSD: ${SSD_NUM}°C\\nFan1: ${FAN1} RPM | Fan2: ${FAN2} RPM"

# ---------- Output JSON ----------
printf '{"text":"%s","tooltip":"%s"}\n' "$CPU_NUM" "$TOOLTIP"
