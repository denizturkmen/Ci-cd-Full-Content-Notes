Shell runner Example
``` bash
stages:
  - test
echo-test:
  stage: test
  script:
    - echo "deniz turkmen "
  tags:
  - shell-runner

```


TroubleShooting_1
``` bash
# issue
ERROR: Job failed: prepare environment: exit status 1. Check https://docs.gitlab.com/runner/shells/index.html#shell-profile-loading for more information

# result
sudo su gitlab-runner
cd ..
cd gitlab-runner
rm -rf .bash_logout
```

TroubleShooting_2
``` bash
# Issue
ERROR: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/_ping": dial unix /var/run/docker.sock: connect: permission denied

# solved temporary
sudo chmod 666 /var/run/docker.sock

```