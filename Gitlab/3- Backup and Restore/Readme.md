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

Restoring gitlab container
``` bash

# Stop the processes that are connected to the database
docker exec -it <name of container> gitlab-ctl stop puma
docker exec -it <name of container> gitlab-ctl stop sidekiq

# Verify that the processes are all down before continuing
docker exec -it <name of container> gitlab-ctl status

# Run the restore. NOTE: "_gitlab_backup.tar" is omitted from the name
docker exec -it <name of container> gitlab-backup restore BACKUP=1710610678_2024_03_16_16.7.6-ee

# Restart the GitLab container
docker restart <name of container>

# Check GitLab
docker exec -it <name of container> gitlab-rake gitlab:check SANITIZE=true

```


# ISSUE
``` bash
Restoring PostgreSQL database gitlabhq_production ... ERROR:  must be owner of extension pg_trgm
ERROR:  must be owner of extension btree_gist
ERROR:  must be owner of extension btree_gist
ERROR:  must be owner of extension pg_trgm


``'

# Referance
``` bash
Backup: https://docs.gitlab.com/omnibus/settings/backups.html
Restore: https://docs.gitlab.com/ee/administration/backup_restore/



```