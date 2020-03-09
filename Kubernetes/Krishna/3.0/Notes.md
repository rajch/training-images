# Krishna VM version 3.0

## Specifications
Debian version 10.0 with:
  - Stock netinst setup 
  - SSH server only
  - Swap off
  - vim, curl
  - nano
  - docker 19.03.7-ce
  - kubelet, kubeadm, kubectl


## Instructions

## For debian base 10.0 
### Base Setup
1. Download **debian-9.9.0-amd64-netinst.iso** (Debian "stable" release) from https://www.debian.org/CD/http-ftp/. 
2. Create a virtual machine with at least 2 cores, 2GB RAM, 8MB video memory and 100GB hard disk. Mount the iso from step 1 on the CDROM device. Boot. From the installer, choose "Install".
3. In the "Set up users and passwords" step, provide a password for the root user, and create a user with "Full Name": User 1 and username: user1.
4. In the "Partition Disks" step, choose "Manual". Select the hard disk. Create a new, empty partition table on it. Select the "Free Space" on the hard disk. Create a new partition, using the maximum space available, type Primary. Set the Bootable flag to on. Finish partitioning and write the changes to disk. Confirm that you do not want swap space, and continue the installation.
5. In the "Software Selection" step, choose _only_ "SSH server".
6. Install GRUB to the hard disk, and complete the installation. Reboot.
7. **Note:** To prevent history from being recorded during setup, run `unset HISTFILE` on every login.
8. Log on as root. Edit **/etc/default/grub**, and set the variable **GRUB_TIMEOUT** to 0. Run `update-grub`. Reboot.
9. Log on as root. Run `apt update && apt install sudo`.
10. Run `adduser user1 sudo`. Log on as user1. Run `sudo ls` to deal with first-time sudo message. Log out.

### VirtualBox VM Additions
11. Login as root. Run `apt install build-essential linux-headers-$(uname -r) dkms`
12. Insert the VM Additions CD. Run `mount /media/cdrom`.
13. Run `sh /media/cdrom/VBoxLinuxAdditions.run`. Reboot.
14. Log in as root. Run `apt remove dkms linux-headers-$(uname -r) build-essential && apt autoremove`.

### Ensure legacy iptables.
15. Run the following:

```bash
apt-get install -y iptables arptables ebtables

update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
update-alternatives --set arptables /usr/sbin/arptables-legacy
update-alternatives --set ebtables /usr/sbin/ebtables-legacy
```
### Copy Scripts
Copy the attached **user1/rw-installscripts** directory to **/home/user1/rw-installscripts** as user1. Go to that directory and run `chmod +x *.sh`.

### Docker and Kubernetes
19. Run `sudo ./base-setup.sh` to install latest kubernetes and supported docker. Run `sudo KUBE_VERSION=<version> ./base-setup.sh` to install earlier supported versions. Currently suppported versions are:
    - 1.17.0-00
    - 1.16.0-00
    - 1.15.4-00    
20. Verify that docker is up by running `docker system info`. Verify that kubeadm is installed by running `kubeadm`. Verify the kubectl autocomplete works.

### User scripts and motd
22. Copy the attached **user1/rw-installscripts** directory to **/home/user1/rw-installscripts** as user1. Go to that directory and run `chmod +x *.sh`.
23. Optionally, copy the attached **/etc/motd** to **/etc/motd** as root.

### For compacting the VM
15. Run `dd if=/dev/zero of=zerofillfile bs=1G`
16. Run `rm zerofillfile`. 
17. Run `poweroff`.
18. On the host, run `VBoxManage modifyhd --compact "[drive]:\[path_to_image_file]\[name_of_image_file].vdi"`.


