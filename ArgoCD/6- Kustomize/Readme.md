# How to Deployment with Kustomize in ArgoCD

### Standalone kustomize install on k8s cluster

``` bash
# Install
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# permission 
sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize

# check
kustomize version

```

### Example-kustomize: Dev-Environment
``` bash
├── kustomize
  ├── base
    │   ├── namespace.yaml
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   ├── kustomization.yaml     
    └ overlays
        ├── dev
        │   └── kustomization.yaml
        └── uat
            └── kustomization.yaml

# build dev env: go to directory
cd /kustomize/overlays/dev
kustomize build .
or
kubectl kustomize .

# apply: go to app directory
kubectl apply -f application.yaml

# check
kubectl get deployments -n dev
kubectl get service -n dev
kubectl get pods -n dev
kubectl get secrets -n dev
kubectl get secrets -o yaml 
  echo -n "XXXX" | base64 -d 
kubectl exec -it -n namespace pod_name -- env

# all object
kubectl get all -n namespace


```

