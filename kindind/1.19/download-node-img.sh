#!/bin/sh

# start dockerd (needed for building KinD)
dockerd > /var/log/dockerd.log 2>&1 &
sleep 3

# Preload the nestybox/kindestnode:v1.19.4 image (temporarily needed for
# the kind cluster nodes to bypass a bug in the OCI runc used inside
# these nodes).
docker pull registry.nestybox.com/nestybox/kindestnode:v1.19.4
