#!/bin/bash

echo "[INFO] Aplicando reglas de firewall internas..."

# Bloquear conexiones entrantes a puertos FTP
iptables -A INPUT -p tcp --dport 21 -j DROP
iptables -A INPUT -p tcp --dport 20 -j DROP
iptables -A INPUT -p tcp --dport 1024:65535 -j DROP

echo "[INFO] Reglas iptables aplicadas."
echo "[INFO] Iniciando SSH..."
/usr/sbin/sshd -D
