#!/bin/bash

set -eu

# ...

# home

home_repo="https://gitlab.com/devinalvaro/home.git"
home_dir="/tmp/$(basename ${home_repo})"
if [ ! -d "${HOME}/.git" ]; then
    echo "==> Cloning home repository"
    rm -rf "${home_dir}"
    git clone "${home_repo}" "${home_dir}"
    cp -rp "${home_dir}"/.[^.]* ${HOME}
    rm -rf "${home_dir}"
fi

# ...

# go

go_ver="1.12.17"
go_tar="go${go_ver}.linux-amd64.tar.gz"
go_url="https://dl.google.com/go/${go_tar}"
goroot="/usr/local/go"
if [ ! -x "$(command -v go)" ]; then
    echo "==> Installing go"
    wget -O "/tmp/${go_tar}" "${go_url}"
    tar xzf "/tmp/${go_tar}"
    sudo mv "./go" "${goroot}"
    sudo ln -s "${goroot}/bin/"* "/usr/local/bin/"
fi

# rust

export PATH="${HOME}/.cargo/bin:${PATH}"
if [ ! -x "$(command -v rustup)" ]; then
    echo "==> Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    rustup component add rustfmt
fi

# ...

# fish

if [ ! -x "$(command -v starship)" ]; then
    echo "==> Installing starship"
    curl -fsSL https://starship.rs/install.sh | sudo bash -s -- -y
fi

fisher_file="${HOME}/.config/fish/functions/fisher.fish"
if [ ! -f "${fisher_file}" ]; then
    echo " ==> Installing fish plugins"
    curl https://git.io/fisher --create-dirs -sLo "${fisher_file}"
    fish -c fisher
fi

if [ $SHELL != "$(which fish)" ]; then
    echo " ==> Setting fish as the default shell"
    sudo chsh -s "$(which fish)" "${USER}"
fi

# nvim

vim_plug_file="${HOME}/.local/share/nvim/site/autoload/plug.vim"
vim_plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ ! -f "${vim_plug_file}" ]; then
    echo " ==> Installing nvim plugins"
    curl -fLo "${vim_plug_file}" --create-dirs "${vim_plug_url}"
    nvim +'PlugInstall --sync' +qall
fi

# pip

echo "==> Installing pip packages"
export PYTHONUSERBASE="${HOME}/.pip"
pip3 install --user \
    neovim-remote

# ...

echo ""
echo "==> Done!"
