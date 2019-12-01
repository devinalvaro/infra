#!/bin/bash

set -eu

# ...

# dnf

echo "==> Upgrading and installing packages"
sudo dnf upgrade -q -y && sudo dnf install -q -y \
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
    nodejs \
    python3 python3-devel \
    `# libs` \
    pkg-config \
    zlib-devel

# ...

echo ""
echo "==> Done!"
