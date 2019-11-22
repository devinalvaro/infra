#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

UPGRADE_PACKAGES="${1}"

if [ "${UPGRADE_PACKAGES}" == "upgrade" ]; then
    echo "==> Updating and upgrading packages"
    sudo apt-get update
    sudo apt-get upgrade -y
fi

echo "==> Installing packages"
sudo apt-get install -qq \
    build-essential \
    curl \
    docker-compose \
    docker.io \
    fd-find \
    fish \
    fzf \
    git \
    golang \
    htop \
    neovim \
    nodejs \
    npm \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    ripgrep \
    wget \
    --no-install-recommends

# ...

# home
HOME_REPO="git@gitlab.com:devinalvaro/home.git"
HOME_DIR="${HOME}/$(basename ${HOME_REPO})"
if [ ! -d "${HOME}/.git" ]; then
    git clone "${HOME_REPO}" "${HOME_DIR}"
    cp -rp "${HOME_DIR}/.[^.]*" .
    rm -rf home
fi

# ...

# docker

if [ "$(groups ${USER} | grep -q docker)" ]; then
    echo "==> Adding user to docker group"
    sudo gpasswd -a "${USER}" docker
fi

# fd

FD_BIN="/usr/local/bin/fd"
if [ ! -f "${FD_BIN}" ]; then
    echo "==> Linking fdfind to fd"
    sudo ln -sfn "$(which fdfind)" "${FD_BIN}"
fi

# fish

FISHER_FILE="${HOME}/.config/fish/functions/fisher.fish"
if [ ! -f "${FISHER_FILE}" ]; then
    echo " ==> Installing fish plugins"
    curl https://git.io/fisher --create-dirs -sLo "${FISHER_FILE}"
    fish -c fisher
fi

echo " ==> Setting fish as the default shell"
chsh -s "$(which fish)"

# nvim

VIM_PLUG_FILE="${HOME}/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f "${VIM_PLUG_FILE}" ]; then
    echo " ==> Installing nvim plugins"
    curl -fLo "${VIM_PLUG_FILE}" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +qall
fi

NVIM_FTPLUGIN="${HOME}/.local/share/nvim/site/ftplugin"
if [ ! -d "${NVIM_FTPLUGIN}" ]; then
    echo "==> Linking nvim/langs to nvim/site/ftplugin"
    ln -sfn "${HOME}/.config/nvim/langs" "${NVIM_FTPLUGIN}"
fi

# pip

echo "==> Installing pip packages"
export PYTHONUSERBASE="${HOME}/.pip"
pip3 install --user \
    neovim-remote

# ...

# go

echo "==> Setting go environment"
export GOPATH="${HOME}/.go"
nvim +GoInstallBinaries +qall

# python

echo "==> Setting python environment"
pip3 install --user 'python-language-server[rope,pycodestyle,pyflakes,yapf]'

# rust

if ! [ -x "$(command -v rustup)" ]; then
    echo "==> Setting rust environment"
    export PATH="${HOME}/.cargo/bin:$PATH"
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    rustup component add rls rust-analysis rust-src
    rustup component add rustfmt
fi

# ...

echo ""
echo "==> Done!"
