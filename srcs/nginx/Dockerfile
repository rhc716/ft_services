FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash nginx openssl openssh supervisor telegraf vim \
	php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN adduser -D -g 'www' www
RUN mkdir -p /run/nginx

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/supervisord.conf /etc/supervisord.conf

# SSH
RUN sed 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' -i /etc/ssh/sshd_config \
&& echo 'root:1234' | chpasswd \
&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# SSL
RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=hroh/CN=localhost" -keyout test.key -out test.crt &&\
	mv test.crt etc/ssl/certs/ &&\
	mv test.key etc/ssl/private/ &&\
	chmod 600 etc/ssl/certs/test.crt etc/ssl/private/test.key

EXPOSE 80 443 22

COPY srcs/index.html .
COPY srcs/setup.sh .
RUN chmod 777 /setup.sh &&\
	chmod 777 /index.html &&\
	chown -R www:www /var/lib/nginx

#CMD 는 yaml 파일의 command로 대체, PV에 데이터 이동