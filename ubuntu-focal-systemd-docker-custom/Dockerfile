# Sample container image with Ubuntu Focal + Systemd + Sshd + Docker + Custom entry-point.
#
# Usage:
#
# $ docker run --runtime=sysbox-runc -it --rm -P --name=syscont nestybox/ubuntu-focal-systemd-docker-custom
#
# This will run systemd and prompt for a user login; the default
# user/password in this image is "admin/admin". Once you log in you
# can run Docker inside as usual. You can also ssh into the image:
#
# $ ssh admin@<host-ip> -p <host-port>
#
# where <host-port> is chosen by Docker and mapped into the system container's sshd port.
#

FROM nestybox/ubuntu-focal-systemd-docker:latest

# Example of a systemd service created to showcase a custom entry-point.
COPY script.sh /usr/bin/
COPY custom.service /lib/systemd/system/
RUN chmod +x /usr/bin/script.sh &&                               \
    ln -sf /lib/systemd/system/custom.service                    \
       /etc/systemd/system/multi-user.target.wants/custom.service


