#!/bin/bash

# K3d
k3d cluster create -c k3d-cluster.yaml

# Argo CD
kubectl create ns argocd
kubectl create ns dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -f argo-app.yaml

# Wait for pods to be ready
sleep 5
kubectl wait --for=condition=Ready pods --all -n argocd

echo "=== Argo CD Api server password command retrieval ===\n$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo"

# Expose Argo CD API server
kubectl port-forward svc/argocd-server -n argocd 8080:443

