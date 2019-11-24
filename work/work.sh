#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

password="${1-none}"

sudo="sudo"
if [ "${password}" != "none" ]; then
    sudo="echo ${password} | sudo -S"
fi

# ...

# apt

echo "==> Updating and installing packages"
"${sudo}" apt-get update && "${sudo}" apt-get install -qq \
    pkg-config \
    zlib1g-dev \
    --no-install-recommends
