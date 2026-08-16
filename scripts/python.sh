#!/usr/bin/env bash

# If a virtual environment exists in this folder, use it
if [ -f ".venv/bin/python" ]; then
    exec .venv/bin/python "$@"
else
    exec /bin/python "$@"
fi
