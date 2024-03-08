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


TroubleShooting
``` bash
# issue
ERROR: Job failed: prepare environment: exit status 1. Check https://docs.gitlab.com/runner/shells/index.html#shell-profile-loading for more information

# result
sudo su gitlab-runner
cd ..
cd gitlab-runner
rm -rf .bash_logout
```