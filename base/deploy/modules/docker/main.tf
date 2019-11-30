provider "docker" {
  host = "ssh://${var.user}@${var.hostname}:${var.port}"
}

resource "docker_container" "base" {
  name    = "base"
  image   = docker_image.home.latest
  command = ["tail", "-f", "/dev/null"]
  restart = "always"
}

resource "docker_image" "home" {
  name = "devinalvaro/home"
}
