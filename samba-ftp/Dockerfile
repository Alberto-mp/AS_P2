FROM debian:latest
RUN apt update && apt install -y samba vsftpd
COPY smb.conf /etc/samba/smb.conf
COPY vsftpd.conf /etc/vsftpd.conf
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh
CMD ["/startup.sh"]
