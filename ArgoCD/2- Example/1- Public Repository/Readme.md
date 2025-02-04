# Public Registry Argocd Image Pulling Example

Step by Step: Making argocd public repository example
``` bash
# Login to Argocd-UI: username and password
# Public repository add on the gitlab: Go to application settings. 
# Creating declarative manifest namespace, deployment and service under nginx folder.
# apply application yaml under gitops folder
kubectl apply -f application.yaml

# checking
kubectl get all -n test

```

Argocd Example with dockerhub and github
``` bash
# github reposiory should create
argocd repository created

# docker hub login and image push
# pull nginx image
docker pull nginx:latest

# docker login 
docker login -u denizyoutube

# docker image tag and push send docker hub
docker image tag nginx:latest denizyoutube/nginx:v1.0.0
docker push denizyoutube/nginx:v1.0.0

# deploment manifest with argocd on the github repository


```