#!/bin/bash

packages=("nginx" "curl" "wget")

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

echo "Running as root..."

for pkg in "${packages[@]}"; do
    if ! dpkg -s "$pkg" &>/dev/null; then
        echo "$pkg is not installed. Installing..."
        apt install -y "$pkg" &>/dev/null
    fi
done

echo
echo "Package Status:"

for pkg in "${packages[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
        echo "[OK] $pkg is INSTALLED"
    else
        echo "[ERROR] $pkg is NOT INSTALLED"
    fi
done
