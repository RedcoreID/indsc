#!/usr/bin/env bash
set -e

NAME="indsc"
ENTRY="run.py"
OBF_DIR="obf_src"
DIST_DIR="dist"
ARCH="$(uname -m)"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
TARGET="$OS-$ARCH"

echo "[*] Building IndSC for $TARGET"

# Venv khusus build
if [ ! -d ".venv_build" ]; then
  python3 -m venv .venv_build
fi

source .venv_build/bin/activate
pip install --upgrade pip
pip install pyinstaller pyarmor

# Obfuscate sources
rm -rf $OBF_DIR
pyarmor obfuscate --output $OBF_DIR run.py engine.py

# Build binary
rm -rf build dist
pyinstaller --noconfirm --onefile --name $NAME $OBF_DIR/run.py

# Optional compress
if command -v upx &>/dev/null; then
  echo "[*] Compressing with UPX..."
  upx --best dist/$NAME || true
fi

mkdir -p $DIST_DIR/$TARGET
mv dist/$NAME $DIST_DIR/$TARGET/

echo "[+] Build success → dist/$TARGET/$NAME"
deactivate
