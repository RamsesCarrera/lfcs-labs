#!/usr/bin/env bash
set -e

echo "Preparing LFCS lab environment..."

# ------------------------------------------------
# Install dependencies
# ------------------------------------------------
apt-get update -y
apt-get install -y git zip bc

# Ensure tmux is NOT installed (student must install it)
apt-get remove -y tmux || true

# ------------------------------------------------
# Clone repo to get scripts
# ------------------------------------------------
cd /root
git clone https://github.com/RamsesCarrera/lfcs-labs.git

cd /root/lfcs-labs/session-0-assessment

cp *.sh /usr/local/bin/
chmod +x /usr/local/bin/*.sh

# ------------------------------------------------
# Create student user
# ------------------------------------------------
if ! id "student" &>/dev/null; then
    useradd -m -s /bin/bash student
    echo "student:linux" | chpasswd
    usermod -aG sudo student
fi

# ------------------------------------------------
# Directory structure
# ------------------------------------------------
mkdir -p /home/student/textreferences
mkdir -p /home/student/apps
mkdir -p /opt/SAMPLE001
mkdir -p /opt/SAMPLE002
mkdir -p /srv/SAMPLE002

mkdir -p /mnt/backup
mkdir -p /staging
mkdir -p /exam

# ------------------------------------------------
# Generate vim exercise file
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
# Compression exercise
# ------------------------------------------------
echo "Preparing compression exercise..."

echo "Data for sample 1" > /opt/SAMPLE001/file1.txt
echo "Data for sample 2" > /opt/SAMPLE001/file2.txt

cd /opt
zip -r SAMPLE001.zip SAMPLE001 >/dev/null
rm -rf /opt/SAMPLE001/*

# ------------------------------------------------
# Search & cleanup exercise
# ------------------------------------------------
echo "Preparing find exercises..."

touch /srv/SAMPLE002/run_me.sh
chmod +x /srv/SAMPLE002/run_me.sh

touch /srv/SAMPLE002/binary_tool
chmod +x /srv/SAMPLE002/binary_tool

touch /srv/SAMPLE002/old_log.txt
touch /srv/SAMPLE002/forgotten_notes.txt

touch -a -t $(date -d "40 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/old_log.txt
touch -a -t $(date -d "45 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/forgotten_notes.txt

mkdir -p /srv/SAMPLE002/empty_dir1
mkdir -p /srv/SAMPLE002/empty_dir2

touch /srv/SAMPLE002/backup1.tar
touch /srv/SAMPLE002/backup2.tar
touch /srv/SAMPLE002/not_a_tar_file.txt

# ------------------------------------------------
# Storage exercise preparation
# ------------------------------------------------

# Create fake disk for mounting exercise
dd if=/dev/zero of=/root/backupdisk.img bs=1M count=100
mkfs.ext4 /root/backupdisk.img

# Mount temporarily to place archive
mount -o loop /root/backupdisk.img /mnt/backup

mkdir -p /tmp/proddata
echo "production file" > /tmp/proddata/app.conf

tar -cjf /mnt/backup/backup-primary.tar.bz2 -C /tmp proddata

umount /mnt/backup

# ------------------------------------------------
# Swap exercise
# ------------------------------------------------
fallocate -l 512M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# ------------------------------------------------
# Permissions
# ------------------------------------------------
chown -R student:student /home/student
chown -R student:student /srv/SAMPLE002
chown -R student:student /opt/SAMPLE001.zip

# ------------------------------------------------
# Auto switch to student
# ------------------------------------------------
su - student

echo ""
echo "=========================================="
echo " LFCS LAB ENVIRONMENT READY"
echo "=========================================="
echo ""
echo "Run: register.sh"
echo ""
