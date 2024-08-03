# How to Deployment with Kustomize in ArgoCD


### How to install to helm with package manager: debian/ubuntu
``` bash
# The below run command
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm


# check version
helm version

```


# Deployment with Helm on the ArgoCD
``` bash
# apply: go to app directory
kubectl apply -f application.yaml

# check
kubectl get all -n dev

```