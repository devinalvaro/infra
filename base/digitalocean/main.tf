provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "base" {
  name      = var.droplet_name
  image     = var.droplet_image
  region    = var.droplet_region
  size      = var.droplet_size
  ssh_keys  = [digitalocean_ssh_key.default.fingerprint]
  user_data = data.template_cloudinit_config.init.rendered
}

resource "digitalocean_ssh_key" "default" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_key_pub_path)
}
