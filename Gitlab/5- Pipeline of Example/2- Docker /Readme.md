# Pipeline of Example: on docker runner


Note: After gitlab runner is installed, it needs to be privileged to run commands in the docker container.
``` bash
# Issue
Could not mount /sys/kernel/security.
AppArmor detection and --privileged mode might break.
mount: permission denied (are you root?)

# edit config.toml
sudo sed -i 's,privileged = false,privileged = true,g' /etc/gitlab-runner/config.toml

# edit config.toml
sudo -i
cd /etc/gitlab
vim config.toml

  [[runners]]
  name = "docker"
  url = "https://gitlab.devops-deniz.net/"
  id = 2
  token = "YuSbx4j6QMNKDUtq5xTK"
  token_obtained_at = 2024-03-16T10:32:18Z
  token_expires_at = 0001-01-01T00:00:00Z
  tls-ca-file = "/etc/ssl/certs/gitlab/gitlab.crt"
  executor = "docker"
  [runners.cache]
    MaxUploadedArchiveSize = 0
  [runners.docker]
    tls_verify = false
    image = "docker"
    # edit from false to true
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
    network_mtu = 0

```

The Problem 1
``` bash
# Issue
fatal: unable to access 'https://gitlab.devops-deniz.net/frontend/website.git/': Could not resolve host: gitlab.devops-deniz.net

# Solution: go to config.toml
sudo -i
cd /etc/gitlab
vi config.toml

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
    # adding line
    extra_hosts = ["gitlab.devops-deniz.net:192.168.1.10"]

# Restart to runner
sudo systemctl restart gitlab-runner.service

# Checking
sudo systemctl status gitlab-runner.service
```


The Problem 2:
``` bash
# Issue
ERROR: Cannot connect to the Docker daemon at tcp://docker:2375. Is the docker daemon running?

# Solution: Ading .gitlab-ci.yml the below code
.
.
.
variables:
    VERS: $CI_COMMIT_SHORT_SHA
    DOCKER_DRIVER: overlay2
    DOCKER_HOST: tcp://docker:2375/
    DOCKER_TLS_CERTDIR: ""

```



Create a network
``` bash
# create
docker network create website

```

Adding a variable into gitlab ci
``` bash
SSH_HOST  192.168.1.10
pass      1

```









# Referance
``` bash
docker image: https://hub.docker.com/_/docker/tags


```