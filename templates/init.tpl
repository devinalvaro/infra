#cloud-config

groups:
 - docker

users:
  - name: ${user}
    ssh-authorized-keys:
      - ${ssh_public_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups:
      - sudo
      - docker
    shell: /bin/bash

package_upgrade: true

packages:
  - docker.io

runcmd:
  - systemctl start docker
  - systemctl enable docker
