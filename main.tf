module "digitalocean" {
  source = "./modules/digitalocean"

  digitalocean_token = var.digitalocean_token
}

module "docker" {
  source = "./modules/docker"

  hostname = module.digitalocean.droplet_base_ipv4_address
}
