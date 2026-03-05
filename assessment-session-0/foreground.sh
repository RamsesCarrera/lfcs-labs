#!/bin/bash

# 1. Crear estructura de directorios
sudo mkdir -p /home/student/textreferences
sudo mkdir -p /home/student/apps
sudo mkdir -p /opt/SAMPLE001
sudo mkdir -p /srv/SAMPLE002
sudo mkdir -p /opt/SAMPLE002

# 2. Crear archivo para edición en Vim (Page 1)
# Generamos un archivo de 8000 líneas para poder mover la 7777 y borrar la 7000
for i in {1..8000}; do
    if [ $i -eq 7777 ]; then
        echo "This is the famous line 7777 - Earth" >> /home/student/textreferences/editme.txt
    elif [ $i -eq 7000 ]; then
        echo "This line 7000 should be deleted" >> /home/student/textreferences/editme.txt
    else
        echo "Line $i: Content about Earth and Linux" >> /home/student/textreferences/editme.txt
    fi
done

# 3. Crear archivos para Compresion (Page 2)
# Creamos archivos dummy y luego el .zip 
echo "Data for sample 1" > /opt/SAMPLE001/file1.txt
echo "Data for sample 2" > /opt/SAMPLE001/file2.txt
cd /opt && zip -r SAMPLE001.zip SAMPLE001/
# Limpiamos el directorio 
sudo rm -rf /opt/SAMPLE001/*

# 4. Crear archivos para Búsqueda y Limpieza (Page 3-4)
# Archivos ejecutables
touch /srv/SAMPLE002/run_me.sh && chmod +x /srv/SAMPLE002/run_me.sh
touch /srv/SAMPLE002/binary_tool && chmod +x /srv/SAMPLE002/binary_tool

# Archivos antiguos (modificamos la fecha de acceso a hace 40 días)
touch -a -t $(date -d "40 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/old_log.txt
touch -a -t $(date -d "45 days ago" +%Y%m%d%H%M) /srv/SAMPLE002/forgotten_notes.txt

# Directorios vacíos
mkdir -p /srv/SAMPLE002/empty_dir1
mkdir -p /srv/SAMPLE002/empty_dir2

# Archivos .tar para el ejercicio de listado
touch /srv/SAMPLE002/backup1.tar
touch /srv/SAMPLE002/backup2.tar
touch /srv/SAMPLE002/not_a_tar_file.txt

# 5. Ajustar permisos
sudo chown -R $USER:$USER /home/student /opt/SAMPLE001 /srv/SAMPLE002 /opt/SAMPLE002

echo "✅ Environment generated successfully!"
