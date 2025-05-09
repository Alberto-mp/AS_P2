FROM ubuntu:20.04

# Actualizar e instalar paquetes necesarios
RUN apt-get update && apt-get install -y \
    openssh-client \
    rsync \
    curl \
    nano \
    iptables \
    iproute2 \
    iputils-ping

# Copiar el script de iptables al contenedor
COPY iptables-rules.sh /usr/local/bin/iptables-rules.sh

# Dar permisos de ejecución al script
RUN chmod +x /usr/local/bin/iptables-rules.sh

# Exponer el puerto 22 para conexiones SSH
EXPOSE 22


