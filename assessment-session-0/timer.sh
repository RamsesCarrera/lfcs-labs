#!/usr/bin/env bash

DURATION=5400   # 90 minutos
END_TIME=$(( $(date +%s) + DURATION ))

echo $END_TIME > /tmp/exam_end

echo ""
echo "===================================="
echo " LFCS PRACTICE EXAM STARTED"
echo "===================================="
echo ""
echo "You have 90 minutes."
echo ""

while true; do
    now=$(date +%s)
    remaining=$(( END_TIME - now ))

    if [ $remaining -le 0 ]; then
        echo ""
        echo "⏱ Time is over."
        /usr/bin/bash /root/finish.sh
        exit
    fi

    sleep 60
done
