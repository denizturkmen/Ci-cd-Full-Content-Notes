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

# v2.11.3
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.11.3/manifests/install.yaml

# checking all object
kubectl get all -n argocd 

# patch to nodePort
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

# show admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64  -d && echo ""

# Defining ingress
kubectl apply -f argocd-ingress.yaml

# patches method for insecure
kubectl patch configmap argocd-cm -n argocd -p '{"data": {"server.insecure": "true"}}'
kubectl patch configmap argocd-cm -n argocd --type='merge' -p '{"data": {"server.insecure": "true"}}'

```


Install argocd cli
``` bash
# install
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# login
argocd login ip:port
    username: admin
    password: ******

# changed password command
argocd account update-password

```

Edit configMap
``` bash
kubectl get configmaps -n argocd 
NAME                        DATA   AGE
argocd-cm                   0      27h
argocd-cmd-params-cm        0      27h
argocd-gpg-keys-cm          0      27h
argocd-notifications-cm     0      27h
argocd-rbac-cm              0      27h
argocd-ssh-known-hosts-cm   1      27h
argocd-tls-certs-cm         0      27h
kube-root-ca.crt            1      27h

----------------------------------------------------------------------------
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
data:
  # sync polict period
  timeout.reconciliation: 240s

# Note
timeout.reconciliation time 0 for production

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
Sed editor fixed: https://unix.stackexchange.com/questions/633653/sed-error-bash-sed-i-s-ashu-vishu-test-txt-no-such-file-or-directory



```