#!/bin/bash

echo "[*] Menginstal IndSC (Termux)..."

PREFIX="$HOME/.local/bin"
SHARE="$HOME/.local/share/indsc"
mkdir -p "$PREFIX" "$SHARE"

curl -sL "https://raw.githubusercontent.com/RedcoreID/indsc/main/engine.py" -o "$SHARE/engine.py"
curl -sL "https://raw.githubusercontent.com/RedcoreID/indsc/main/run" -o "$PREFIX/indsc"

chmod +x "$PREFIX/indsc"

if ! grep -q "$PREFIX" <<< "$PATH"; then
    echo "export PATH=\$PATH:$PREFIX" >> ~/.bashrc
fi

echo "[*] Instalasi selesai!"
echo "Jalankan: indsc main.isc"
