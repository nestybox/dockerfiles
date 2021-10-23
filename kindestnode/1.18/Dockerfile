#
# nestybox/kindestnode:v1.18.19
#
# This image can be used to deploy K8s.io KinD *inside* a Sysbox container (or pod).
#
# NOTE: this is not the image for the Sysbox container. This is an image for the
# inner containers that the KinD tool will run inside the Sysbox container.
# The KinD tool is itself running inside the Sysbox container, and uses this
# image to create the K8s nodes that form the KinD cluster.
#
# Why is this image needed?
#
# The kindest/node:v1.18.19 image requires cgroups v2 be enabled on the
# host whenever it's running on a rootless environment (more specifically
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
# entrypoint script in the kindest/node:v1.18.19.
#
# Usage:
#
# 1) Launch a Sysbox container (or pod) and install the K8s.io KinD tool inside of it.
#
# For example, there is another container image called nestybox/kindind that comes
# with Ubuntu + Docker + KinD:
#
# $ docker run --runtime=sysbox-runc -it --rm -P --name=syscont --hostname=syscont nestybox/kindind
#
# 2) Inside the Sysbox container, use the K8s.io KinD tool to create a K8s-in-Docker
# cluster, using the nestybox/kindestnode image:
#
# $ kind create cluster --image=nestybox/kindestnode:v1.18.19
#
# That's it: with this you'll get a full K8s cluster (thanks to KinD) deployed
# in Docker containers, all of which are running inside a single, well isolated
# (rootless) Sysbox container.
#

# NOTE: earlier versions of kindest node v1.18 also required a patch OCI runc;
# v1.18.19 does not.

FROM kindest/node:v1.18.19
RUN sed -i 's/^validate_userns$/# validate_userns/' /usr/local/bin/entrypoint
