#
# ArchLinux + Systemd + Docker
#
# Description:
#
# This image serves as a basic reference example for user's looking to run
# ArchLinux + Systemd + Docker inside a container.
#
# Usage:
#
# $ docker run --runtime=sysbox-runc -it --rm --name=syscont nestybox/archlinux-systemd-docker
#
# This will run systemd and prompt for a user login; the default user/password
# in this image is "admin/admin". Docker will be automatically started and user
# admin can launch inner Docker containers.

FROM nestybox/archlinux-systemd

RUN pacman --noconfirm -Syu \
    bash-completion \
    docker

RUN systemctl enable docker

RUN usermod -aG docker admin
