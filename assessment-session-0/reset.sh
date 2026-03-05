#!/usr/bin/env bash

echo "Resetting lab..."

rm -rf /home/student/textreferences/editme.txt
rm -rf /srv/SAMPLE002/*
rm -rf /opt/SAMPLE001*
rm -rf /opt/SAMPLE0001*

bash setup.sh

echo "Lab reset complete."
