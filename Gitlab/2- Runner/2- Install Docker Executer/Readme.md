Install docker executer with docker 

``` bash
# Create the Docker volume
docker volume create gitlab-runner-config

# Start the GitLab Runner
docker run -d --name gitlab-runner --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v gitlab-runner-config:/etc/gitlab-runner \
    gitlab/gitlab-runner:latest

docker run -d --name gitlab-runner --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v gitlab-runner-config:/etc/gitlab-runner \
    gitlab/gitlab-runner:v15.1.1

# create directory for ssl
docker exec -it gitlab-runner bash
    mkdir -p /etc/ssl/certs/gitlab

# copt .crt from host to container
docker cp ./gitlab.* container_id:/etc/ssl/certs/gitlab/
    docker cp ./gitlab.crt gitlab-runner:/etc/ssl/certs/gitlab/
    docker cp ./gitlab.key gitlab-runner:/etc/ssl/certs/gitlab/

# Command to register runner with SSL
docker exec -it gitlab-runner bash
    gitlab-runner register --url https://gitlab.devops-deniz.net/ --registration-token TOKEN --tls-ca-file /my/path/gitlab/gitlab.myserver.com.pem
    gitlab-runner register --url https://gitlab.devops-deniz.net/ --registration-token  CKMCokGX2YzzzsJbto36 --tls-ca-file /etc/ssl/certs/gitlab/gitlab.crt

```

Troubleshooting
``` bash
# issue
ERROR: Registering runner... failed                 runner=CKMCokGX status=couldn't execute POST against https://gitlab.devops-deniz.net/api/v4/runners: Post "https://gitlab.devops-deniz.net/api/v4/runners": x509: certificate is not valid for any names, but wanted to match gitlab.devops-deniz.net
PANIC: Failed to register the runner. 

# solve
docker exec -it gitlab-runner bash
    apt update
    apt install -y vim
    vim /etc/hosts
        192.168.1.10	gitlab.devops-deniz.net


```