#!/usr/bin/env bash
set -e

REPO="RedcoreID/indsc"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

echo "[*] Mendapatkan rilis terbaru..."

ASSET=$(curl -s https://api.github.com/repos/$REPO/releases/latest | \
  grep browser_download_url | grep -i "$(uname -m)" | head -n1 | cut -d '"' -f 4)

echo "[*] Download dari:"
echo "$ASSET"

curl -L "$ASSET" -o "$BIN_DIR/indsc"
chmod +x "$BIN_DIR/indsc"

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo "✔ Install selesai!"
echo "Jalankan: indsc main.isc"
