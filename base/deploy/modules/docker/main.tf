provider "docker" {
  host = "ssh://${var.user}@${var.hostname}:${var.port}"
}

resource "docker_container" "base" {
  name  = "base"
  image = docker_image.base.latest
  command = [
    "bash", "-c",
    "sudo service ssh start && tail -f /dev/null",
  ]
  restart = "always"

  ports {
    internal = 22
    external = 2222
  }
}

resource "docker_image" "base" {
  name = "devinalvaro/base"
}
