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
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

```

Install argocd with helm 
``` bash
# added helm chart repo
helm repo add argo https://argoproj.github.io/argo-helm

# update helm repo
helm repo update

# argocd version search
helm search repo argocd

# import values.yml
helm show values argo/argo-cd

# import a specific values.yaml
helm show values argo/argo-cd --version 3.35.4 




```


Install argocd with terraform
``` bash
# install terraform on ubuntu
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform

# verify
terraform

```

Argocd install and configure via Terraform
``` bash
# step_1:


```




# Referans
``` bash
Get started: https://argo-cd.readthedocs.io/en/stable/getting_started/
Release: https://github.com/argoproj/argo-cd/releases
Helm: https://github.com/argoproj/argo-helm
insecure_flag: https://argo-cd.readthedocs.io/en/stable/operator-manual/tls/
autopilot: https://github.com/argoproj-labs/argocd-autopilot
install: https://github.com/argoproj/argo-cd/tree/master/manifests?source
Terraform_Install: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli



```