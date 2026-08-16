#!/usr/bin/env bash

FILE="$ZED_FILE"

if [ -z "$FILE" ]; then
  echo "❌ ZED_FILE is empty"
  exit 1
fi

DIR="$(dirname "$FILE")"
NAME="$(basename "$FILE")"

echo "[Running] $FILE"
cd "$DIR" || exit 1
python "$NAME"
