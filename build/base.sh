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

# clojure

clojure_file="linux-install-1.10.1.492.sh"
clojure_url="https://download.clojure.org/install/${clojure_file}"
if [ ! -x "$(command -v clojure)" ]; then
    echo "==> Installing clojure"
    wget "${clojure_url}"
    chmod +x "${clojure_file}"
    sudo "./${clojure_file}"
    rm "${clojure_file}"
fi

lein_dir="${HOME}/.lein/bin"
lein_url="https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein"
if [ ! -x "$(command -v lein)" ]; then
    echo "==> Installing lein"
    wget -P "${lein_dir}" "${lein_url}"
    chmod +x "${lein_dir}/lein"
fi

# rust

if [ ! -x "$(command -v rustup)" ]; then
    echo "==> Installing rust"
    export PATH="${HOME}/.cargo/bin:$PATH"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    rustup component add rls rust-analysis rust-src
    rustup component add rustfmt
fi

# ...

# fish

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
