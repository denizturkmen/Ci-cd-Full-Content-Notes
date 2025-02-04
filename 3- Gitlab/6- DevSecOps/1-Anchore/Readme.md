# Install and Configure Anchore

Pre-Requitities
``` bash
docker install
docker compose install

```

Docker install with script
``` bash
# Install
sudo su -
curl https://raw.githubusercontent.com/denizturkmen/Docker-Full-Content-Notes/main/Installing%20useful%20tools/Sonarqube/1-%20Install/docker-install.sh | bash

```

Docker-Compose install with script
``` bash
# Install
sudo su -
curl https://raw.githubusercontent.com/denizturkmen/Docker-Full-Content-Notes/main/Installing%20useful%20tools/Sonarqube/1-%20Install/docker-compose-install.sh | bash

```

Run Docker Without sudo
``` bash
# create docker group
sudo groupadd docker

# add docker user to docker group
sudo usermod -aG docker $USER

# add docker group
newgrp docker

# run docker without sudo
docker ps

```


Install anchore with docker-compose
``` bash
# dowland
curl https://engine.anchore.io/docs/quickstart/docker-compose.yaml > docker-compose.yaml

# up
docker-compose up -d
      - ANCHORE_ADMIN_PASSWORD=foobar
      - ANCHORE_DB_HOST=db
      - ANCHORE_DB_PASSWORD=mysecretpassword

# status check
docker-compose exec api anchore-cli system status

```

To perform analysis from localhost
``` bash
export ANCHORE_CLI_URL=http://<IP adress>:8228/v1
export ANCHORE_CLI_USER=admin
export ANCHORE_CLI_PASS=foobar

```

Vulnerabilities scan image 
```Note```: Docker.io searches for images by default.
``` bash
# Updating catalog
anchore-cli system feeds sync



# Add an image to the Anchore Engine:
anchore-cli image add docker.io/library/debian:latest

# Wait for the image to move to the 'analyzed' state:
anchore-cli image wait docker.io/library/debian:latest

# List images analyzed by the Anchore Engine:
anchore-cli image list

# Get image overview and summary information:
anchore-cli image get docker.io/library/debian:latest

# List feeds and wait for at least one vulnerability data feed sync to complete. The first sync can take some time (20-30 minutes) after that syncs will only merge deltas.

anchore-cli system feeds list
anchore-cli system wait

# Obtain the results of the vulnerability scan on an image:
anchore-cli image vuln docker.io/library/debian:latest os

# Obtain the results of the vulnerability scan on an image ALL:
anchore-cli image vuln docker.io/library/debian:latest all

# List operating system packages present in an image:
anchore-cli image content docker.io/library/debian:latest os

```

Installing Anchore CLI on Debian and Ubuntu
``` bash
sudo apt-get update
sudo apt-get install python-pip
sudo pip3 install anchorecli

Note make sure ~/.local/bin is part of your PATH or just export it directly: export PATH="$HOME/.local/bin/:$PATH"

```

Private Image Vulnerabilities scan
``` bash
# Login
anchore-cli registry add REGISTRY USERNAME PASSWORD


```




# Referance
``` bash
Install: https://github.com/anchore/anchore-engine
Cli: https://github.com/anchore/anchore-cli
anchore_chats: https://github.com/anchore/anchore-charts
private_scan: https://stackoverflow.com/questions/55438141/is-anchore-engine-supported-to-scan-vulnerabilities-in-local-docker-image-priv

```

