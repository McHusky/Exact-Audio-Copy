#!/usr/bin/env bash
set -euo pipefail

export WINEARCH="${WINEARCH:-win32}"
export WINEPREFIX="${WINEPREFIX:-/config/.wine32}"
export DISPLAY="${DISPLAY:-:0}"

Xvfb :0 -screen 0 1280x800x24 &
XVFB_PID=$!
sleep 2

wineboot -i
sleep 10

winetricks -q corefonts

wineserver -w || true
kill "$XVFB_PID" || true
