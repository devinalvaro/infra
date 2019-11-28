module "digitalocean" {
  source = "./digitalocean"

  digitalocean_token = var.digitalocean_token

  ssh_key_pub_path = var.ssh_key_pub_path
  ssh_key_priv_path = var.ssh_key_priv_path

  user = var.user
}

module "docker" {
  source = "./docker"

  user = var.user
  hostname = module.digitalocean.droplet_base_ipv4_address
  port = "22"
}
