# Using Terraform and Ansible with Multipass
Create a VM in [Multipass](https://canonical.com/multipass) using Terraform then install Nginx with a Home page using ansible. This explains how to configure Ansible and ensure the VM has SSH configured with public key of the Ansible control node for passwordless access to the VM in Multipass.

## Running terraform and ansible to create and configure the VM
```
# Create the VM using terraform. 
$ terraform init
$ terraform apply

# Test the SSH connection first.
$ ssh ubuntu@<VM_IP_ADDRESS>

# Run the ansible playbook with the configuration.
$ ansible-playbook -i inventory.ini playbook.yml
```

## Configuration Notes

### main.tf -  create an inventory file using a local_file resource

Terraform creates an ansible inventory ini file with the ip address of the new VM, configure python and point to the pre-generated SSH private key.
```
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content  = <<EOF
[dev]
${multipass_instance.dev.ipv4[0]} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3
EOF
}
``` 
### main.tf -  Inject the cloud-init configuration
Terraform reference to the 'cloud-init' file we use to post-configure the VM. This configuration must transfer the SSH public key (authorized_keys) to the VM first.
```
# Inject cloud-init
cloud_init = file("${path.module}/cloud-init.yaml")
```

### cloud-init.yaml
The 'cloud-init' file used to post-configure the VM with SSH keys:
```
#cloud-config
users:
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: sudo
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD...your_public_key_here...
```
### playbook.yml
See the YAML file example. Installs Nginx with a sample home page.
