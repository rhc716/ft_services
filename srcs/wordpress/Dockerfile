FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash telegraf supervisor nginx openssl \
	php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

# nginx
RUN mkdir /www
RUN adduser -D -g 'www' www
RUN mkdir -p /run/nginx
COPY srcs/nginx.conf /etc/nginx/nginx.conf

# wordpress
RUN wget https://wordpress.org/latest.tar.gz &&\
	tar -xvf latest.tar.gz &&\
	rm latest.tar.gz &&\
	mv wordpress/ www/
COPY srcs/wp-config.php www/wordpress/wp-config.php

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

EXPOSE 5050

# 권한설정
RUN chown -R www:www /www &&\
	chmod -R 755 /www &&\
	chown -R www:www /var/lib/nginx

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]