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
}

data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
}
