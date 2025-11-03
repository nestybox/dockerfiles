# Sample Kubernetes (K8s) node system container image.
#
# Containers deployed with this image acts as K8s nodes.
#
# The image creates a container that includes systemd, kubeadm, docker, and all
# k8s control plane pod images (apiserver, kubeproxy, etc.).
#
# You must deploy the container with the Sysbox container runtime (see below).
#
# NOTE: BUILDING THIS IMAGE REQUIRES CONFIGURING SYSBOX-RUNC AS DOCKER'S DEFAULT
#       RUNTIME DURING THE BUILD.
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
# $ docker build -t nestybox/k8s-node:<k8s_version> .
#
# E.g.,
#
# $ docker build -t nestybox/k8s-node:v1.21.12 .
#
# Once the build completes, you can revert the default runtime config if you wish.
#
# Deploy k8s-node containers with:
#
# $ docker run --runtime=sysbox-runc --rm -d --name k8s-master nestybox/k8s-node:v1.21.12
# $ docker run --runtime=sysbox-runc --rm -d --name k8s-worker-0 nestybox/k8s-node:v1.21.12
# $ docker run --runtime=sysbox-runc --rm -d --name k8s-worker-1 nestybox/k8s-node:v1.21.12
# ...
#
# Then run 'kubeadm init' in them just as you would on a physical host or VM.

FROM ghcr.io/nestybox/ubuntu-jammy-systemd-docker:latest

ARG k8s_version=v1.32.9

# Requirements for subsequent steps.
RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install Kubeadm, Kubelet, and Kubectl.
#
# Using the new Kubernetes package repository (pkgs.k8s.io) which replaced the deprecated
# apt.kubernetes.io repository. The new repository uses a versioned approach.
# For K8s 1.32, we use the v1.32 repository.
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install --no-install-recommends -y \
    kubeadm="${k8s_version#v}"-1.1 \
    kubelet="${k8s_version#v}"-1.1 \
    kubectl="${k8s_version#v}"-1.1 \
    && rm -rf /var/lib/apt/lists/*

# Configure containerd for Kubernetes (containerd is already installed with Docker)
# K8s 1.24+ requires CRI runtime; containerd needs proper config for systemd cgroups
RUN mkdir -p /etc/containerd \
    && containerd config default > /etc/containerd/config.toml \
    && sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml \
    && systemctl enable containerd

# Preload k8s control plane container images into the sys container image.
COPY kube-pull.sh /usr/bin/
RUN chmod +x /usr/bin/kube-pull.sh && kube-pull.sh $k8s_version && rm /usr/bin/kube-pull.sh

# Docker daemon config.
COPY daemon.json /etc/docker/

# bash completion
RUN apt-get update                                                             \
    && mkdir -p /etc/bash_completion.d                                         \
    && apt-get install bash-completion                                         \
    && rm -rf /var/lib/apt/lists/*                                             \
    && echo "source /etc/profile.d/bash_completion.sh" >> /root/.bashrc        \
    && echo "source <(kubectl completion bash)" >> /root/.bashrc               \
    && echo "source /etc/profile.d/bash_completion.sh" >> /home/admin/.bashrc  \
    && echo "source <(kubectl completion bash)" >> /home/admin/.bashrc
