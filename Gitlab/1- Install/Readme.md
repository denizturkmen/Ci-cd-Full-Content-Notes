Installation and Configuration of Gitlab-EE via Docker


Pre-requisites
``` bash
You must docker install.

# Docker install with script
sudo su -
curl https://raw.githubusercontent.com/denizturkmen/Docker-Full-Content-Notes/main/Installing%20useful%20tools/Sonarqube/1-%20Install/docker-install.sh | bash

# Docker-compose install with script
sudo su -
curl https://raw.githubusercontent.com/denizturkmen/Docker-Full-Content-Notes/main/Installing%20useful%20tools/Sonarqube/1-%20Install/docker-compose-install.sh | bash

# Creating wildcard ssl with certbot
# install certbot on ubuntu

sudo apt update 
sudo apt install -y certbot

# wildcard ssl generate
sudo certbot certonly --manual --preferred-challenges dns -d '*.your_domain.com'
sudo certbot certonly --manual --preferred-challenges dns -d '*.devops-deniz.net'

```


Volume create and permisson
``` bash
# create
sudo mkdir -p /srv/gitlab

# permission 
sudo chmod 777 /srv/gitlab

# export 
export GITLAB_HOME=/srv/gitlab
sudo vim 
    export GITLAB_HOME=/srv/gitlab

# create network
docker network create gitlab

```

Gitlab-EE install and configure
``` bash
# Install
docker-compose -f docker-compose-gitlab up -d 

# Check and log
docker logs -f container_id


# reconfigure
docker exec -it container_id
    gitlab-ctl reconfigure

```





# Referance
``` bash
Gitlab_install: https://docs.gitlab.com/ee/install/docker.html
Github_install_docs_1: https://github.com/BytemarkHosting/configs-gitlab-docker/blob/master/docker-compose.yml
Gitlab_ombiousconfig_issue: https://forum.gitlab.com/t/unable-to-configure-gitlab-ce-when-installing-with-docker-compose/83725
Gitlab_runner_issue: https://forum.gitlab.com/t/how-to-launch-runner-and-gitlab-running-locally-using-docker-compose/48929
Github_install_docs_2: https://github.com/danieleagle/gitlab-https-docker/blob/master/docker-compose.yml
Github_nginx_external: https://github.com/danieleagle/gitlab-https-docker/tree/master
Gitlab_Upgrade_Path: https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/


```