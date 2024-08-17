# How to Install and Configure ArgoCD Image Updater

### Pre-Requisites
``` bash
Argocd needs to be installed on kubernetes.


```

### Install Image Updater
``` bash
# stable version install
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml

# specific version install
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/v0.13.0/manifests/install.yaml

```


(pullsecret:argocd/dockerhub-secret)

### Public and Private key
``` bash
# create elipticcurl
ssh-keygen -t ed25519 -C "argocd@argocd.com" -f ~/.ssh/argocd_ed25519

# check public
cat ~/.ssh/argocd_ed25519.pub

# check private
cat ~/.ssh/argocd_ed25519

```

### Private repository connection via ArgoCD-UI
``` bash
# connect
Settings -> Connect Repo -> ssh keygen must be private and repository 


```



###  Configure Docker Hub as a Private Registry
``` bash
# First, create a Kubernetes secret with your Docker Hub credentials
kubectl create secret docker-registry dockerhub-secret \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<your-docker-username> \
    --docker-password=<your-docker-password> \
    --docker-email=<your-email> \
    -n argocd

# Create docker registry
kubectl create secret docker-registry dockerhub-secret \
    --docker-server="https://index.docker.io/v1/" \
    --docker-username="denizyoutube" \
    --docker-password="dckr_pat_pCfetWd3ZGqpxjExETt5-DL0nbs" \
    --docker-email="ytube.deniz.87@gmail.com" \
    -n argocd

# Success
kubectl create secret docker-registry dockerhub-secret \
    --docker-server="https://registry-1.docker.io" \
    --docker-username="denizyoutube" \
    --docker-password="dckr_pat_pCfetWd3ZGqpxjExETt5-DL0nbs" \
    --docker-email="ytube.deniz.87@gmail.com" \
    -n argocd

# checking
kubectl get secret -n argocd

```

### Editing argocd-image-updater-config configMap
``` bash
# Configure the ArgoCD Image Updater to use this secret. You can do this by editing the argocd-image-updater-config ConfigMap
kubectl edit configmap argocd-image-updater-config -n argocd
.
.
.

data:
  registries.conf: |
    registries:
      - name: DockerHub
        api_url: https://index.docker.io/v1/
        prefix: docker.io
        credentials: dockerhub-secret
---
data: 
  log.level: debug
  registries.conf: |
    registries:
    - name: Docker Hub
      prefix: docker.io
      api_url: https://registry-1.docker.io
      credentials: pullsecret:argocd/dockerhub-secret
      defaultns: library
      default: true

```

### Annotate ArgoCD Applications 
``` bash
# Annotate
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
  annotations:
    argocd-image-updater.argoproj.io/image-list: my-app=<your-docker-username>/my-app
spec:

# specific 
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: argocd-image-updater-ex
  namespace: argocd
  annotations:
    argocd-image-updater.argoproj.io/image-list: argocd-image-updater-ex=denizyoutube/nginx:v1.1.7
spec:
.
.
.

# Patches
kubectl patch configmap argocd-image-updater-config -n argocd -p '{"data":{"registries.conf":"registries:\n  - name: DockerHub\n    api_url: https://index.docker.io/v1/\n    prefix: docker.io\n    credentials: image-update-secret\n"}}'

```

### Verify the Setup
``` bash
# log inspect
kubectl logs -f deployment/argocd-image-updater -n argocd
or
kubectl logs -f -l app.kubernetes.io/name=argocd-image-updater -n argocd

```


### Image Tag Control
``` bash
kubectl  exec -it -n argocd argocd-image-updater-59ddbfd966-597hv -- sh
  argocd-image-updater test denizyoutube/nginx --update-strategy latest


```


### ArgoCD have four update strategy
``` bash
# semver: 
update to highest allowed version according to given image constraint,
# latest: 
update to the most recently created image tag,
# name: 
update to the last tag in an alphabetically sorted list
# digest: 
update to the most recent pushed version of a mutable tag


```


# Referance
``` bash
Release: https://github.com/argoproj-labs/argocd-image-updater/releases
getting started: https://argocd-image-updater.readthedocs.io/en/stable/install/installation/

```

