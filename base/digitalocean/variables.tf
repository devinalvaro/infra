variable "digitalocean_token" {}

variable "droplet_name" {
  default = "base"
}
variable "droplet_image" {
  default = "ubuntu-19-10-x64"
}
variable "droplet_region" {
  default = "sgp1"
}
variable "droplet_size" {
  default = "s-1vcpu-1gb"
}

variable "ssh_key_name" {
  default = "default"
}
variable "ssh_key_pub_path" {}
variable "ssh_key_priv_path" {}

variable "user" {}
