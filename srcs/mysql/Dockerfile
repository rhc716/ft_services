FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash telegraf supervisor mysql mysql-client 

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

# mysql
COPY srcs/mysql.sh .
COPY srcs/wordpress.sql .
RUN chmod 777 /mysql.sh &&\
	chmod 777 /wordpress.sql
RUN sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

#CMD 는 yaml 파일의 command로 대체, PV에 DB 생성 필요