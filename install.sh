#!/bin/bash

echo "[+] Installing SmartCard Guard..."

sudo apt update

sudo apt install -y \
pcscd \
pcsc-tools \
libnotify-bin

sudo systemctl enable pcscd
sudo systemctl start pcscd

mkdir -p ~/.local/bin
cp smartcard-guard.sh ~/.local/bin/
chmod +x ~/.local/bin/smartcard-guard.sh

mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/smartcard-guard.service << EOF
[Unit]
Description=SmartCard Guard

[Service]
ExecStart=/home/$USER/.local/bin/smartcard-guard.sh
Restart=always

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable smartcard-guard.service
systemctl --user start smartcard-guard.service

echo ""
echo "[+] SmartCard Guard Installed Successfully"
echo "[+] Service Started"
