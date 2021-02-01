FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash telegraf supervisor nginx openssl phpmyadmin \
	php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

# nginx
RUN mkdir /www
RUN adduser -D -g 'www' www
RUN mkdir -p /run/nginx
COPY srcs/nginx.conf /etc/nginx/nginx.conf

# phpmyadmin
COPY srcs/config.inc.php /etc/phpmyadmin/config.inc.php

# SSL
#RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=hroh/CN=localhost" -keyout test.key -out test.crt &&\
#	mv test.crt etc/ssl/certs/ &&\
#	mv test.key etc/ssl/private/ &&\
#	chmod 600 etc/ssl/certs/test.crt etc/ssl/private/test.key

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

EXPOSE 5000

# 권한설정
RUN chown -R www:www /www &&\
	chmod -R 755 /www &&\
	chown -R www:www /usr/share/webapps/phpmyadmin &&\
	chmod -R 755 /usr/share/webapps/phpmyadmin &&\
	chown -R www:www /var/lib/nginx

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]