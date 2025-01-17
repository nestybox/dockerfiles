# Dockerfile for testing fix for Sysbox issue 854
#
# Build with:
#   docker build -t nestybox/sysbox-issue-854 .

FROM python:3.12

RUN pip install fusepy
RUN apt update
RUN apt install -y libfuse-dev fuse strace
COPY ./sample_fuse.py /tmp/sample_fuse.py
COPY umount/umount /bin/umount-path
RUN chmod +x /tmp/sample_fuse.py
RUN chmod +x /bin/umount-path

WORKDIR /tmp
