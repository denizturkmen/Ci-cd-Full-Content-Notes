# Private Registry Argocd Image Pulling Example

### Pre-requitites
 1- github adress: uudemytest@gmail.com
 2- docker hub: denizyoutube

Argocd Example with dockerhub and github
``` bash
# created private repository on the github
argocd-private

# created private image on the dockerhub
denizyoutube/private_image:v1.0.0

```


There are 3 different ways to pull a private image on github.
``` bash
# 1- personel access token
# 2- github application
# 3- ssh keygen and we prefer ssh-keygen for CI/CD  

# created ssh-keygen for deploy token
ssh-keygen -t rsa -b 4096 -C "uudemytest@gmail.com" -f ~/.ssh/argocd_deploy_token

# go to ssh-keygen directories: private and public keys
cd ~/.ssh/
ls -al

# adding public.key on github repository. For this; go to private repository then click on settings. Click on from left menu deploy keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC//LQWgBpwv5InU6soGXTwmBP8p3L8XoKyMzxwa2H/sKdsxGy3BDO0z5hFkxpvKG++U+ZdYiqPhrm5GNUucbW0zFsLwSeebfhwamfipcmRSKFBNPHcEwX7RPm9k4Z0PxbUQMvhFRu31tJ5w1HbTUaM80R7qRddrS7OBC3olVlU8xaQA/bhfRB3HXeuvG8vXdQUhMaso4Pi8sghy8C5/nNA6n+Fu4HWW3zJnOXVwa3ZXEpkzCmXB4NR2BS7BtOYgPxCqJZU2E+aqr+eDEcBsZZJbtVG5zee7O2R+qYhboqvo8jV3sCsgem2jkpWbbqFd4oZp6XlYCmpgQ== uudemytest@gmail.com

# created secret for pull private image. For this
kubectl apply -f github-repo-secret.yaml

# apply application.yml
kubectl apply -f application.yaml

# trouble_1: we should create a regcred for pull private image
kubectl delete -f application.yaml

```

Docker registry type secret creation
``` bash
# tempalte: create 
# docker-registry create for docker hub
kubectl create secret docker-registry -n test-private regcred-dockerhub \
  --docker-server="https://index.docker.io/v1/"  \
  --docker-username="denizyoutube" \
  --docker-password="dckr_pat_XeBHGmXC3ELTXRWfANgy7yY6wgY" \
  --docker-email="uudemytest@gmail.com"

# adding recgred inside deployment manifest
spec:
    containers:
    - name:


    imagePullSecrets:
        - name: regcred-dockerhub

# apply aplication.yaml
kubectl apply -f application.yaml

```













# Refereance
``` bash
pulling private image: https://argo-cd.readthedocs.io/en/stable/user-guide/private-repositories/



```