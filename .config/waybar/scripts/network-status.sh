#!/usr/bin/env bash

# Check whether the internet is actually reachable
if curl -s --max-time 2 --connect-timeout 1 \
  https://connectivitycheck.gstatic.com/generate_204 \
  -o /dev/null -w "%{http_code}" | grep -q "204"; then
  INTERNET=true
else
  INTERNET=false
fi

# Check active Wi-Fi connection
WIFI_DEVICE=$(nmcli -t -f DEVICE,TYPE,STATE device |
  awk -F: '$2=="wifi" && $3=="connected" {print $1; exit}')

# Check active Ethernet connection
ETH_DEVICE=$(nmcli -t -f DEVICE,TYPE,STATE device |
  awk -F: '$2=="ethernet" && $3=="connected" {print $1; exit}')

if [[ -n "$WIFI_DEVICE" ]]; then
  ESSID=$(nmcli -t -f ACTIVE,SSID device wifi |
    awk -F: '$1=="yes" {print substr($0,5); exit}')

  if [[ "$INTERNET" == true ]]; then
    echo "  $ESSID"
  else
    echo "  $ESSID"
  fi

  echo " $IP"
elif [[ -n "$ETH_DEVICE" ]]; then
  IP=$(nmcli -g IP4.ADDRESS device show "$ETH_DEVICE" |
    head -n1 | cut -d/ -f1)

  if [[ "$INTERNET" == true ]]; then
    echo "󰈁  $IP"
  else
    echo "  $IP"
  fi

else
  echo "󰖪"
fi
