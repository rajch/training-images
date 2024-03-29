# Matsya VM version 6.0

## Specifications
Alpine version 3.15.0-virtual with:
  - Swap accounting on
  - sudo, curl, bash, bash-completion
  - docker v20.10.11
  - Compose plugin v2.2.2
  - Buildx plugin v0.7.1
  - Virtualbox guest additions
  - XOrg-base
  - XFCE 4
  - Chromium browser
  - MousePad editor

## Instructions

1. Download alpine-virt-3.15.0-x86_64.iso (Alpine "virtual" image) from https://alpinelinux.org/. 
2. Create a virtual machine, with Type: Linux, Version: Other Linux (64-bit) and at least 2 Cores, 4GB RAM, 100GB hard disk and VMSVGA graphics controller. 
3. Add Port Forwarding for the NAT Network, with Host Port:50022 and Guest Port:22. 
4. Mount the iso from step 1 on the CDROM device. 
5. Boot. Login as root, no password, and issue the `setup-alpine` command.
6. For keyboard layouts, choose **us** and for variant, choose **us**.
7. For hostname, specify **matsya**
8. Initialize the first available network interface with DHCP and no manual network configuration.
9. When asked for preferred repository mirror, choose 1. Do NOT choose "fastest".
10. When the setup is over, issue the `poweroff` command. Go to VM settings and remove the ISO file from the CDROM device. Start the VM. Login as root.
11. Edit **/etc/update-extlinux.conf**, and add 'swapaccount=1' to the variable **default_kernel_opts**. Change the value of the variable **timeout** to 1.
12. Run `update-extlinux`. Reboot the VM with the `reboot` command. Log in as root.
13. Edit **/etc/apk/repositories**. Uncomment the line ending in **v3.13/community**.
14. Run `apk update`.
15. Run `apk add sudo`
16. Use `visudo` to allow sudo access to "wheel" group.
17. Run `apk add curl bash bash-completion`
18. Run `apk add docker`.
19. Run `service docker start`. 
20. Run `docker system info`. Verify there is no warning for no swap limit support. 
21. If the last two steps work, run `rc-update add docker` to ensure docker runs at system startup.
22. Run `reboot`. Log in as root. Verify that docker has started.

23. Run `adduser -g "User 1" -s /bin/bash user1`
24. Run `adduser user1 wheel`
25. Run `adduser user1 docker`
26. Log out and login as user1. Run `unset HISTFILE`. Run that every time you log on as user1 during setup. 
27. Run `docker image pull alpine` and `docker image pull nginx:alpine`. Verify that this works, and you can issue other docker commands.
28. Run `sudo mkdir -p /usr/local/lib/docker/cli-plugins`. Enter the password when prompted by sudo. Verify that sudo works. Then, run `sudo curl -L -o /usr/local/lib/docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64`.  Then, run `sudo curl -L -o /usr/local/lib/docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.7.1/buildx-v0.7.1.linux-amd64`. Finally, run `sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-*`.
29. Run `docker compose`. Verify that it works. Run `docker buildx`. Verify that it is works.
30. Logout and login as root.
31. Run `apk add virtualbox-guest-additions virtualbox-guest-additions-x11`. Verify the presence of **/usr/sbin/VBoxService**, **/usr/sbin/VBoxClient** and **/etc/init.d/virtualbox-guest-additions**.
32. Run `service virtualbox-guest-additions start`. Verify that it has started by running `ps aux | grep VBoxService`.
33. If the last two steps have succeeded, run `rc-update add virtualbox-guest-additions` to ensure required VirtualBox guest functionality at startup.
34. Reboot the VM. Login as root.
35. Run `setup-xorg-base`
36. Run `apk add xfce4 xfce4-terminal gvfs`
37. Run `apk add gnome-icon-theme adwaita-icon-theme`.
38. Run `apk add dbus`
39. Run `service dbus start`
40. Run `startx`. Verify GUI is working.
41. If the GUI works, exit by choosing Log Out from the Applications menu.
42. Run `rc-update add dbus`.
43. Run `apk add chromium mousepad`
44. Run `apk add lxdm`
45. Edit **/etc/lxdm/lxdm.conf**. Change the default session variable (line 10) to **session=/usr/bin/startxfce4**, and the show language select control variable (line 43) to **lang=0**.
46. Copy the accompanying file **vbox-integration** to **/usr/sbin/vbox-integration**. Run `chmod +x /usr/sbin/vbox-integration`.
47. Edit **/etc/lxdm/PreLogin**. Add the following line: `/usr/sbin/vbox-integration`.
48. Run `adduser user1 audio`
49. Run `adduser user1 video`
50. Run `adduser user1 dialout`
51. Run `adduser user1 vboxsf`
52. Run `service lxdm start`. 
53. Verify login as user1 is successful. 
54. Put the VM window into full-screen mode. Put it back to normal mode and resize the window. Verify that the GUI resizes. in all cases.
55. Enable biderectional shared clipboard on the VM. Verify that guest additions for shared clipboard has started by running `ps aux | grep "VBoxClient --clipboard"`. Test copy/paste in and out of the VM.
56. Start a terminal and check if docker autocomplete is working. If not, run `shopt -q login_shell || echo source /etc/profile >> /home/user1/.bashrc` in the terminal, and close and restart the terminal. Check again.
57. Start Chromium. Go to Settings, find Themes, and select "Use Classic". Close Chromium. 
58. If everything works, log out, click "Shutdown" from the LXDM greeter screen, and run `rc-update add lxdm`.
59. Reboot. Login as user1.
60. (Optional) Set up desktop as desired. Panel setting are in **~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml**.
61. (Optional) Edit **/etc/motd**. 
62. Remove history by typing `history -c && rm ~/.bash_history` for user1 and `rm ~/.ash_history` for root. Shut down.
63. (Optional) Modify the VM icon.
63. Export the VM as **matsya-6.0.ova**.


 
