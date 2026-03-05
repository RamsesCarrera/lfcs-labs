#!/usr/bin/env bash

score=0
total=10

if [ ! -f /opt/student_name ]; then
  echo "You must run register.sh first"
  exit 1
fi

echo ""
echo "Checking LFCS tasks..."
echo ""

FILE="/home/student/textreferences/editme.txt"

# TASK 1
first_line=$(head -n 1 "$FILE")

if [[ "$first_line" == *7777* ]]; then
    echo "✔ Line 7777 moved correctly"
    ((score++))
else
    echo "✘ Line 7777 not moved"
fi

# TASK 2
if ! grep -q "7000" "$FILE"; then
    echo "✔ Line 7000 removed"
    ((score++))
else
    echo "✘ Line 7000 still exists"
fi

# TASK 3
if ! grep -q "Earth" "$FILE" && grep -q "Globe" "$FILE"; then
    echo "✔ Word replacement correct"
    ((score++))
else
    echo "✘ Word replacement incorrect"
fi

# TASK 4
last_line=$(tail -n 1 "$FILE")

if [[ "$last_line" == *"Auctores Varii"* ]]; then
    echo "✔ Final line added"
    ((score++))
else
    echo "✘ Final line missing"
fi

# TASK 5
if [ -d "/opt/SAMPLE001" ]; then
    echo "✔ SAMPLE001 extracted"
    ((score++))
else
    echo "✘ SAMPLE001 not extracted"
fi

# TASK 6
if [ -f "/opt/SAMPLE0001.tar" ]; then
    echo "✔ tar archive created"
    ((score++))
else
    echo "✘ tar archive missing"
fi

# TASK 7
if [ -f "/opt/SAMPLE0001.tar.bz2" ]; then
    echo "✔ bzip compression created"
    ((score++))
else
    echo "✘ bzip compression missing"
fi

# TASK 8
if [ -f "/opt/SAMPLE0001.tar.xz" ]; then
    echo "✔ xz compression created"
    ((score++))
else
    echo "✘ xz compression missing"
fi

# TASK 9
if ! find /srv/SAMPLE002 -type f -executable | grep -q .; then
    echo "✔ Executables removed"
    ((score++))
else
    echo "✘ Executables still exist"
fi

# TASK 10
if ! find /srv/SAMPLE002 -type d -empty | grep -q .; then
    echo "✔ Empty directories removed"
    ((score++))
else
    echo "✘ Empty directories still exist"
fi

echo ""
echo "Score: $score / $total"

echo "$score" > /tmp/lfcs_score

NAME=$(cat /opt/student_name)
DATE=$(date -Iseconds)

echo "$NAME,$score,$DATE" >> /opt/exam_results.csv

bash finish.sh
