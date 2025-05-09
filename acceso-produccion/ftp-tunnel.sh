#!/bin/bash

# === CONFIGURACIÓN ===
SSH_USER="anonymous"
SSH_HOST="localhost"
SSH_PORT=2222


# === MOSTRAR INFO ===
echo "[INFO] Estableciendo túnel SSH hacia el servidor FTP interno (fsamba-ftp)..."
echo "[INFO] Conectando como $SSH_USER@$SSH_HOST en el puerto $SSH_PORT"

# === CREAR EL TÚNEL ===
ssh -i ~/.ssh/id_rsa -p $SSH_PORT -N \
  -L 2121:172.40.0.2:21 \
  -L 30000:172.40.0.2:30000 \
  -L 30001:172.40.0.2:30001 \
  -L 30002:172.40.0.2:30002 \
  -L 30003:172.40.0.2:30003 \
  -L 30004:172.40.0.2:30004 \
  -L 30005:172.40.0.2:30005 \
  -L 30006:172.40.0.2:30006 \
  -L 30007:172.40.0.2:30007 \
  -L 30008:172.40.0.2:30008 \
  -L 30009:172.40.0.2:30009 \
  ${SSH_USER}@${SSH_HOST}
