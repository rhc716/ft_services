FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash influxdb telegraf supervisor

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

# database
COPY srcs/setup.sh .

EXPOSE 8086

CMD /usr/bin/supervisord -c /etc/supervisord.conf; setup.sh