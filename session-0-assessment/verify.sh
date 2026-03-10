#!/usr/bin/env bash

NAME=$(cat /opt/student_name 2>/dev/null || echo "unknown")
DATE=$(date)

FILE="/home/student/textreferences/editme.txt"
SCRIPT="/home/student/apps/certscript.sh"

echo ""
echo "=========================================="
echo " LFCS PRACTICE EXAM VERIFICATION"
echo "=========================================="
echo ""

# DOMAIN SCORES
essential=0
essential_total=8

operations=0
operations_total=5

network=0
network_total=2

storage=0
storage_total=4

users=0
users_total=14


#############################################
# ESSENTIAL COMMANDS
#############################################

echo "Checking Essential Commands..."

if head -n1 "$FILE" | grep -q 7777; then
 ((essential++))
 echo "✔ line 7777 moved"
else
 echo "✘ line 7777 not moved"
fi

if ! grep -q "7000" "$FILE"; then
 ((essential++))
 echo "✔ line 7000 removed"
else
 echo "✘ line 7000 still exists"
fi

if ! grep -q "Earth" "$FILE" && grep -q "Globe" "$FILE"; then
 ((essential++))
 echo "✔ Earth replaced"
else
 echo "✘ replacement incorrect"
fi

if tail -n1 "$FILE" | grep -q "Auctores Varii"; then
 ((essential++))
 echo "✔ final line added"
else
 echo "✘ final line missing"
fi

# archive tasks

if [ -d /opt/SAMPLE001 ]; then
 ((essential++))
 echo "✔ zip extracted"
else
 echo "✘ zip extraction missing"
fi

if [ -f /opt/SAMPLE0001.tar ]; then
 ((essential++))
 echo "✔ tar created"
else
 echo "✘ tar missing"
fi

if [ -f /opt/SAMPLE0001.tar.bz2 ]; then
 ((essential++))
 echo "✔ bz2 created"
else
 echo "✘ bz2 missing"
fi

if [ -f /opt/SAMPLE0001.tar.xz ]; then
 ((essential++))
 echo "✔ xz created"
else
 echo "✘ xz missing"
fi


#############################################
# OPERATIONS
#############################################

echo ""
echo "Checking Operations..."

if [ -x "$SCRIPT" ]; then
 ((operations++))
 echo "✔ certscript exists"
else
 echo "✘ certscript missing"
fi

if "$SCRIPT" 2>/dev/null | head -n1 | grep -q "$(whoami)"; then
 ((operations++))
 echo "✔ script prints username"
else
 echo "✘ username incorrect"
fi

gateway=$(ip route | grep default | awk '{print $3}')

if "$SCRIPT" 2>/dev/null | grep -q "$gateway"; then
 ((operations++))
 echo "✔ gateway printed"
else
 echo "✘ gateway incorrect"
fi

if command -v tmux >/dev/null; then
 ((operations++))
 echo "✔ tmux installed"
else
 echo "✘ tmux missing"
fi

if crontab -l 2>/dev/null | grep -q scan_filesystem; then
 ((operations++))
 echo "✔ cron configured"
else
 echo "✘ cron missing"
fi


#############################################
# NETWORKING
#############################################

echo ""
echo "Checking Networking..."

if [ -f /home/student/port-2605.txt ]; then
 ((network++))
 echo "✔ port lookup file"
else
 echo "✘ port lookup missing"
fi

if [ -f /home/student/imap-ports.txt ]; then
 ((network++))
 echo "✔ imap ports file"
else
 echo "✘ imap ports missing"
fi


#############################################
# STORAGE
#############################################

echo ""
echo "Checking Storage..."

if mount | grep -q "/mnt/backup"; then
 ((storage++))
 echo "✔ backup mounted"
else
 echo "✘ backup mount missing"
fi

if [ -d /opt/proddata ]; then
 ((storage++))
 echo "✔ proddata extracted"
else
 echo "✘ extraction missing"
fi

if ! swapon --show | grep -q xvdi1; then
 ((storage++))
 echo "✔ swap disabled"
else
 echo "✘ swap still active"
fi

if mount | grep "/staging" | grep -q ro; then
 ((storage++))
 echo "✔ staging mounted read-only"
else
 echo "✘ staging not read-only"
fi


#############################################
# USERS & GROUPS
#############################################

echo ""
echo "Checking Users & Groups..."

if getent group computestream >/dev/null; then
 ((users++))
 echo "✔ computestream group"
else
 echo "✘ group missing"
fi

if [ -d /exam/computestream ]; then
 ((users++))
 echo "✔ directory created"
else
 echo "✘ directory missing"
fi

if stat -c "%G" /exam/computestream 2>/dev/null | grep -q computestream; then
 ((users++))
 echo "✔ group ownership correct"
else
 echo "✘ ownership incorrect"
fi

if id candidate >/dev/null 2>&1; then
 ((users++))
 echo "✔ candidate user"
else
 echo "✘ candidate missing"
fi

if sudo -l -U candidate 2>/dev/null | grep -q NOPASSWD; then
 ((users++))
 echo "✔ candidate sudo"
else
 echo "✘ candidate sudo incorrect"
fi

if grep -q NEWS /etc/skel/* 2>/dev/null; then
 ((users++))
 echo "✔ NEWS template"
else
 echo "✘ NEWS template missing"
fi

if getent group students >/dev/null; then
 ((users++))
 echo "✔ students group"
else
 echo "✘ students missing"
fi

if id harry >/dev/null 2>&1; then
 ((users++))
 echo "✔ harry user"
else
 echo "✘ harry missing"
fi

if getent passwd harry | grep -q "/home/school/harry"; then
 ((users++))
 echo "✔ harry home correct"
else
 echo "✘ harry home incorrect"
fi

if id harry | grep -q students; then
 ((users++))
 echo "✔ harry in students"
else
 echo "✘ harry group incorrect"
fi

if id sysadmin >/dev/null 2>&1; then
 ((users++))
 echo "✔ sysadmin user"
else
 echo "✘ sysadmin missing"
fi

if getent passwd sysadmin | grep -q "/sysadmin"; then
 ((users++))
 echo "✔ sysadmin home correct"
else
 echo "✘ sysadmin home incorrect"
fi

if getent passwd sysadmin | grep -q zsh; then
 ((users++))
 echo "✔ sysadmin shell"
else
 echo "✘ sysadmin shell incorrect"
fi

if sudo -l -U sysadmin 2>/dev/null | grep -q NOPASSWD; then
 ((users++))
 echo "✔ sysadmin sudo"
else
 echo "✘ sysadmin sudo incorrect"
fi


#############################################
# CALCULATE DOMAIN SCORES
#############################################

essential_pct=$((essential*100/essential_total))
operations_pct=$((operations*100/operations_total))
network_pct=$((network*100/network_total))
storage_pct=$((storage*100/storage_total))
users_pct=$((users*100/users_total))

final=$(echo "scale=2;
($operations_pct*25 +
$network_pct*25 +
$storage_pct*20 +
$essential_pct*20 +
$users_pct*10)/100" | bc)

echo ""
echo "=========================================="
echo " COPY THE BELOW RESULTS IN THE MICROSOFT FORM"
echo "=========================================="
echo ""
echo "=========================================="
echo " DOMAIN RESULTS"
echo "=========================================="

echo "Essential Commands : $essential_pct%"
echo "Operations         : $operations_pct%"
echo "Networking         : $network_pct%"
echo "Storage            : $storage_pct%"
echo "Users & Groups     : $users_pct%"

echo ""
echo "=========================================="
echo " FINAL SCORE"
echo "=========================================="
printf "%.2f%%\n" "$final"

echo ""
echo "Date: $DATE"
echo ""
