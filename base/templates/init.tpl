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

runcmd:
  - apt-get install docker.io
  - systemctl start docker
  - systemctl enable docker
