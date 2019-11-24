#!/bin/bash

user="${1-none}"
password="${2-none}"

if [ "${user}" == "none" ] || [ "${password}" == "none" ]; then
    echo "Usage: $(basename $0) <user> <password>"
    exit
fi

if [ ! "$(id -u ${user} 2> /dev/null)" ]; then
    echo "==> Creating user"
    useradd -m -r -p $(openssl passwd $password) -s $SHELL $user
fi

if [ ! "$(groups ${user} | grep -w sudo 2> /dev/null)" ]; then
    echo "==> Adding user to sudo"
    usermod -aG sudo $user
fi

ssh_dir="$HOME/.ssh"
user_ssh_dir="/home/$user/.ssh"
if [ ! -d "${user_ssh_dir}" ]; then
    echo "==> Copying ssh keys to user"
    cp -r "${ssh_dir}" "${user_ssh_dir}"
    chown -R $user:$user "${user_ssh_dir}"
fi
