#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

upgrade_packages="${1}"

if [ "${upgrade_packages}" == "upgrade" ]; then
    echo "==> Updating and upgrading packages"
    sudo apt-get update
    sudo apt-get upgrade -y
fi

echo "==> Installing packages"
sudo apt-get install -qq \
    pkg-config \
    zlib1g-dev \
    --no-install-recommends
