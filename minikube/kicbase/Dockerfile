#
# nestybox/minikube-kicbase
#
# This Docker image is used to run the Kubernetes Minikube tool *inside* a
# Sysbox container (or pod). That is, the Sysbox container acts as a secure
# virtual host inside of which you run Minikube.
#
# This image is a replacement for the gcr.io/k8s-minikube/kicbase image that
# Minikube uses to deploy Kubernetes clusters inside Docker containers.
#
# Why is this image needed?
#
# The gcr.io/k8s-minikube/kicbase image requires cgroups v2 be enabled
# on the host whenever it's running on a rootless environment (more specifically
# within a user-namespace).
#
# This requirement stems from the fact that cgroups v2 formalizes the concept of
# "cgroup delegation", where the container is allowed to manage a subset of the
# cgroup hierarchy.
#
# In Sysbox containers however, this requirement is too stringent, as Sysbox
# supports cgroup delegation with cgroups v1 too (i.e., it uses a technique
# to ensure that a container can manage a cgroup hierarchy in isolation
# whether the host is configured with cgroups v1 or v2).
#
# Therefore, this image relaxes the cgroup v2 requirement by modifying the
# entrypoint script in the gcr.io/k8s-minikube/kicbase image.
#
# Usage:
#
# 1) Launch a Sysbox container (or pod) and install Minikube inside of it:
#
#    NOTE: Minikube requires that /dev/fuse be exposed inside the container;
#    this is easy and safe to do, as follows:
#
#    $ docker run --runtime=sysbox-runc -it --rm --device /dev/fuse:/dev/fuse nestybox/ubuntu-focal-systemd-docker
#
# 2) Inside the Sysbox container, install Minikube and use it to create a K8s-in-Docker
#    cluster, using the nestybox/minikube-kicbase:v0.0.28:
#
#    $ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#    $ sudo install minikube-linux-amd64 /usr/local/bin/minikube
#    $ minikube start --base-image=nestybox/minikube-kicbase:v0.0.28
#
# 3) Install kubectl and interact with the cluster:
#
#    $ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#    $ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#    $ kubectl get all --all-namespaces
#
# NOTES:
#
# 1) Minikube will use privileged containers (which are insecure), but since
#    these are all running inside a rootless Sysbox container (i.e., the Sysbox
#    container acts as a virtual host), the Sysbox container provides strong
#    isolation from the underlying host.
#
# 2) Minikube supports several "drivers" to deploy the Kubernetes cluster (e.g.,
#    Docker, Podman, KVM, VirtualBox, etc.) When running Minikube inside a
#    Sysbox container (or pod), use the Docker driver only (which is Minikube's
#    default driver). Support for other drivers will be added in the near
#    future.
#
# 3) It's possible to run Minikube inside a Sysbox container using the official
#    gcr.io/k8s-minikube/kicbase image. However, the host must first be booted
#    with cgroups v2 enabled.

FROM gcr.io/k8s-minikube/kicbase:v0.0.28
RUN sed -i 's/^validate_userns$/# validate_userns/' /usr/local/bin/entrypoint
