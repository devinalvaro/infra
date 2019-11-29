provider "docker" {
  host = "ssh://${var.user}@${var.hostname}:${var.port}"
}

resource "docker_container" "base" {
  name  = "base"
  image = docker_image.home.latest
}

resource "docker_image" "home" {
  name = "devinalvaro/home"
}
