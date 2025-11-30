# terraform_multipass
Examples of Terraform and Ansible on multipass hypervisor

## Use the Multipass SSH Key-Pair to access the VM

```
sudo ssh -i "/var/root/Library/Application Support/multipassd/ssh-keys/id_rsa" ubuntu@<vm-host>
```

## References
* [Terraform and Multipass](https://dev.to/todoroff/multipass-terraform-modern-vm-automation-guide-129l)
* [Terraform and Ansible](https://spacelift.io/blog/using-terraform-and-ansible-together)
* [Combining Terraform with Ansible for Provisioning and Configuration](https://shasheenrashmina.medium.com/automating-infrastructure-combining-terraform-with-ansible-for-provisioning-and-configuration-d55baaecb12c)
* [Introduction to cloud-init](https://cloudinit.readthedocs.io/en/latest/explanation/introduction.html)
