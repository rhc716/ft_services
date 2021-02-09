FROM alpine:latest

RUN	apk update && apk add --no-cache openrc bash grafana telegraf supervisor\
	&& apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat


# grafana
COPY srcs/dashboards /dashboards
COPY srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/

# telegraf
RUN mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

# supervisord
COPY srcs/supervisord.conf /etc/supervisord.conf

EXPOSE 3000

# grafana server
WORKDIR /usr/share/grafana
CMD /usr/bin/supervisord -c /etc/supervisord.conf