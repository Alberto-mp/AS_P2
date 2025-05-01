#!/bin/bash

# Crear estructura de carpetas
for i in {1..5}; do
  mkdir -p /srv/docs/desarrollo/SW$i
  mkdir -p /srv/docs/revision/SW$i
  mkdir -p /srv/docs/publico/SW$i

  # Crear usuarios
  useradd -M empleado$i || true
  echo "empleado$i:1234" | chpasswd
  (echo 1234; echo 1234) | smbpasswd -a empleado$i

  # Permisos para desarrollo (Samba accede como nobody)
  chown nobody:nogroup /srv/docs/desarrollo/SW$i
  chmod 770 /srv/docs/desarrollo/SW$i
done

# Crear revisor
useradd -M revisor || true
echo "revisor:1234" | chpasswd
(echo 1234; echo 1234) | smbpasswd -a revisor

# Permisos para revisión
chown -R nobody:nogroup /srv/docs/revision
chmod -R 770 /srv/docs/revision

# Permisos para público (acceso de lectura general)
chown -R nobody:nogroup /srv/docs/publico
chmod -R 775 /srv/docs/publico

# Iniciar servicios
service smbd start
service vsftpd start

# Mantener contenedor en ejecución
tail -f /dev/null
