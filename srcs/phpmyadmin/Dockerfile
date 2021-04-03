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

RUN mkdir www &&\
	mv usr/share/webapps/phpmyadmin /www &&\
	chown -R www:www /var/lib/nginx www &&\
	chmod -R 755 www

CMD /usr/bin/supervisord -c /etc/supervisord.conf;