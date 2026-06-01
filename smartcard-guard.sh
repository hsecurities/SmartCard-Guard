#!/bin/bash

CARD_PRESENT=0

echo "[+] SmartCard Guard Started"

while true
do
    STATUS=$(timeout 1 pcsc_scan 2>/dev/null)

    if echo "$STATUS" | grep -q "Card inserted"; then

        if [ "$CARD_PRESENT" -eq 0 ]; then
            notify-send "SmartCard Guard" "Smart card detected"
            CARD_PRESENT=1
        fi

    else

        if [ "$CARD_PRESENT" -eq 1 ]; then
            notify-send "SmartCard Guard" "Card removed - locking system"
            loginctl lock-session
            CARD_PRESENT=0
        fi

        # Enforce lock while card is absent
        loginctl lock-session

    fi

    sleep 1
done
