# Docker image that includes as FIFO device as part of the image. Meant for
# testing Sysbox inner Docker image preloading.
#
# Build with:
#   $ docker build -t nestybox/mknod-test:latest .

FROM alpine

RUN apk add --update \
    ulogd \
    && rm -rf /var/cache/apk/* \
    && mknod /var/log/ulogd.pcap p
