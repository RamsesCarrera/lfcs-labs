#!/usr/bin/env bash

score=$(cat /tmp/lfcs_score)

echo ""
echo "===================================="
echo " LFCS PRACTICE RESULT"
echo "===================================="
echo ""

echo "Score: $score / 10"
echo ""

if [ "$score" -ge 7 ]; then
    echo "PASS"
    echo "You demonstrated strong Linux fundamentals."
else
    echo "FAIL"
    echo "Review the tasks and try again."
fi

echo ""
echo "End of assessment."
