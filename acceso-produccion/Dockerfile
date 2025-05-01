# Usar la imagen base Debian
FROM debian:latest

# Actualizar el sistema e instalar SSH e iptables
RUN apt-get update && \
    apt-get install -y openssh-server iptables && \
    apt-get clean

# Crear el directorio necesario para SSH
RUN mkdir /var/run/sshd

# Crear un usuario anónimo con contraseña vacía
RUN useradd -m anonymous && \
    passwd -d anonymous && \
    mkdir /home/anonymous/.ssh && \
    chown anonymous:anonymous /home/anonymous/.ssh

# Configurar SSH para permitir el acceso anónimo sin contraseña
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "AllowUsers anonymous" >> /etc/ssh/sshd_config

# Bloquear puertos FTP en el contenedor
RUN iptables -A INPUT -p tcp --dport 21 -j DROP && \
    iptables -A INPUT -p tcp --dport 20 -j DROP && \
    iptables -A INPUT -p tcp --dport 1024:65535 -j DROP

# Exponer el puerto SSH (por defecto es 22)
EXPOSE 22

# Comando para ejecutar el servicio SSH
CMD ["/usr/sbin/sshd", "-D"]
