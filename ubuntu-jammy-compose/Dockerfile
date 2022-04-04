#
# Ubuntu Jammy + Docker + Compose
#
# Instructions for Docker compose installation taken from:
# https://docs.docker.com/compose/install/
#

FROM nestybox/ubuntu-jammy-docker:latest

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
