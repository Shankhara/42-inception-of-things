#!/bin/bash

# MAJ
sudo apt-get update && sudo apt-get upgrade -y

# Docker
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
newgrp docker

# K3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "alias k='kubectl'" >> ~/.zshrc

# Argo CD CLI
wget https://github.com/argoproj/argo-cd/releases/download/v2.3.3/argocd-linux-amd64 -O argocd
sudo chmod +x argocd
sudo mv argocd /usr/local/sbin/

# Vagrant
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vagrant
