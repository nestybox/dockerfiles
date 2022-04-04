#
# Ubuntu Jammy + Docker + Debug tools
#

FROM nestybox/ubuntu-jammy-docker:latest

# Debug utilities
RUN apt-get update && apt-get install -y \
       procps \
       psmisc \
       nano \
       strace \
       net-tools \
       less \
       wget \
       iproute2

CMD ["/bin/bash"]
