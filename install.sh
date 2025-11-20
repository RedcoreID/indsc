#!/bin/bash

echo "[*] Menginstal IndSC..."

INSTALL_DIR="/usr/local/bin"
TARGET="$INSTALL_DIR/indsc"

# Buat folder sementara
TMP=$(mktemp -d)

echo "[*] Download engine..."
curl -sL "https://raw.githubusercontent.com/RedcoreID/indsc/main/engine.py" -o "$TMP/engine.py"

echo "[*] Download runner..."
curl -sL "https://raw.githubusercontent.com/RedcoreID/indsc/main/run" -o "$TMP/indsc"

chmod +x "$TMP/indsc"

# Pasang
echo "[*] Memasang ke $INSTALL_DIR..."
sudo mv "$TMP/indsc" "$TARGET"

# Pastikan ada engine di /usr/local/share
mkdir -p /usr/local/share/indsc
sudo mv "$TMP/engine.py" /usr/local/share/indsc/engine.py

echo "[*] Selesai! Jalankan dengan:"
echo "    indsc file.isc"
