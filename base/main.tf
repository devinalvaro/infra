provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "default" {
  name     = var.droplet_name
  image    = var.droplet_image
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.default.fingerprint]

  provisioner "file" {
    source      = "./bare/bare.sh"
    destination = "/tmp/bare.sh"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = digitalocean_droplet.default.ipv4_address
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bare.sh",
      "/tmp/bare.sh ${var.user} ${var.password}",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = digitalocean_droplet.default.ipv4_address
    }
  }

  provisioner "file" {
    source      = "./home/home.sh"
    destination = "/tmp/home.sh"

    connection {
      type        = "ssh"
      user        = var.user
      private_key = file(var.ssh_private_key_path)
      host        = digitalocean_droplet.default.ipv4_address
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/home.sh",
      "/tmp/home.sh ${var.password}",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = digitalocean_droplet.default.ipv4_address
    }
  }

  provisioner "file" {
    source      = "./work/work.sh"
    destination = "/tmp/work.sh"

    connection {
      type        = "ssh"
      user        = var.user
      private_key = file(var.ssh_private_key_path)
      host        = digitalocean_droplet.default.ipv4_address
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/work.sh",
      "/tmp/work.sh ${var.password}",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = digitalocean_droplet.default.ipv4_address
    }
  }
}

data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
}
