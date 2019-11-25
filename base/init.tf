data "template_cloudinit_config" "init" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init.rendered
  }

  part {
    filename     = "base.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/scripts/base.sh")
  }
}

data "template_file" "init" {
  template = file("${path.module}/templates/init.tpl")
  vars = {
    user           = var.user
    ssh_public_key = data.digitalocean_ssh_key.default.public_key
  }
}
