#cloud-config
users:
  - name: ${user}
    ssh-authorized-keys:
      - ${ssh_public_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash

package_upgrade: true
