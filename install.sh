#!/bin/bash

# SHADE Installer
echo "[+] Updating Termux and installing dependencies..."
pkg update && pkg upgrade -y
pkg install tor proxychains-ng nmap -y

echo "[+] Setting up permissions..."
chmod +x ~/SHADE/shade.sh

echo "[+] Creating alias 'shade'..."
echo "alias shade='bash ~/SHADE/shade.sh'" >> ~/.bashrc
source ~/.bashrc

echo "[+] Installation complete!"
echo "[+] Type 'shade' anywhere in Termux to run the tool."
