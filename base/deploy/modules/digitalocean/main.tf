provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "base" {
  name      = var.droplet_name
  image     = var.droplet_image
  region    = var.droplet_region
  size      = var.droplet_size
  ssh_keys  = [data.digitalocean_ssh_key.default.fingerprint]
  user_data = data.template_cloudinit_config.init.rendered

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait",
    ]

    connection {
      private_key = file(var.ssh_key_priv_path)
      host        = digitalocean_droplet.base.ipv4_address
    }
  }
}

data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
}
