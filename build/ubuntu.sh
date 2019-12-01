#!/bin/bash

set -eu

# ...

# apt

echo "==> Upgrading and installing packages"
sudo apt update -qq -y && sudo apt upgrade -qq -y && sudo apt install -qq -y \
    `# apps` \
    fd-find \
    fish \
    fzf \
    git \
    htop \
    neovim \
    ripgrep \
    wget \
    `# langs` \
    golang \
    nodejs npm \
    python3 python3-dev python3-pip python3-setuptools \
    `# essentials` \
    build-essential \
    curl \
    `# libs` \
    pkg-config \
    zlib1g-dev \
    --no-install-recommends

# ...

echo ""
echo "==> Done!"
