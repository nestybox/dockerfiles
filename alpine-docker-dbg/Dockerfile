# Alpine image used by several Sysbox tests (carries alpine plus a few useful
# debug utilities).

FROM alpine:latest

RUN apk update && apk add \
    acl \
    bash \
    curl \
    findmnt \
    nano \
    strace \
    tree \
    libcap \
    bind-tools \
    nftables

RUN apk update && apk add docker

CMD ["/bin/sh"]
