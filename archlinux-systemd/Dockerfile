#
# ArchLinux + Systemd
#
# Description:
#
# This image serves as a basic reference example for user's looking to run
# ArchLinux + Systemd inside a system container, in order to deploy various
# services within the system container, or use it as a virtual host environment.
#
# Usage:
#
# $ docker run --runtime=sysbox-runc -it --rm --name=syscont nestybox/archlinux-systemd
#
# This will run systemd and prompt for a user login; the default user/password
# in this image is "admin/admin".

FROM archlinux

# remove man pages and locale data
RUN rm -rf /archlinux/usr/share/locale && rm -rf /archlinux/usr/share/man

# The following systemd services don't work well (yet) inside a sysbox container
# (due to lack of permissions inside unprivileged containers)
RUN systemctl mask systemd-journald-audit.socket systemd-udev-trigger.service systemd-networkd-wait-online.service

# The following systemd services are not needed
RUN systemctl mask systemd-firstboot.service

# switch default target from graphical to multi-user
RUN systemctl set-default multi-user.target

# Create default 'admin/admin' user
RUN useradd --create-home --shell /bin/bash admin && echo "admin:admin" | chpasswd

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]
