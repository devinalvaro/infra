module "digitalocean" {
  source = "./modules/digitalocean"

  digitalocean_token = var.digitalocean_token

  user = var.user
}

module "docker" {
  source = "./modules/docker"

  user = var.user
  hostname = module.digitalocean.droplet_base_ipv4_address
  port = "22"
}
