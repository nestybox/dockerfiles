# Sample container image with CentOS Stream + Systemd
#
# Description:
#
# This image serves as a basic reference example for user's looking to
# run Systemd inside a system container in order to deploy various
# services within the system container, or use it as a virtual host
# environment.
#
# Usage:
#
# $ docker run --runtime=sysbox-runc -it --rm --name=syscont nestybox/centos-stream-8-systemd
#
# This will run systemd and prompt for a user login; the default user/password
# in this image is "admin/admin".

FROM quay.io/centos/centos:stream8

#
# Systemd installation
#
RUN dnf install -y \
        iptables   \
        iproute    \
        kmod       \
        procps-ng  \
        sudo       \
        udev &&    \
    # Unmask services
    systemctl unmask                                                  \
        systemd-remount-fs.service                                    \
        dev-hugepages.mount                                           \
        sys-fs-fuse-connections.mount                                 \
        systemd-logind.service                                        \
        getty.target                                                  \
        console-getty.service &&                                      \
    # Prevents journald from reading kernel messages from /dev/kmsg
    echo "ReadKMsg=no" >> /etc/systemd/journald.conf &&               \
                                                                      \
    # Housekeeping
    dnf clean all &&                                                  \
    rm -rf                                                            \
       /var/cache/dnf/*                                               \
       /var/log/*                                                     \
       /tmp/*                                                         \
       /var/tmp/*                                                     \
       /usr/share/doc/*                                               \
       /usr/share/man/* &&                                            \
                                                                      \
    # Create default 'admin/admin' user
    useradd --create-home --shell /bin/bash admin -G wheel && echo "admin:admin" | chpasswd

# Make use of stopsignal (instead of sigterm) to stop systemd containers.
STOPSIGNAL SIGRTMIN+3

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]
