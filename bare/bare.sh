#!/bin/sh

echo "==> Creating user"
useradd -m -r -p $(openssl passwd $password) -s $SHELL $user

echo "==> Adding user to sudo"
usermod -aG sudo $user

echo "==> Copying ssh keys to user"
cp -r .ssh/ /home/$user/
chown -R $user:$user /home/$user/.ssh/
