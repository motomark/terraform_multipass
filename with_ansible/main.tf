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

# --------------------------------------------
# 1. Create Multipass VM and inject cloud-init.
# --------------------------------------------
resource "multipass_instance" "dev" {
  name   = "dev-vm"
  image  = "22.04"
  cpus   = 2
  memory = "2G"
  disk   = "10G"

  # Inject cloud-init
  cloud_init = file("${path.module}/cloud-init.yaml")   

}

# Output the VM IP so Ansible can use it
output "dev_ip" {
  value = multipass_instance.dev.ipv4
}

# ---------------------------------------
# 2. Create Ansible inventory dynamically.
# ---------------------------------------
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content  = <<EOF
[dev]
${multipass_instance.dev.ipv4[0]} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3
EOF
}

# --------------------------------
# 3. Run Ansible After VM is Ready (had issues so commented out for now).
# --------------------------------
#resource "null_resource" "ansible" {
#  depends_on = [
#    multipass_instance.dev,
#    local_file.ansible_inventory
#  ]
#
#  provisioner "local-exec" {
#    command = "ansible-playbook -i inventory.ini playbook.yml"
#  }
#}
