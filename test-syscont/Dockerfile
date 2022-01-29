#
# Alpine + docker + a bunch of inner container images
#
# Instructions for docker installation taken from:
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
#
# TODO
# Use light-weight base (alpine)
# Embed other images inside


FROM alpine:latest

RUN apk update && apk add \
    bash \
    curl \
    docker \
    findmnt \
    nano \
    strace

# Inner container images (embedded in sys container image)
COPY elasticsearch_7.16.3.tar /root/img/elasticsearch_7.16.3.tar
COPY alpine_3.10.tar /root/img/alpine_3.10.tar
COPY httpd_alpine.tar /root/img/httpd_alpine.tar
COPY fluentd_1.14.1.tar /root/img/fluentd_1.14.1.tar
COPY python_alpine.tar /root/img/python_alpine.tar
COPY mysql_server_8.0.tar /root/img/mysql_server_8.0.tar
COPY nginx_mainline_alpine.tar /root/img/nginx_mainline_alpine.tar
COPY postgres_alpine.tar /root/img/postgres_alpine.tar
COPY prometheus.tar /root/img/prometheus.tar
COPY redis_5.0.5_alpine.tar /root/img/redis_5.0.5_alpine.tar
COPY telegraf-1.21.tar /root/img/telegraf-1.21.tar
COPY influxdb_2.0-alpine.tar /root/img/influxdb_2.0-alpine.tar
