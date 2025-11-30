## Manually add the Mac’s public key to the VM.
We don't need to do this if we use cloud-init.

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