provider "docker" {
  host = "ssh://${var.user}@${var.hostname}:${var.port}"
}

resource "docker_container" "base" {
  name    = var.container_name
  image   = docker_image.base.latest
  command = ["tail", "-f", "/dev/null"]
  restart = "always"
}

resource "docker_image" "base" {
  name = var.image_name
}
