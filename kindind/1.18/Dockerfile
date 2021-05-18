#
# kindind: kubernetes-in-docker ... in docker :)
#
#
# Why?
#
# This is useful as a way of encapsulating a full K8s cluster in a single
# container image and properly isolating it from the underlying host. On the
# latter point, K8s.io KinD uses unsecure privileged containers; by placing
# K8s.io KinD inside a Sysbox container, the Sysbox container acts as secure
# boundary around that entire K8s cluster.
#
# Build Process
# =============
#
# Building this image requires configuring Sysbox-runc as Docker's default
# runtime during the build process. Refer to [this](https://github.com/nestybox/sysbox/blob/master/docs/quickstart/images.md#building-a-system-container-that-includes-inner-container-images)
# document for mroe details.
#
# $ sudo more /etc/docker/daemon.json
#{
#    "default-runtime": "sysbox-runc",
#    "runtimes": {
#        "sysbox-runc": {
#            "path": "/usr/bin/sysbox-runc"
#        }
#    }
#}
#
# $ sudo systemctl restart docker
# $ docker build -t registry.nestybox.com/nestybox/k8s-node:v1.18.2 .
#
# Once the build completes, you can revert the default runtime config if you wish.
#
# Usage
# =====
#
# $ docker run --runtime=sysbox-runc -it --rm -P --name=syscont registry.nestybox.com/nestybox/kindind:v1.18.2
#
# This will spawn a sys container which contains systemd, Docker, and the K8s.io
# KinD tool inside. Systemd login is "admin/admin". Once you log in you can run
# K8s.io KinD as if you were in a VM. E.g.,:
#
# $ kind create cluster --image=registry.nestybox.com/nestybox/kindestnode:v1.18.2
#
# The "nestybox/kindestnode:v1.18.2" image is currently required due to a bug in
# the OCI runc that prevents it from running correctly inside a system
# container. Note that in this case said runc is running inside a privileged
# container (deployed by k8s.io kind) that is inside a system container (where
# that privileged container is only privileged with respect to the system
# container, not with respect to the host).
#

FROM nestybox/ubuntu-bionic-systemd-docker:latest

RUN apt-get update && apt-get install -y \
    git \
    make

# kubectl (with bash completion)
ARG k8s_version=v1.18.2
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -  \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install kubectl="${k8s_version#v}"-00 \
    && apt-get install bash-completion \
    && kubectl completion bash >/etc/bash_completion.d/kubectl \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# K8s.io KinD
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64 \
    && chmod +x ./kind \
    && mv ./kind /usr/bin/kind

# Pre-fetch kindnestnode image to be utilized by KinD tool
COPY download-node-img.sh /usr/bin
RUN chmod +x /usr/bin/download-node-img.sh && download-node-img.sh && rm /usr/bin/download-node-img.sh
