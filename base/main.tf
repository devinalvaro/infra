module "digitalocean" {
  source = "./digitalocean"

  digitalocean_token = var.digitalocean_token

  user = var.user
}

module "docker" {
  source = "./docker"

  user = var.user
  hostname = module.digitalocean.droplet_base_ipv4_address
  port = "22"
}
