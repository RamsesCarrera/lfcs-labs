#!/bin/bash

set -e

echo "Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y zip

echo "Creating directories..."
sudo mkdir -p /home/student/textreferences
sudo mkdir -p /home/student/apps
sudo mkdir -p /opt/SAMPLE001
sudo mkdir -p /srv/SAMPLE002
sudo mkdir -p /opt/SAMPLE002

echo "Generating edit file..."

for i in {1..8000}; do
    if [ $i -eq 7777 ]; then
        echo "This is the famous line 7777 - Earth" >> /home/student/textreferences/editme.txt
    elif [ $i -eq 7000 ]; then
        echo "This line 7000 should be deleted" >> /home/student/textreferences/editme.txt
    else
        echo "Line $i: Content about Earth and Linux" >> /home/student/textreferences/editme.txt
    fi
done

echo "Creating compression exercise files..."

echo "Data for sample 1" > /opt/SAMPLE001/file1.txt
echo "Data for sample 2" > /opt/SAMPLE001/file2.txt

cd /opt
zip -r SAMPLE001.zip SAMPLE001

sudo rm -rf /opt/SAMPLE001/*

echo "Creating search and cleanup exercise files..."

touch /srv/SAMPLE002/run_me.sh
chmod +x /srv/SAMPLE002/run_me.sh

touch /srv/SAMPLE002/binary_tool
chmod +x /srv/SAMPLE002/binary_tool

touch -a -t $(date -d "40 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/old_log.txt
touch -a -t $(date -d "45 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/forgotten_notes.txt

mkdir -p /srv/SAMPLE002/empty_dir1
mkdir -p /srv/SAMPLE002/empty_dir2

touch /srv/SAMPLE002/backup1.tar
touch /srv/SAMPLE002/backup2.tar
touch /srv/SAMPLE002/not_a_tar_file.txt

sudo chown -R student:student /home/student /opt/SAMPLE001 /srv/SAMPLE002 /opt/SAMPLE002

echo "Environment generated successfully!"
