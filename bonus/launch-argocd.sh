#!/bin/bash

# Apply argocd config file
kubectl apply -n argocd -f argo-app.yaml

# Expose Argo CD API server
kubectl port-forward svc/argocd-server -n argocd 8081:443
