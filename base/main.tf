module "digitalocean" {
  source = "./digitalocean"

  digitalocean_token = var.digitalocean_token

  droplet_name = var.droplet_name
  droplet_image = var.droplet_image
  droplet_region = var.droplet_region
  droplet_size = var.droplet_size

  ssh_key_name = var.ssh_key_name
  ssh_key_pub_path = var.ssh_key_pub_path
  ssh_key_priv_path = var.ssh_key_priv_path

  user = var.user
}
