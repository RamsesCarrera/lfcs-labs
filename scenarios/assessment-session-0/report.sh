#!/usr/bin/env bash

echo ""
echo "===================================="
echo " Instructor Report"
echo "===================================="

if [ -f /opt/exam_results.csv ]; then
    column -t -s "," /opt/exam_results.csv
else
    echo "No exam results yet."
fi
