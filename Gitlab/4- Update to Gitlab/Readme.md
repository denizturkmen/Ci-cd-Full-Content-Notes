# Updating Gitlab-EE 

Pause the Runners and wait until all jobs are finished.
``` bash
On the top bar, select Admin AREA
On the left sidebar, select CI/CD > Runners.
Click Pause

```

Take data and Config backup
``` bash
# exec into container 
docker exec -t <your container name> gitlab-backup

# check backup under to below path
cd /srv/gitlab/data/backups

# Backup configuration and secrets:
docker exec -t <your container name> /bin/sh -c 'gitlab-ctl backup-etc && cd /etc/gitlab/config_backup && cp $(ls -t | head -n1) /secret/gitlab/backups/'

# check config backup under to below path
cd /srv/gitlab/config/config_backup

# Copy all config files from the container to host via this command
docker cp <your container name>:/etc/gitlab/ .

```

Upgrading gitlab planning tools
``` bash
# open to link
https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/?current=13.9.3&distro=docker



```


Starting Upgrade
``` bash
# Edit docker-compose.yml with the image tag you want to upgrade:
image: gitlab/gitlab-ee:<image-tag>

# pulling to image
docker-compose -f docker-compose-gitlab.yml pull

# starting container
docker-compose -f docker-compose-gitlab.yml pull

# watching container logs
docker logs -f container_id
docker logs -f gitlab-ee

```



# Referanse
``` bash
Upgrade PATH: https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/?current=13.9.3&distro=docker


```