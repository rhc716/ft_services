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

COPY srcs/setup.sh .
RUN chmod 777 /setup.sh

EXPOSE 21 30000

#CMD 는 yaml 파일의 command로 대체, PV에 권한 부여