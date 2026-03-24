#!/usr/bin/env bash
set -u

export WINEARCH="${WINEARCH:-win32}"
export WINEPREFIX="${WINEPREFIX:-/config/.wine32}"
export DISPLAY="${DISPLAY:-:0}"
export HOME="${HOME:-/config/home}"
export CDROM_DEVICE="${CDROM_DEVICE:-/dev/sr0}"
export SG_DEVICE="${SG_DEVICE:-/dev/sg1}"
export CDROM_MOUNT="${CDROM_MOUNT:-/mnt/cdrom}"

mkdir -p /config /output /input "$HOME" "$CDROM_MOUNT"
mkdir -p "$WINEPREFIX/dosdevices"

# Nur initialisieren, wenn wirklich noch kein brauchbares Prefix da ist
if [ ! -d "$WINEPREFIX/drive_c" ]; then
  /usr/local/bin/setup-prefix.sh
fi

chmod 666 "$CDROM_DEVICE" 2>/dev/null || true
chmod 666 "$SG_DEVICE" 2>/dev/null || true

mountpoint -q "$CDROM_MOUNT" || mount "$CDROM_DEVICE" "$CDROM_MOUNT" 2>/dev/null || true

rm -rf "$WINEPREFIX/dosdevices/d:" "$WINEPREFIX/dosdevices/d::"
ln -s "$CDROM_MOUNT" "$WINEPREFIX/dosdevices/d:"
ln -s "$SG_DEVICE" "$WINEPREFIX/dosdevices/d::"

exec /usr/local/bin/run-desktop.sh
