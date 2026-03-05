#!/usr/bin/env bash
set -e


echo "Preparing LFCS lab environment..."

cp /tmp/repo/git/assessment-session-0/*.sh /usr/local/bin/
chmod +x /usr/local/bin/*.sh


# ------------------------------------------------
# Install dependencies
# ------------------------------------------------
apt-get update -y
apt-get install -y zip

# ------------------------------------------------
# Create student user if it doesn't exist
# ------------------------------------------------
if ! id "student" &>/dev/null; then
    useradd -m -s /bin/bash student
    echo "student:linux" | chpasswd
    usermod -aG sudo student
fi

# ------------------------------------------------
# Create directory structure
# ------------------------------------------------
mkdir -p /home/student/textreferences
mkdir -p /home/student/apps
mkdir -p /opt/SAMPLE001
mkdir -p /opt/SAMPLE002
mkdir -p /srv/SAMPLE002

# ------------------------------------------------
# Generate large file for vim exercise
# ------------------------------------------------
echo "Generating vim practice file..."

for i in {1..8000}; do
    if [ "$i" -eq 7777 ]; then
        echo "This is the famous line 7777 - Earth" >> /home/student/textreferences/editme.txt
    elif [ "$i" -eq 7000 ]; then
        echo "This line 7000 should be deleted" >> /home/student/textreferences/editme.txt
    else
        echo "Line $i: Content about Earth and Linux" >> /home/student/textreferences/editme.txt
    fi
done

# ------------------------------------------------
# Create compression exercise
# ------------------------------------------------
echo "Preparing compression exercise..."

echo "Data for sample 1" > /opt/SAMPLE001/file1.txt
echo "Data for sample 2" > /opt/SAMPLE001/file2.txt

cd /opt
zip -r SAMPLE001.zip SAMPLE001 >/dev/null

# Clean directory but keep zip
rm -rf /opt/SAMPLE001/*

# ------------------------------------------------
# Create search & cleanup exercise files
# ------------------------------------------------
echo "Preparing find/cleanup exercises..."

# Executable files
touch /srv/SAMPLE002/run_me.sh
chmod +x /srv/SAMPLE002/run_me.sh

touch /srv/SAMPLE002/binary_tool
chmod +x /srv/SAMPLE002/binary_tool

# Old files (>30 days access time)
touch /srv/SAMPLE002/old_log.txt
touch /srv/SAMPLE002/forgotten_notes.txt

touch -a -t $(date -d "40 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/old_log.txt
touch -a -t $(date -d "45 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/forgotten_notes.txt

# Empty directories
mkdir -p /srv/SAMPLE002/empty_dir1
mkdir -p /srv/SAMPLE002/empty_dir2

# Tar files
touch /srv/SAMPLE002/backup1.tar
touch /srv/SAMPLE002/backup2.tar
touch /srv/SAMPLE002/not_a_tar_file.txt

# ------------------------------------------------
# Fix ownership
# ------------------------------------------------
chown -R student:student /home/student
chown -R student:student /srv/SAMPLE002
chown -R student:student /opt/SAMPLE001.zip

# ------------------------------------------------
# Auto switch to student user when terminal opens
# ------------------------------------------------
echo "su - student" >> /home/ubuntu/.bashrc

# ------------------------------------------------
# Final message
# ------------------------------------------------
echo ""
echo "=========================================="
echo " LFCS LAB ENVIRONMENT READY"
echo "=========================================="
echo ""
echo "Login user: student"
echo "Password: linux"
echo ""
echo "Practice files:"
echo ""
echo "/home/student/textreferences/editme.txt"
echo "/srv/SAMPLE002/"
echo "/opt/SAMPLE001.zip"
echo ""
echo "Good luck!"
echo ""
