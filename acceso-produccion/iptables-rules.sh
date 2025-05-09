#!/bin/bash

# Limpiar reglas anteriores
iptables -F

# Aceptar tráfico entrante solo por el puerto 2222 (SSH)
iptables -A INPUT -p tcp --dport 2222 -j ACCEPT

# Aceptar tráfico local (localhost)
iptables -A INPUT -i lo -j ACCEPT

# Denegar todo el tráfico entrante por defecto
iptables -A INPUT -j REJECT
