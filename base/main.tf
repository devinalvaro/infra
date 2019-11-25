provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "default" {
  name      = var.droplet_name
  image     = var.droplet_image
  region    = var.droplet_region
  size      = var.droplet_size
  ssh_keys  = [data.digitalocean_ssh_key.default.fingerprint]
  user_data = data.template_cloudinit_config.init.rendered

  provisioner "file" {
    source      = "${path.module}/scripts/base.sh"
    destination = "/tmp/base.sh"

    connection {
      user        = var.user
      host        = digitalocean_droplet.default.ipv4_address
      private_key = file(var.ssh_key_priv_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/base.sh",
      "/tmp/base.sh",
    ]

    connection {
      user        = var.user
      host        = digitalocean_droplet.default.ipv4_address
      private_key = file(var.ssh_key_priv_path)
    }
  }
}

data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
}
