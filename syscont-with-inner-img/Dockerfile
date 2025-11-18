#
# Sample Dockerfile to build a system container image that include inner container images.
#
# Build with: (must use the old docker builder, does not work with buildx yet):
#   $ DOCKER_BUILDKIT=0 docker build -t ghcr.io/nestybox/syscont-inner-img:latest .
#
# For arm64, build it on an arm64 host and tag it differently:
#   $ DOCKER_BUILDKIT=0 docker build -t ghcr.io/nestybox/syscont-inner-img:latest-arm64 .
#
# Run with:
#   $ docker run -it --runtime=sysbox-runc --hostname=syscont nestybox/syscont-with-inner-img:latest

FROM ghcr.io/nestybox/alpine-docker

COPY docker-pull.sh /usr/bin
RUN chmod +x /usr/bin/docker-pull.sh && docker-pull.sh && rm /usr/bin/docker-pull.sh
