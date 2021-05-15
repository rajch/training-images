# Matsya VM version 2.0

## Specifications
Alpine version 3.10.2-virtual with:
  - Edge kernel and repositories
  - Swap accounting on
  - curl, bash, bash-completion, soedit
  - docker V19.03
  - docker-compose
  - Virtualbox guest additions
  - XOrg-base
  - XFCE 4
  - Chromium browser
  - MousePad editor

## Instructions

1. Download alpine-virt-3.10.2-x86_64.iso (Alpine "virtual" image) from https://alpinelinux.org/. 
2. Create a virtual machine with at least 2 Cores, 4GB RAM, 80GB hard disk and VMSVGA graphics controller. 
3. Add Port Forwarding for the NAT Network, with Host Port:40022 and Guest Port:22. 
4. Mount the iso from step 1 on the CDROM device. 
5. Boot. Login as root, no password, and issue the `setup-alpine` command.
6. For keyboard layouts, choose **us** and for variant, choose **us**.
7. For hostname, specify **matsya**
8. Initialize the first available network interface with DHCP and no manual network configuration.
9. When asked for preferred repository mirror, choose 1. Do NOT choose "fastest".
10. When the setup is over, issue the `poweroff` command. Go to VM settings and remove the ISO file from the CDROM device. Start the VM. Login as root.
11. Edit **/etc/update-extlinux.conf**, and add 'swapaccount=1' to the variable **default_kernel_opts**.
12. Run `update-extlinux`. Reboot the VM with the `reboot` command.
13. Edit **/etc/apk/repositories**. Comment out all the lines containing **v3.10** repository and uncomment the lines containing **edge/main** and **edge/community**.
14. Run `apk upgrade --update-cache --available`.
15. Run `sync && reboot`. Log in as root.
16. Run `apk add sudo`
17. Use `visudo` to allow sudo access to "wheel" group.
18. Run `apk add curl bash bash-completion`
19. Run `wget -O - https://rajch.github.io/soedit-alpine-apk/init.sh | /bin/sh` followed by `apk update` and `apk add soedit`.
20. Run `apk add docker`.
21. Run `service docker start`. 
22. Run `docker system info`. Verify there is no warning for no swap limit support. 
23. If the last two steps work, run `rc-update add docker` to ensure docker runs at system startup.
24. Run `apk add docker-compose`.
25. Run `docker-compose`. Verify it is working.
26. Run `reboot`. Log in as root. Verify that docker has started.
27. Run `docker image pull alpine` and `docker image pull nginx:alpine`.
28. Run `adduser -g "User 1" -s /bin/bash user1`
29. Run `adduser user1 wheel`
30. Run `adduser user1 docker`
31. Log out and login as user1. Verify that you can issue docker commands.
32. (Optional) Edit **/etc/motd** with sudo.
33. Run `apk add virtualbox-guest-modules-virt virtualbox-guest-additions virtualbox-guest-additions-x11`. Verify the presence of **/usr/sbin/VBoxService**, **/usr/sbin/VBoxClient** and **/etc/init.d/virtualbox-guest-additions**.
34. Run `service virtualbox-guest-additions start`. Verify that it has started by running `ps aux | grep VBoxService`.
35. Copy or create the accompanying file **vbox-client** into **/etc/init.d/vbox-client**. Run `chmod +x /etc/init.d/vbox-client`.
36. Run `service vbox-client start`. Verify that it has started by running `ps aux | grep VBoxClient`.
37. If the last three steps have succeeded, run `rc-update add vbox-client` to ensure required VirtualBox guest functionality at startup.
38. Reboot the VM. Login as root.
39. Run `setup-xorg-base`
40. Run `apk add xfce4 xfce4-terminal xf86-input-mouse xf86-input-keyboard`
41. Run `apk add gnome-icon-theme`.
42. Run `apk add dbus`
43. Run `service dbus start`
44. Run `startx`. Verify GUI is working.
45. Put the VM window into full-screen mode. Put it back to normal mode and resize the window. Verify that the GUI resizes. in all cases.
46. Exit GUI.
47. If the last three steps have succeeded, run `rc-update add dbus`.
48. Run `apk add chromium mousepad`
49. Run `apk add lxdm`
50. Edit **/etc/lxdm/lxdm.conf**. Change the default session variable (line 10) to **session=/usr/bin/startxfce4**, and the show language select control variable (line 43) to **lang=0**.
51. Copy the accompanying file **vbox-clipboard** to **/usr/sbin/vbox-clipboard**. Run `chmod +x /usr/sbin/vbox-clipboard`.
52. Edit **/etc/lxdm/PreLogin**. Add the following line: `/usr/sbin/vbox-clipboard`.
53. Run `adduser user1 audio`
54. Run `adduser user1 video`
55. Run `adduser user1 dialout`
56. Run `adduser user1 vboxsf`
57. Run `service lxdm start`. 
58. Verify login as user1 is successful. 
59. Enable biderectional shared clipboard on the VM. Verify that guest additions for shared clipboard has started by running `ps aux | grep "VBoxClient --clipboard"`. Test copy/paste in and out of the VM.
60. Start a terminal and check if docker autocomplete is working. If not, run `shopt -q login_shell || echo source /etc/profile >> /home/user1/.bashrc` in the terminal, and close and restart the terminal. Check again.
61. Edit the terminal preferences using Edit menu/Preferences. In the Advanced tab, disable F1 and F10 keys. Close the terminal.
62. Start Chromium. Go to Settings, find Themes, and select "Use Classic". Close Chromium. 
63. Start MousePad. Go to Edit/Preferences, and choose a color scheme. Oblivion seems nice. Close MousePad.
64. If everything works, log out, click "Shutdown" from the LXDM greeter screen, and run `rc-update add lxdm`.
65. Reboot. Login as user1.
66. Set up desktop as desired. Panel setting are in **~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml**.
67. (Optional) Edit **/etc/motd**. Remove history by typing `history -c && rm ~/.bash_history` for user1 and `rm ~/.ash_history` for root. 
68. Export the VM as **matsya-2.0.ova**.


 
