# Install and Configure ArgoCD

Pre-requisites
Kubernetes clıuster must install


Install argocd with k8s manifest
``` bash
# latest version install
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# specific version install: v2.10.6
link: https://github.com/argoproj/argo-cd/releases
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.10.6/manifests/install.yaml

# patch to nodePort
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

# show admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64  -d 

```



Install argocd with helm
``` bash
# install helm with script on the ubuntu/debian




```

# Referans
``` bash
Get started: https://argo-cd.readthedocs.io/en/stable/getting_started/
Release: https://github.com/argoproj/argo-cd/releases
Helm: https://github.com/argoproj/argo-helm



```