#!/bin/sh
set -e

## Install system tools
echo "Adding system utilities, vim and curl..."
apt update
apt purge -y vim-tiny
apt install -y apt-transport-https bash-completion vim curl
echo "Done."

## Install docker
echo "Installing docker..."
wget -O - http://get.docker.com | /bin/sh
echo "Adding daemon.json for configuring cgroup driver..."
cat<<EOCD >/etc/docker/daemon.json
{
    "exec-opts": [ "native.cgroupdriver=systemd" ]
}
EOCD
systemctl restart docker
echo "Adding user user1 to docker group..."
adduser user1 docker
echo "Done."

## Install kubelet, kubeadm, kubectl
echo "Installing kubelet, kubeadm and kubectl..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
echo "Done."

## Add kubectl autocomplete
echo "Installing kubectl autocomplete..."
kubectl completion bash >/etc/bash_completion.d/kubectl
echo "Done."
