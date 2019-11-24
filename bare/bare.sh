#!/bin/bash

user="${1-none}"
password="${2-none}"

if [ "${user}" == "none" ] || [ "${password}" == "none" ]; then
    echo "Usage: $(basename $0) <user> <password>"
    exit
fi

echo "==> Creating user"
useradd -m -r -p $(openssl passwd $password) -s $SHELL $user

echo "==> Adding user to sudo"
usermod -aG sudo $user

echo "==> Copying ssh keys to user"
cp -r .ssh/ /home/$user/
chown -R $user:$user /home/$user/.ssh/
