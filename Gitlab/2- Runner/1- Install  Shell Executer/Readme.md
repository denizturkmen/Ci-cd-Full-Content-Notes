
# Install gitlab runner 

You can install it with the following command
``` bash
# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start

# Command to register runner
sudo gitlab-runner register --url gitlab_url--registration-token TOKEN
sudo gitlab-runner register --url https://gitlab.devops-deniz.net/ --registration-token zJ3AijxmGmarcwhvq336

# Command to register runner with SSL
sudo gitlab-runner register --url https://gitlab.devops-deniz.net/ --registration-token TOKEN --tls-ca-file /my/path/gitlab/gitlab.myserver.com.pem
sudo gitlab-runner register --url https://gitlab.devops-deniz.net/ --registration-token  CKMCokGX2YzzzsJbto36 --tls-ca-file /etc/ssl/certs/gitlab/gitlab.crt
sudo gitlab-runner register --url https://gitlab.devopskings.com.tr/ --registration-token  gZ28_s4dzqRoqHyvdbsV --tls-ca-file /etc/gitlab/ssl/gitlab.crt

```

