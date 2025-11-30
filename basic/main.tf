terraform {
  required_version = ">= 1.6.0"

  required_providers {
    multipass = {
      source  = "todoroff/multipass"
      version = ">= 1.2.0"
    }
  }
}

provider "multipass" {
  default_image = "lts"
}

data "multipass_images" "lts" {
  alias = "lts"
}

resource "multipass_instance" "dev" {
  name   = "dev-box"
  image  = data.multipass_images.lts.images[0].name
  cpus   = 2
  memory = "4G"
  disk   = "15G"

  networks {
    name = "en0"
  }

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.ipv4}"
  }

  connection {
      type        = "ssh"
      host        = self.ipv4
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      timeout     = "4m"
   }

}

resource "multipass_alias" "shell" {
  name     = "dev-shell"
  instance = multipass_instance.dev.name
  command  = "bash"
}

output "dev_ip" {
  value = multipass_instance.dev.ipv4
}

