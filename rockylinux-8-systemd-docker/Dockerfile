# Sample container image with Rocky Linux + Systemd + Sshd + Docker.
#
# Usage:
#
# $ docker run --runtime=sysbox-runc -it --rm -P --name=syscont nestybox/rockylinux-8-systemd-docker
#
# This will run systemd and prompt for a user login; the default
# user/password in this image is "admin/admin". Once you log in you
# can run Docker inside as usual. You can also ssh into the image:
#
# $ ssh admin@<host-ip> -p <host-port>
#
# where <host-port> is chosen by Docker and mapped into the system container's sshd port.
#

FROM nestybox/rockylinux-8-systemd:latest

# Docker install
RUN dnf install -y dnf-plugins-core &&                                                       \
    dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf install -y docker-ce docker-ce-cli containerd.io &&                                  \
    systemctl enable docker &&                                                               \
                                                                                             \
    # Housekeeping
    dnf clean all &&                                                                         \
    rm -rf                                                                                   \
       /var/cache/dnf/*                                                                      \
       /var/log/*                                                                            \
       /tmp/*                                                                                \
       /var/tmp/*                                                                            \
       /usr/share/doc/*                                                                      \
       /usr/share/man/* &&                                                                   \
                                                                                             \
    # Add user "admin" to the Docker group
    usermod -a -G docker admin

# Sshd install
RUN dnf install -y openssh-server &&                                                         \
    mkdir /home/admin/.ssh &&                                                                \
    chown admin:admin /home/admin/.ssh

EXPOSE 22

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]
