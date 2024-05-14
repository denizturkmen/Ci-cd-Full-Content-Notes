Example of Kubernetes



GitLab access to kubernetes
``` bash
# create sa
kubectl create sa gitlab

# check sa
kubectl get sa

# create rbac
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: developer
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["services", "deployments", "replicasets", "pods", "configmap"]
  verbs: ["*"]

# apply
kubectl apply -f role-dev.yaml

# check
kubectl get role | grep developer

# create role-bind
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: gitlab-developer
  namespace: default
subjects:
- kind: User
  name: system:serviceaccount:default:gitlab
  apiGroup: ""
roleRef:
  kind: Role
  name: developer
  apiGroup: ""

# apply
kubectl apply -f role-dev-bind.yaml

# check
kubectl get rolebindings.rbac.authorization.k8s.io | grep developer

# check auth
kubectl auth can-i list pods --as=system:serviceaccount:default:gitlab

# create token via service account
apiVersion: v1
kind: Secret
metadata:
  name: <secretname>
  annotations:
    kubernetes.io/service-account.name: <serviceaccount-name>
type: kubernetes.io/service-account-token
---
apiVersion: v1
kind: Secret
metadata:
  name: gitlab-token-new
  annotations:
    kubernetes.io/service-account.name: gitlab
type: kubernetes.io/service-account-token

# apply
kubectl apply -f secret-token.yaml

# edit service account
kubectl edit sa gitlab
.
.
.
secrets:
- name: gitlab-token-new 


# check
kubectl get secrets
kubectl get secrets gitlab-token-new -oyaml
kubectl get secrets gitlab-token-new -oyaml | grep token:


```

To allow access from Kubernetes to the GitLab registry, navigate to Personal menu > Settings > Access Tokens and create a Personnal Access Token with the scope api.

TOKEN!!!!!!

Now we have to extract the token that kubernetes created for the gitlab account;
``` bash
# apply
kubectl create secret docker-registry gitlab-login-token 
  --docker-server=<gitlab.server:port>
  --docker-username=<gitlab-token-name> 
  --docker-password=<gitlab-token>


kubectl create secret docker-registry gitlab-push-token --docker-server=gitlab.devops-deniz.net:5010 --docker-username=turkmen --docker-password=glpat-bTnzVVm_dsMezKX3VmeY

```

Adding .gitlab-ci.yml
``` bash
# gitlav-ci.yml add
stages:
  - test
  - build
  - deploy

deploy:
  stage: deploy
  image: cylab/kubectl
  tags:
    - devops-docker-1
  before_script:
    # create the configuration (context) for our kubernetes cluster
    - kubectl config set-cluster deploy-cluster --server="$KUBE_SERVER" --insecure-skip-tls-verify
    - kubectl config set-credentials gitlab --token=$(echo $KUBE_TOKEN | base64 -d)
    - echo $KUBE_TOKEN
    - kubectl config set-context deploy-cluster --cluster=deploy-cluster --namespace=default --user=gitlab
    - kubectl config use-context deploy-cluster

  script:
    - kubectl get pods
    - envsubst < deploy.tmpl > deploy.yaml
    - kubectl apply -f deploy.yaml

# CI/CD variables add
KUBE_SERVER=https://kubernetes.deniz.master.internal:6443
KUBE_TOKEN=base64

```



# TroubleShooting_1
``` bash
# issue
fatal: unable to access 'https://gitlab.devops-deniz.net/java/k8s-executer-test.git/': Could not resolve host: gitlab.devops-deniz.net

# solution
sudo -i
cd /etc/gitlab
vim config.toml
  .
  .
  .
[[runners]]
  name = "docker-runner"
  url = "https://gitlab.devops-deniz.net/"
  id = 2
  token = "8hHo9PquHybenMHtRFM8"
  token_obtained_at = 2024-03-10T19:41:16Z
  token_expires_at = 0001-01-01T00:00:00Z
  tls-ca-file = "/etc/ssl/certs/gitlab/gitlab.crt"
  executor = "docker"
  [runners.cache]
    MaxUploadedArchiveSize = 0
  [runners.docker]
    tls_verify = false
    image = "docker"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
    network_mtu = 0
    extra_hosts = ["gitlab.devops-deniz.net:192.168.1.10"]

# restarted
sudo systemctl restart gitlab-runner.service

# status
sudo systemctl status gitlab-runner.service

```


# Troubleshooting_2
```bash
# Issue
E0315 16:26:43.575080      '''48 memcache.go:265] couldn't get current server API group list: Get "https://kubernetes.deniz.master.internal:6443/api?timeout=32s": dial tcp 192.168.1.1:6443: connect: connection refused''

# Solved
sudo -i
cd /etc/gitlab
vim config.toml
  .
  .
  .
[[runners]]
  name = "docker-runner"
  url = "https://gitlab.devops-deniz.net/"
  id = 2
  token = "8hHo9PquHybenMHtRFM8"
  token_obtained_at = 2024-03-10T19:41:16Z
  token_expires_at = 0001-01-01T00:00:00Z
  tls-ca-file = "/etc/ssl/certs/gitlab/gitlab.crt"
  executor = "docker"
  [runners.cache]
    MaxUploadedArchiveSize = 0
  [runners.docker]
    tls_verify = false
    image = "docker"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
    network_mtu = 0
    extra_hosts = ["gitlab.devops-deniz.net:192.168.1.10","kubernetes.deniz.master.internal:192.168.1.7"]


# restarted
sudo systemctl restart gitlab-runner.service

# status
sudo systemctl status gitlab-runner.service
```


# Referance
``` bash
extra_hosts: https://forum.gitlab.com/t/gitlab-runner-fatal-unable-to-access-and-could-not-resolve-host/37301

```
