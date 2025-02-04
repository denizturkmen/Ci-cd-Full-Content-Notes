# Instaling and Configuring Jenkins on the Ubuntu

## Installing to JAVA
```  bash
sudo apt update

sudo apt install -y openjdk-17-jdk

```


## Install
``` bash

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get -y install jenkins


```


