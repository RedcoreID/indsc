#!/bin/bash

echo "[*] Menginstal IndSC..."

# Deteksi apakah Termux
if [[ "$PREFIX" == *"com.termux"* ]]; then
    echo "[*] Mode: Termux"
    BIN="$HOME/.local/bin"
    SHARE="$HOME/.local/share/indsc"
    SUDO=""
else
    echo "[*] Mode: Linux"
    BIN="/usr/local/bin"
    SHARE="/usr/local/share/indsc"
    SUDO="sudo"
fi

mkdir -p "$BIN" "$SHARE"

echo "[*] Mengunduh file engine..."
curl -sL "https://raw.githubusercontent.com/RedcoreID/indsc/main/engine.py" -o "$SHARE/engine.py"

echo "[*] Mengunduh runner..."
curl -sL "https://raw.githubusercontent.com/RedcoreID/indsc/main/run" -o "$BIN/indsc"

chmod +x "$BIN/indsc"

echo "[*] Instalasi selesai!"
echo "Jalankan dengan:"
echo "    indsc file.isc"
