provider "docker" {
  host = "ssh://${var.user}@${var.hostname}:${var.ssh_port}"
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
    internal = var.ssh_port
    external = var.container_ssh_port
  }
}

resource "docker_image" "base" {
  name = "devinalvaro/base"
}
