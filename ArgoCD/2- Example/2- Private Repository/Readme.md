# Private Registry Argocd Image Pulling Example

Argocd Example with dockerhub and github
``` bash
# created private repository on the github
my-app-private

# created private image on the dockerhub
my-app-image-private
21195831/my-app-image-private

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
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC//LQWgBpwv5InU6soGXTwmBP8p3L8XoKyMzxwa2H/sKdsxGy3BDO0z5hFkxpvKG++U+ZdYiqPhrm5GNUucbW0zFsLwSeebfhwamfipcmRSKFBNPHcEwX7RPm9k4Z0PxbUQMvhFRu31tJ5w1HbTUaM80R7qRddrS7OBC3olVlU8xaQA/bhfRB3HXeuvG8vXdQUhMasoT+2VTEZo0Y7d3pYs9FCoFncgofBNx6C/70VXSEZ9oW4YRvKDmHE0Xrp9Cki2OlhWeeRPBcd+l4PDHQvYeFF4r6+YjiXXxMKwqmTxy/zjTZazvIWaalopuQrRXkIJiURDgcfinKiT9tt9IQ28XNJVFxWszFN3znmchCLTIOiSsilYaQL9q4GlF3gChFcwSQJawugmcfWmGFedD0RPWaUl1OZbfjAD+sPXw+lnZx6RZOBg9iLcdPIcWPbOFZ3IxXVmN/Qcgbi2R4Q6JSdMZ0lhcMiOmtqPCt1+gztPqNyzUjJsUOaHwE2BQC/fKaPedL+3Z3Gy5kLb7GhnBfe78xS30d117h6nfGRD4Pi8sghy8C5/nNA6n+Fu4HWW3zJnOXVwa3ZXEpkzCmXB4NR2BS7BtOYgPxCqJZU2E+aqr+eDEcBsZZJbtVG5zee7O2R+qYhboqvo8jV3sCsgem2jkpWbbqFd4oZp6XlYCmpgQ== uudemytest@gmail.com

# created secret for pull private image. For this
kubectl apply -f github-repo-secret.yaml

# apply application.yml
kubectl apply -f application.yaml

# trouble_1: we should create a regcred for pull private image
kubectl delete -f application.yaml

```

Docker registry type secret creation
``` bash
# create 
# kubectl create secret docker-registry regsecret -n namespcace --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>

# adding recgred inside deployment manifest
spec:
    containers:
    - name:


    imagePullSecrets:
        - name: regcred

# apply aplication.yaml
kubectl apply -f application.yaml

```













# Refereance
``` bash
pulling private image: https://argo-cd.readthedocs.io/en/stable/user-guide/private-repositories/



```