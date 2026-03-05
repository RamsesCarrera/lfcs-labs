#!/usr/bin/env bash

if [ ! -f /tmp/exam_end ]; then
  echo "Timer not started"
  exit 1
fi

END=$(cat /tmp/exam_end)
NOW=$(date +%s)

LEFT=$(( END - NOW ))

MIN=$(( LEFT / 60 ))

echo "Time remaining: $MIN minutes"
