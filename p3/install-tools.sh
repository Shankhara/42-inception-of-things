#!/bin/bash

# MAJ
sudo apt update && sudo apt upgrade -y

# K3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "alias k='kubectl'" >> ~/.zshrc

# Argo CD CLI
wget https://github.com/argoproj/argo-cd/releases/download/v2.3.3/argocd-linux-amd64 -O argocd
chmod +x argocd
mv argocd /usr/local/sbin/
