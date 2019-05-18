# Matsya VM version 1.0

## Specifications
Alpine version 3.9.4-virtual with:
  - Edge kernel and repositories
  - Swap accounting on
  - curl, bash, bash-completion, nano
  - docker 18.09.6-ce
  - docker-compose
  - Virtualbox guest additions
  - XOrg-base
  - XFCE 4
  - Chromium browser
  - MousePad editor

## Instructions

1. Download alpine-virt-3.9.4-x86_64.iso (Alpine "virtual" image) from https://alpinelinux.org/. 
2. Create a virtual machine with at least 2 Cores, 4GB RAM and 80GB hard disk. Mount the iso from step 1 on the CDROM device. Boot. Login as root, no password, and issue the `setup-alpine` command.
3. When asked for preferred repository mirror, choose one. Do NOT choose "fastest".
4. When the setup is over, issue the `poweroff` command. Go to VM settings and remove the ISO file from the CDROM device. Start the VM. Login as root.
5. Edit **/etc/update-extlinux.conf**, and add 'swapaccount=1' to the variable **default_kernel_opts**.
6. Run `update-extlinux`. Reboot the VM with the `reboot` command.
7. Edit **/etc/apk/repositories**. Comment out the lines containing **v3.9** repository and uncomment the lines containing **edge/main** and **edge/community**.
8. Run `apk upgrade --update-cache --available`.
9. Run `sync && reboot`. Log in as root.
10. Run `apk add sudo`
11. Use `visudo` to allow sudo access to "wheel" group.
12. Run `apk add curl bash bash-completion nano`
13. Run `apk add docker`.
14. Run `service docker start`. 
15. Run `docker system info`. Verify there is no warning for no swap limit support. 
16. If the last two steps work, run `rc-update add docker` to ensure docker runs at system startup.
17. Run `apk add py-pip`. If you want docker-compose >= 1.24, run `apk add py-paramiko`.
18. Run `pip install docker-compose==1.23.2`. If If you want docker-compose >= 1.24, instead run `pip install docker-compose`.
19. Run `docker-compose`. Verify it is working.
20. Run `reboot`. Log in as root. Verify that docker has started.
21. Run `adduser -g "User 1" -s /bin/bash user1`
22. Run `adduser user1 wheel`
23. Run `adduser user1 docker`. You may need to run shopt -q login_shell || source /etc/profile >> /home/user1/.bashrc. Check later.
24. Run `apk add virtualbox-guest-modules-virt virtualbox-guest-additions virtualbox-guest-additions-x11`. Verify the presence of **/usr/sbin/VBoxService**, **/usr/sbin/VBoxClient** and **/etc/init.d/virtualbox-guest-additions**.
25. Run `service virtualbox-guest-additions start`. Verify that it has started by running `ps aux | grep VBoxService`.
26. Copy or create the accompanying file **vbox-client** into **/etc/init.d/vbox-client**. Run `chmod +x /etc/init.d/vbox-client`.
27. Run `service vbox-client start`. Verify that it has started by running `ps aux | grep VBoxClient`.
28. If the last three steps have succeeded, run `rc-update add vbox-client` to ensure required VirtualBox guest functionality at startup.
29. Reboot the VM. Login as root. 
30. Run `setup-xorg-base`
31. Run `apk add xfce4`. Maybe Run apk add xf86-input-mouse xf86-input-keyboard
32. Run `apk add faenza-icon-theme`.
33. Run `apk add dbus`
34. Run `service dbus start`
35. Run `startx`. Verify GUI is working.
36. Put the VM window into full-screen mode. Verify that the GUI resizes.
37. Exit GUI.
38. If the last three steps have succeeded, run `rc-update add dbus`.
39. Run `apk add lxdm`
40. Edit **/etc/lxdm/lxdm.conf**. Change the default session variable (line 10) to *session=/usr/bin/startxfce4*, and the show language select control variable (line 43) to *lang=0*.
41. Copy the accompanying file **vbox-clipboard** to **/usr/sbin/vbox-clipboard**. Run `chmod +x /usr/sbin/vbox-clipboard`.
42. Edit **/etc/lxdm/PreLogin**. Add the following line: `/usr/sbin/vbox-clipboard`.
43. Run `adduser user1 audio`
44. Run `adduser user1 video`
45. Run `adduser user1 dialout`
46. Run `adduser user1 vboxsf`
47. Run `service lxdm start`. 
48. Verify login as user1 is successful. 
49. Start a terminal and check if docker autocomplete is working.
50. Enable biderectional shared clipboard on the VM. Verify that guest additions for shared clipboard has started by running `ps aux | grep "VBoxClient --clipboard"`. Test copy/paste in and out of the VM.
51. If everything works, log out, click "Shutdown" from the LXDM greeter screen, and run `rc-update add lxdm`.
52. Run `apk add chromium mousepad`
53. Reboot. Login as user1.
54. Set up desktop as desired. Panel setting are in **~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml**.
56. In terminal preferences, disable F1 and F10 keys.
57. In mousepad preferences, set color scheme.
58. (Optional) Edit **/etc/motd**. Remove history by typing `history -c && rm ~/.bash_history` for user1 and `rm ~/.ash_history` for root. 
59. Export the VM as **matsya-1.0.ova**.
