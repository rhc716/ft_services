FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash telegraf supervisor vsftpd

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# vsftpd
COPY srcs/vsftpd.conf /etc/vsftpd/
RUN echo -e "hroh\nhroh" | adduser hroh -g -d /var/lib/ftp
RUN echo "testfile" > /var/lib/ftp/testfile

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

RUN chmod 777 /var/lib/ftp

EXPOSE 21 30000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]