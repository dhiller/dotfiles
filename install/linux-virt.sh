#!/bin/bash

sudo dnf install -y make moby-engine kubernetes-client fuse-sshfs

# allow usage w/o root
sudo groupadd docker
sudo gpasswd -a $USER docker

# enable docker daemon on system start
sudo systemctl enable --now docker 
sudo systemctl start docker 

sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo dnf install -y kubectl

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.1/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install \
    --manifest=krew.yaml --archive=krew.tar.gz
)

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

echo "WARNING: this will terminate current gnome session! Continue? (y/N)"
read answer
if [ "$answer" != "y" ]; then
    exit 0
fi

gnome-session-quit
