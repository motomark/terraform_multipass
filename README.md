# terraform_multipass
Example Terraform and Ansible on multipass hypervisor

## Add the Mac’s public key to the VM
SSH into the multipass vm using your normal ~/.ssh/id_rsa :

1. Run multipass shell <vm-name> to get a shell inside the VM.

2. Append your Mac’s public key into the VM’s ~/.ssh/authorized_keys, e.g.:

```cat ~/.ssh/id_rsa.pub | pbcopy      # on Mac  
multipass shell <vm-host>  
echo "<paste-the-pub-key-here>" >> ~/.ssh/authorized_keys  
chmod 600 ~/.ssh/authorized_keys  
exit  
```


Then you can SSH from your Mac without pointing to Multipass’s root-owned key. 
```
ssh ubuntu@<vm-host>
```

## Use the Multipass SSH Key-Pair to access the VM

This is going to bve useful when running Ansible.

```
sudo ssh -i "/var/root/Library/Application Support/multipassd/ssh-keys/id_rsa" ubuntu@<vm-host>
```

## References
* [Terraform and Multipass](https://dev.to/todoroff/multipass-terraform-modern-vm-automation-guide-129l)
* [Terraform and Ansible](https://spacelift.io/blog/using-terraform-and-ansible-together)
* [Combining Terraform with Ansible for Provisioning and Configuration](https://shasheenrashmina.medium.com/automating-infrastructure-combining-terraform-with-ansible-for-provisioning-and-configuration-d55baaecb12c)

