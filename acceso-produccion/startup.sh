#!/bin/bash

echo "[INFO] Aplicando reglas de firewall internas..."

# Bloquear acceso externo a puertos FTP directamente (modo seguro)
iptables -A FORWARD -p tcp --dport 21 -j DROP
iptables -A FORWARD -p tcp --dport 20 -j DROP
iptables -A FORWARD -p tcp --dport 30000:30009 -j DROP

echo "[INFO] Reglas iptables aplicadas."
echo "[INFO] Iniciando servidor SSH..."
/usr/sbin/sshd -D
