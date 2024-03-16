How to backup and restore

Gitlab container backup
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

Restore
``` bash
# 


```