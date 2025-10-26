#!/bin/bash
set -e
SRC_DIR="$(cd "$(dirname "$0")"/../../frontend-pwa && pwd)"
DEST_DIR="$(cd "$(dirname "$0")"/../www && pwd)"
mkdir -p "$DEST_DIR"
rsync -av --delete "$SRC_DIR"/ "$DEST_DIR"/
echo "PWA copied into capacitor/www"
