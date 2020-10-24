#
# Dockerfile for a system container that includes the GitLab runner
# plus it's own docker daemon.
#
# This allows the GitLab runner to run with the Docker executor in total
# isolation from the underlying host, thus improving security (particularly for
# CI jobs that interact with Docker by issuing commands such as "docker build"
# or "docker run".
#
# Start the GitLab runner with:
#
# $ docker run --runtime=sysbox-runc -d --name gitlab-runner --restart always -v /srv/gitlab-runner/config:/etc/gitlab-runner nestybox/gitlab-runner-docker
#
# Then register it with the GitLab server:
#
# $ docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register
#

FROM gitlab/gitlab-runner:latest

# Docker install (cli + engine)
RUN apt-get update && apt-get install --no-install-recommends -y \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg-agent \
       software-properties-common \
       && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
RUN apt-get update && apt-get install --no-install-recommends -y docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Modify the gitlab runner's entrypoint to start the docker engine
RUN sed -i 's/#!\/bin\/bash/#!\/bin\/bash\nrm \/var\/run\/docker.pid\ndockerd > \/var\/log\/dockerd.log 2>\&1 \&\nsleep 3/' entrypoint
