FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        sudo \
        wget \
        xz-utils \
    && apt clean -y \
    && apt autoremove -y \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

ENV USER user
ENV UID 1000
ENV GID 1000

RUN groupadd --gid "$GID" "$USER" \
  && useradd \
    --uid "$UID" \
    --gid "$GID" \
    --create-home \
    --shell /bin/bash \
    "$USER" \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${GID}-${USER}"

RUN groupadd --system --gid 30000 nixbld \
    && for i in $(seq 1 30); do adduser --system --disabled-password --home /var/empty --gecos "Nix build user $i" --uid $((30000 + i)) --gid 30000 nixbld$i ; done \
    && mkdir -m 0755 /etc/nix \
    && echo "sandbox = false" > /etc/nix/nix.conf \
    && mkdir -m 0755 /nix \
    && chown ${USER} /nix

USER $USER
WORKDIR /home/${USER}/

ARG NIX_VERSION=2.3.10
RUN wget https://nixos.org/releases/nix/nix-${NIX_VERSION}/nix-${NIX_VERSION}-$(uname -m)-linux.tar.xz \
    && tar xf nix-${NIX_VERSION}-$(uname -m)-linux.tar.xz \
    && sh nix-${NIX_VERSION}-$(uname -m)-linux/install \
    && rm -r nix-${NIX_VERSION}-$(uname -m)-linux* \
    && . ${HOME}/.profile \
    && nix-collect-garbage --delete-old \
    && nix-store --optimise \
    && nix-store --verify --check-contents
