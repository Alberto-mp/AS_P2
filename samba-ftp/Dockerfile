FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Instalar Samba y vsftpd
RUN apt update && apt install -y samba vsftpd dos2unix

# Crear usuario FTP (necesario para vsftpd anonymous)
RUN (id ftp 2>/dev/null || useradd -m ftp)

# Crear carpetas necesarias
RUN mkdir -p /srv/docs/desarrollo \
             /srv/docs/revision \
             /srv/docs/publico \
             /var/run/vsftpd/empty && \
    chown -R ftp:ftp /srv/docs/publico && \
    chmod -R 755 /srv/docs/publico

# Copiar configuraciones
COPY smb.conf /etc/samba/smb.conf
COPY vsftpd.conf /etc/vsftpd.conf
COPY startup.sh /startup.sh

# Asegurar compatibilidad y permisos
RUN dos2unix /etc/vsftpd.conf /startup.sh && chmod +x /startup.sh

# Exponer puertos
EXPOSE 21 139 445 30000-30009

# Comando de inicio
CMD ["/startup.sh"]
