#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

UPGRADE_PACKAGES="${1:-none}"

echo "==> Running home.sh"
./home/home.sh "${UPGRADE_PACKAGES}"

if [ "${UPGRADE_PACKAGES}" != "none" ]; then
    echo "==> Updating and upgrading packages"
    sudo apt-get update
    sudo apt-get upgrade -y
fi

echo "==> Installing packages"
sudo apt-get install -qq \
    pkg-config \
    zlib1g-dev \
    --no-install-recommends
