# Usar la imagen base Debian
FROM debian:latest

# Actualizar el sistema e instalar SSH e iptables
RUN apt-get update && \
    apt-get install -y openssh-server iptables && \
    apt-get clean

# Crear el directorio necesario para SSH
RUN mkdir /var/run/sshd

# Crear usuario 'anonymous' y configurar su directorio SSH
RUN useradd -m anonymous && \
    passwd -d anonymous && \
    mkdir -p /home/anonymous/.ssh && \
    chown -R anonymous:anonymous /home/anonymous/.ssh

# Configurar SSH para permitir acceso por clave pública
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "AllowUsers anonymous" >> /etc/ssh/sshd_config

# Copiar la clave pública autorizada
COPY id_rsa.pub /home/anonymous/.ssh/authorized_keys
RUN chown anonymous:anonymous /home/anonymous/.ssh/authorized_keys && \
    chmod 600 /home/anonymous/.ssh/authorized_keys

# Copiar el script de inicio
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Exponer el puerto SSH
EXPOSE 22

# Comando para iniciar SSH y aplicar reglas iptables
CMD ["/startup.sh"]
