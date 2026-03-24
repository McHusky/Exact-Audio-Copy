#!/usr/bin/env bash
set -euo pipefail

export DISPLAY="${DISPLAY:-:0}"
export WINEPREFIX="${WINEPREFIX:-/config/.wine32}"
export HOME="${HOME:-/config/home}"

mkdir -p "$HOME/.fluxbox"

if [ ! -f "$HOME/.fluxbox/init" ]; then
  fluxbox -i > "$HOME/.fluxbox/init" 2>/dev/null || true
fi

if grep -q '^session.screen0.toolbar.visible:' "$HOME/.fluxbox/init"; then
  sed -i 's/^session.screen0.toolbar.visible:.*/session.screen0.toolbar.visible: false/' "$HOME/.fluxbox/init"
else
  printf '\nsession.screen0.toolbar.visible: false\n' >> "$HOME/.fluxbox/init"
fi

Xvfb :0 -screen 0 1280x800x24 &
sleep 2

fluxbox &
x11vnc -display :0 -forever -shared -rfbport 5900 -nopw &
websockify --web=/usr/share/novnc/ 8080 localhost:5900 &
sleep 3

wine "/config/.wine32/drive_c/Program Files/Exact Audio Copy/EAC.exe" &
sleep 8

wmctrl -r "Exact Audio Copy" -b add,maximized_vert,maximized_horz || true

wait -n
