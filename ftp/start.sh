#!/bin/bash

# Asegura permisos correctos
chmod -R 755 /srv/ftp/publico
chown -R ftp:ftp /srv/ftp/publico

echo "Iniciando servidor FTP..."
/usr/sbin/vsftpd /etc/vsftpd.conf