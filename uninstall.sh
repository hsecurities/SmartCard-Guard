#!/bin/bash

echo "[+] Removing SmartCard Guard..."

systemctl --user stop smartcard-guard.service
systemctl --user disable smartcard-guard.service

rm -f ~/.config/systemd/user/smartcard-guard.service
rm -f ~/.local/bin/smartcard-guard.sh

systemctl --user daemon-reload

echo "[+] SmartCard Guard Removed"
