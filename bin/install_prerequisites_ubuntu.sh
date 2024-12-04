#!/bin/bash
set -Eeuo pipefail

echo "----- install prerequisite packages -----"
if ! command -V sudo  ; then
    echo ":: Installing sudo"
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y install sudo
fi

sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install \
    bash \
    expect \
    curl \
    net-tools \
    g++-aarch64-linux-gnu \
    libc6-dev-arm64-cross \
    libxml2-dev \
    pkg-config \
    libcurl4-openssl-dev \
    libxml2-utils \
    libxml2-dev \
    libssl-dev \
    python3.11 \
    python3.11-distutils \
    python3.11-venv \
    netcat-openbsd \
    squid \
    jq
sudo curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
sudo service squid stop || true
sudo squid -k shutdown || true
sudo rm -v /dev/shm/squid*.shm >/dev/null 2>&1 || true
