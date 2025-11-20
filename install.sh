#!/bin/bash

REPO_URL="https://raw.githubusercontent.com/RedcoreID/indsc/main"
INSTALL_DIR="/opt/indsc"
BINARY_PATH="/usr/local/bin/indsc"

echo "=== INDSC Installer ==="
echo "[*] Checking environment..."

# Detect OS
if [[ "$PREFIX" == *"/data/data/com.termux"* ]]; then
    ENV="termux"
    echo "[+] Detected Termux"
else
    ENV="linux"
    echo "[+] Detected Linux"
fi

# Install python if missing
if ! command -v python3 &> /dev/null; then
    echo "[*] Python3 tidak ditemukan, menginstall..."
    if [[ $ENV == "termux" ]]; then
        pkg install python -y
    else
        sudo apt update && sudo apt install python3 -y
    fi
fi

# Create install directory
echo "[*] Creating install directory..."
sudo mkdir -p $INSTALL_DIR

# Download core files
echo "[*] Downloading runtime..."
sudo curl -s -o $INSTALL_DIR/run.py "$REPO_URL/run.py"
sudo curl -s -o $INSTALL_DIR/engine.py "$REPO_URL/engine.py"
sudo curl -s -o $INSTALL_DIR/main.isc "$REPO_URL/main.isc"

# Create secure launcher
echo "[*] Creating launcher..."
sudo bash -c "cat <<EOF > $BINARY_PATH
#!/bin/bash
exec -a indsc-core python3 \"$INSTALL_DIR/run.py\" \"\$@\"
EOF"

sudo chmod +x $BINARY_PATH

echo "[+] Install complete!"
echo "[+] Jalankan: indsc main.isc"
exit 0
