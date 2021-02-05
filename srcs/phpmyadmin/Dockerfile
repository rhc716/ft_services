FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash telegraf supervisor nginx openssl phpmyadmin vim \
	php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

# nginx
RUN adduser -D -g 'www' www
RUN mkdir -p /run/nginx
COPY srcs/nginx.conf /etc/nginx/nginx.conf

# phpmyadmin
COPY srcs/config.inc.php /etc/phpmyadmin/config.inc.php

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

# php-FPM
COPY srcs/www.conf /etc/php7/php-fpm.d/www.conf
COPY srcs/php.ini /etc/php7/php.ini

EXPOSE 5000

COPY srcs/setup.sh .
RUN chmod 777 /setup.sh &&\
	chown -R www:www /var/lib/nginx &&\
	chown -R www:www /usr/share/webapps/phpmyadmin &&\
	chmod -R 755 /usr/share/webapps/phpmyadmin

#CMD 는 yaml 파일의 command로 대체, PV에 데이터 이동