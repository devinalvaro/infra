#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

echo "==> Updating and installing packages"
sudo apt-get update && apt-get install -qq \
    pkg-config \
    zlib1g-dev \
    --no-install-recommends
