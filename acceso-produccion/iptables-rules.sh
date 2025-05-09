#!/bin/bash

# Limpiar reglas anteriores
iptables -F

# Aceptar tráfico entrante solo por los puertos 2222 (SSH) y 22 (para acceder a otros contenedores)
iptables -A INPUT -p tcp --dport 2222 -j ACCEPT  # Permitir SSH al contenedor
iptables -A INPUT -p tcp --dport 22 -j ACCEPT    # Permitir SSH al servidor de producción

# Aceptar tráfico local (localhost)
iptables -A INPUT -i lo -j ACCEPT

# Denegar todo el tráfico entrante por defecto
iptables -A INPUT -j REJECT
