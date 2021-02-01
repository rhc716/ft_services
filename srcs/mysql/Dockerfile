FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash telegraf supervisor mysql mysql-client 

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

# mysql
COPY srcs/mysql.sh .
RUN sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

# install db
RUN /usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql"

CMD /usr/bin/supervisord -c /etc/supervisord.conf; mysql.sh