#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive

password="${1-none}"

sudo="sudo"
if [ "${password}" != "none" ]; then
    sudo="echo ${password} | sudo -S"
fi

echo "==> Updating and installing packages"
eval "${sudo}" apt-get update && eval "${sudo}" apt-get install -qq \
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

home_repo="https://gitlab.com/devinalvaro/home.git"
home_dir="${HOME}/$(basename ${home_repo})"
if [ ! -d "${HOME}/.git" ]; then
    echo "==> Cloning home repository"
    rm -rf "${home_dir}"
    git clone "${home_repo}" "${home_dir}"
    cp -rp "${home_dir}"/.[^.]* ${HOME}
    rm -rf "${home_dir}"
fi

# ...

# docker

if [ ! "$(groups ${USER} | grep -w docker 2> /dev/null)" ]; then
    echo "==> Adding user to docker group"
    eval "${sudo}" gpasswd -a "${USER}" docker
fi

# fd

fd_bin="/usr/local/bin/fd"
if [ ! -f "${fd_bin}" ]; then
    echo "==> Linking fdfind to fd"
    eval "${sudo}" ln -sfn "$(which fdfind)" "${fd_bin}"
fi

# fish

fisher_file="${HOME}/.config/fish/functions/fisher.fish"
if [ ! -f "${fisher_file}" ]; then
    echo " ==> Installing fish plugins"
    curl https://git.io/fisher --create-dirs -sLo "${fisher_file}"
    fish -c fisher
fi

if [ $SHELL != "$(which fish)" ]; then
    echo " ==> Setting fish as the default shell"
    eval "${sudo}" chsh -s "$(which fish)" "${USER}"
fi

# nvim

vim_plug_file="${HOME}/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f "${vim_plug_file}" ]; then
    echo " ==> Installing nvim plugins"
    curl -fLo "${vim_plug_file}" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +qall
fi

nvim_ftplugin="${HOME}/.local/share/nvim/site/ftplugin"
if [ ! -d "${nvim_ftplugin}" ]; then
    echo "==> Linking nvim/langs to nvim/site/ftplugin"
    ln -sfn "${HOME}/.config/nvim/langs" "${nvim_ftplugin}"
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

if [ ! -x "$(command -v rustup)" ]; then
    echo "==> Setting rust environment"
    export PATH="${HOME}/.cargo/bin:$PATH"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    rustup component add rls rust-analysis rust-src
    rustup component add rustfmt
fi

# ...

echo ""
echo "==> Done!"
