# Krishna VM version 4.0-alpine

## Specifications
Alpine Linux version 3.12.0-virtual with:
  - Edge repositories 
  - Swap off
  - sudo, vim, curl, bash, bash-completion, soedit
  - docker
  - kubelet, kubeadm, kubectl

## Instructions

### OS Setup
1. Download **alpine-virt-3.12.0-x86_64.iso** (Alpine "virtual" image) from https://alpinelinux.org/. 
2. Create a virtual machine with at least 2 cores, 2GB RAM, and 100GB hard disk. 
3. Mount the iso from step 1 on the CDROM device.
5. Boot. Login as root, no password, and issue the `setup-alpine` command.
6. For keyboard layouts, choose **us** and for variant, choose **us**.
7. For hostname, specify **krishna**
8. Initialize the first available network interface with DHCP and no manual network configuration.
9. When asked for preferred repository mirror, choose 1. Do NOT choose "fastest".
10. When the setup is over, issue the `poweroff` command. Go to VM settings and remove the ISO file from the CDROM device. Start the VM. Login as root.
7. **Note:** To prevent history from being recorded during setup, run `unset HISTFILE` on every login.

11. Edit **/etc/update-extlinux.conf**, and add set the variable **timeout** to 1.
12. Run `update-extlinux`. Reboot the VM with the `reboot` command.

12. Login as root. Run `swapoff -a`. Edit **/etc/fstab**, and comment out the line containing "swap".

13. Edit **/etc/apk/repositories**. Comment out all the lines containing **v3.12** repository and uncomment the lines containing **edge/main**, **edge/community**,  and **edge/testing**.
14. Run `apk upgrade --update-cache --available`.
15. Run `sync && reboot`. Log in as root.

16. Run `apk add sudo`
17. Use `visudo` to allow sudo access to "sudo" group.
17. Run `addgroup sudo` to add the "sudo" group.
18. Run `apk add vim curl bash bash-completion`.

19. Run `adduser -g "User 1" -s /bin/bash user1`.
20. Run `adduser user1 sudo`.


### VirtualBox VM Additions
33. Run `apk add virtualbox-guest-modules-virt virtualbox-guest-additions`. Verify the presence of **/usr/sbin/VBoxService**, **/usr/sbin/VBoxClient** and **/etc/init.d/virtualbox-guest-additions**.
34. Run `service virtualbox-guest-additions start`. Verify that it has started by running `ps aux | grep VBoxService`.
35. If the previous two steps succeeded, run `rc-update add virtualbox-guest-additions`. Reboot.

### Copy Scripts
16. Copy the attached **user1/rw-installscripts** directory to **/home/user1/rw-installscripts** as user1. Go to that directory and run `chmod +x *.sh`. If copied from Windows, change to Unix line ending by running `sed "s/\r$//" *.sh`.

### Docker 
17. Logon as root. 
18. Run `apk add docker`.
21. Run `service docker start`. 
23. If the last two steps work, run `rc-update add docker` to ensure docker runs at system startup.

### Kubernetes
24. Run `apk add kubelet`. This will also install a package called cni-plugins in **/usr/libexec/cni**.
25. Run `mkdir -p /opt/cni/bin && cp -r /usr/libexec/cni/* /opt/cni/bin/`. This will copy cni plugins to the **/opt/cni/bin** directory. This is required by the weave overlay network plugin.
26. Run `rc-update add kubelet`.
27. Run `apk add kubeadm`.
28. Run `apk add kubectl`.

### (Optional) motd
19. Optionally, copy the attached **/etc/motd** to **/etc/motd** as root.

### For compacting the VM
20. Run `dd if=/dev/zero of=zerofillfile bs=1G`
21. Run `rm zerofillfile`. 
22. Run `poweroff`.
23. On the host, run `VBoxManage modifyhd --compact "[drive]:\[path_to_image_file]\[name_of_image_file].vdi"`.
