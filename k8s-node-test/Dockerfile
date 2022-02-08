#
# Kubernetes node system container **test** image.
#
# NOTE: MEANT FOR INTERNAL USE BY NESTYBOX; DO NOT MAKE PUBLIC.
#
# This image is a superset of k8s-node image, which includes systemd,
# kubeadm and all k8s control plane pod images. Its main purpose is
# to serve as a testing image for K8s' integration-test suites.
#
# NOTE: THIS IMAGE SHOULD BE BUILT INSIDE THE SYSBOX TEST CONTAINER,
# TO AVOID THE PROBLEMS IN SYSBOX ISSUE 676.
#
# This testing image is expected to be utilized from all the Sysbox's
# supported platforms, so it must be generated with an instruction
# like this one:
#
# $ docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/nestybox/k8s-node-test:v1.20.2 --push .
#

FROM ghcr.io/nestybox/k8s-node:v1.20.2

ARG k8s_version=v1.20.2

# Debug/Testing utilities
RUN apt-get update && apt-get install --no-install-recommends -y \
    lsof \
    less \
    nano \
    psmisc \
    iproute2 \
    iputils-ping \
    jq \
    net-tools \
    dnsutils \
    tcpdump \
    bridge-utils \
    && rm -rf /var/lib/apt/lists/*

