coming soon

``` bash
# stable version install
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/main/manifests/install.yaml

# specific version install
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/v0.13.0/manifests/install.yaml


# template: create secret 
kubectl create secret docker-registry dockerhub-secret \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<your-docker-username> \
    --docker-password=<your-docker-password> \
    --docker-email=<your-email> \
    -n argocd

# create docker registry
kubectl create secret docker-registry image-update-secret \
    --docker-server="https://index.docker.io/v1/" \
    --docker-username="denizyoutube" \
    --docker-password="" \
    --docker-email="ytube.deniz.87@gmail.com" \
    -n argocd


# kubectl edit configmap argocd-image-updater-config -n argocd
# tempalate
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-image-updater-config
  namespace: argocd
data:
  registries.conf: |
    registries:
      - name: DockerHub
        api_url: https://index.docker.io/v1/
        prefix: docker.io
        credentials: image-update-secret 

# edit
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-image-updater-config
  namespace: argocd
data:
  registries.conf: |
    registries:
      - name: DockerHub
        api_url: https://index.docker.io/v1/
        prefix: docker.io
        credentials: dockerhub-secret
 
 # Patches
 kubectl patch configmap argocd-image-updater-config -n argocd -p '{"data":{"registries.conf":"registries:\n  - name: DockerHub\n    api_url: https://index.docker.io/v1/\n    prefix: docker.io\n    credentials: image-update-secret\n"}}'
     
```

### 
``` bash



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