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
sudo vim ~/.bashrc 
    export GITLAB_HOME=/srv/gitlab

# create network
docker network create gitlab

# ssl cp under /etc/ssl/certs/gitlab/
sudo mkdir -p /etc/ssl/certs/gitlab/
sudo cp gitlab.* /etc/ssl/certs/gitlab/

```

Gitlab-EE install and configure
``` bash
# Install
docker-compose -f docker-compose-gitlab up -d 

# Check and log
docker logs -f container_id

# ssl cp into container
docker cp container_id gitlab.* /etc/ssl/certs/gitlab/
docker cp gitlab.crt container_id:/etc/ssl/certs/gitlab
docker cp gitlab.key container_id:/etc/ssl/certs/gitlab

docker exec -it container_id bash
    gitlab-ctl reconfigure
    gitlab-ctl hup nginx

# reconfigure
docker exec -it container_id
    gitlab-ctl reconfigure

```


Useful command 
``` bash
# password reset
gitlab-rake "gitlab:password:reset"
sudo systemctl restart docker

# list of rake
gitlab-rake -vT
gitlab-rake --help


# gitlab check
gitlab-rake gitlab:check


# gitlab-ctl 
gitlab-rake -vT

# re-configure
gitlab-ctl reconfigure

# update ssl
gitlab-ctl reconfigure
gitlab-ctl hup nginx
gitlab-ctl hup registry


# root user exec into docker container
docker exec -it -u 0 container_id bash
    whoami


```

Investigate the Error
``` bash
There was an error running gitlab-ctl reconfigure:

letsencrypt_certificate[gitlab.devops-deniz.net] (letsencrypt::http_authorization line 6) had an error: RuntimeError: acme_certificate[staging] (letsencrypt::http_authorization line 43) had an error: RuntimeError: ruby_block[create certificate for gitlab.devops-deniz.net] (letsencrypt::http_authorization line 110) had an error: RuntimeError: [gitlab.devops-deniz.net] Validation failed, unable to request certificate, Errors: [{url: https://acme-staging-v02.api.letsencrypt.org/acme/chall-v3/11604218764/HWVxfA, status: invalid, error: {"type"=>"urn:ietf:params:acme:error:dns", "detail"=>"DNS problem: NXDOMAIN looking up A for gitlab.devops-deniz.net - check that a DNS record exists for this domain; DNS problem: NXDOMAIN looking up AAAA for gitlab.devops-deniz.net - check that a DNS record exists for this domain", "status"=>400}} ]

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
Gitlab_backup: https://docs.gitlab.com/omnibus/settings/backups.html
Gitlab_useful_command_github: https://gist.github.com/royki/c1ea85e2ccdce0dfd186bbaf5b8e8d67
Gitlab_ssl_renewel: https://docs.gitlab.com/omnibus/settings/ssl/

```

