#!/bin/bash

# K3d
k3d cluster create -c k3d-default.yaml

# Argo CD
kubectl create ns argocd
kubectl create ns dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Gitlab
kubectl create ns gitlab
kubectl apply -n gitlab -f gitlab-app.yaml

# Wait for pods to be ready
sleep 2
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=-1s
kubectl wait --for=condition=Ready pods --all -n gitlab --timeout=-1s

# Gitlab Service LoadBalancer ExternalIP
sudo echo "$(kubectl get svc -n gitlab gitlab-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}') gitlab.example.com" >> /etc/hosts

echo "=== Argo CD Api server password command retrieval ===
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo"
