#
# nestybox/kindestnode:v1.20.2
#
# This image can be used to deploy K8s.io KinD *inside* a Sysbox container.
#
# NOTE: this is not the image for the Sysbox container. This is an image
# for the inner containers that will run inside the Sysbox container, deployed
# by the K8s.io KinD tool, and which will form the K8s-in-Docker cluster nodes.
#
# Why is this image needed?
#
# Normally KinD uses its own kindest/node:v1.20.2 image, but that image
# carries a version of the OCI runc which has a bug preventing it from
# working inside a Sysbox container (or more specifically inside a
# Linux user-namespace).
#
# To work-around this, the nestybox/kindestnode:v1.20.2 image (i.e., this
# Dockerfile) simply replaces the OCI runc with one that has the required fix.
#
# As such, nestybox/kindestnode is a temporary image: once the official
# kindest/node image picks up the patched OCI runc, it won't be needed anymore.
#
# Usage:
#
# Launch a Sysbox container that has the K8s.io KinD tool inside of it. There is
# another image called nestybox/kindind that comes with Ubuntu + Docker + KinD:
#
# $ docker run --runtime=sysbox-runc -it --rm -P --name=syscont --hostname=syscont nestybox/kindind
#
# Inside the Sysbox container, use the K8s.io KinD tool to create a K8s-in-Docker
# cluster, using the nestybox/kindestnode image:
#
# admin@syscont:~$ kind create cluster --image=nestybox/kindestnode:v1.20.2
#
# That's it: with this you'll get a full K8s cluster (thanks to KinD) deployed
# in Docker containers, all of which are running inside a single, well isolated
# Sysbox container.
#

FROM kindest/node:v1.20.2

COPY runc-v1.0.0-rc93 /usr/local/sbin/runc
RUN chmod +x /usr/local/sbin/runc
