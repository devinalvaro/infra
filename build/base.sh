#!/bin/bash

set -eu

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

# haskell

ghc_ver="8.10.3"
ghcup_bin="${HOME}/.ghcup/bin/ghcup"
if [ ! -x "$(command -v ghcup)" ]; then
    echo "==> Installing ghcup"
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 BOOTSTRAP_HASKELL_GHC_VERSION="${ghc_ver}" sh
    "${ghcup_bin}" install hls
fi

# rust

rustup_bin="${HOME}/.cargo/bin/rustup"
if [ ! -x "$(command -v rustup)" ]; then
    echo "==> Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    "${rustup_bin}" component add rustfmt
fi

# ...

# fish

if [ ! -x "$(command -v starship)" ]; then
    echo "==> Installing starship"
    curl -fsSL https://starship.rs/install.sh | sudo bash -s -- -y
fi

fisher_file="${HOME}/.config/fish/functions/fisher.fish"
if [ ! -f "${fisher_file}" ]; then
    echo " ==> Installing fisher"
    curl https://git.io/fisher --create-dirs -sLo "${fisher_file}"
    fish -c fisher install franciscolourenco/done
fi

# nvim

vim_plug_file="${HOME}/.local/share/nvim/site/autoload/plug.vim"
vim_plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ ! -f "${vim_plug_file}" ]; then
    echo " ==> Installing vim-plug"
    curl -fLo "${vim_plug_file}" --create-dirs "${vim_plug_url}"
fi

if [ ! -x "$(command -v nvr)" ]; then
    echo "==> Installing neovim-remote"
    PYTHONUSERBASE="${HOME}/.pip" pip3 install --user neovim-remote
fi

# ...

echo "==> Done!"
