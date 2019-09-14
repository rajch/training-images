# Krishna VM version 2.0

## Specifications
Debian version 10.0 with:
  - Stock netinst setup 
  - SSH server only
  - Swap off
  - vim, curl
  - soedit
  - docker 19.03.2-ce
  - kubelet, kubeadm, kubectl

## Instructions

1. Download **debian-10.0.0-amd64-netinst.iso** (Debian "stable" release) from https://www.debian.org/CD/http-ftp/. 
2. Create a virtual machine with at least 2 cores, 2GB RAM, 8GB video memory and 100GB hard disk. Mount the iso from step 1 on the CDROM device. Boot. From the installer, choose "Install".
3. In the "Set up users and passwords" step, provide a password for the root user, and create a user with "Full Name": User 1 and username: user1.
4. In the "Partition Disks" step, choose "Manual". Select the hard disk. Create a new, empty partition table on it. Select the "Free Space" on the hard disk. Create a new partition, using the maximum space available, type Primary. Set the Bootable flag to on. Finish partitioning and write the changes to disk. Confirm that you do not want swap space, and continue the installation.
5. In the "Software Selection" step, choose _only_ "SSH server".
6. Install GRUB to the hard disk, and complete the installation. Reboot.
7. Log on as root. Edit **/etc/default/grub**, and add 'swapaccount=1' to the variable **GRUB_CMDLINE_LINUX**. Run `update-grub`. Reboot.
8. Log on as root. Run `apt update && apt install sudo`.
9. Run `adduser user1 sudo`. 
10. Edit **/etc/ssh/sshd_config**. Add the line `PermitRootLogin yes`. Run `systemctl restart ssh`. Copy the attached **root/rw-installscripts** directory to **/root/rw-installscripts**. Go to that directory and run `chmod +x *.sh`.
11. Run `./base-setup.sh`.
12. Verify that docker is up by running `docker system info`. Verify that kubeadm is installed by running `kubeadm`. Verify the kubectl autocomplete works.
14. Optionally, change **/etc/motd**.
