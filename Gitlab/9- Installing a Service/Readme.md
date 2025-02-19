#  Install and Configure GitLab EE as a Service on Linux

## Install
``` bash
# Import the repository GPG keys
curl https://packages.gitlab.com/gpg.key | sudo apt-key add -
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

# Add the GitLab repository: CE
sudo apt-add-repository "deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ $(lsb_release -cs) main"

# Add the GitLab repository: EE
sudo apt-add-repository "deb https://packages.gitlab.com/gitlab/gitlab-ee/ubuntu/ $(lsb_release -cs) main"

# List all available versions to find the specific version you want to install
sudo apt-cache madison gitlab-ce
sudo apt-cache madison gitlab-ee

# Install: Required. You must change the password in gitlab-ui.
sudo EXTERNAL_URL="http://gitlab.devopskings.com.tr" GITLAB_ROOT_EMAIL="traning.deniz@gmail.com" GITLAB_ROOT_PASSWORD="<strongpassword>" apt-get install gitlab-ee=17.4.0-ee.0 
sudo EXTERNAL_URL="http://gitlab.devopskings.com.tr" GITLAB_ROOT_EMAIL="traning.deniz@gmail.com" GITLAB_ROOT_PASSWORD="YdX4UNQdyJ" apt-get install gitlab-ee=17.4.0-ee.0 

# Install: Required. You must change the password in gitlab-ui for gitlab-ce
sudo EXTERNAL_URL="http://gitlab-ce.denizturkmen.com.tr" GITLAB_ROOT_EMAIL="traning.deniz@gmail.com" GITLAB_ROOT_PASSWORD="YdX4UNQdyJ" apt-get install gitlab-ce=17.4.0-ce.0 

# check
sudo systemctl status gitlab-runsvdir.service


# hold package
dpkg -l | grep <package-name>
sudo apt-mark hold <package-name>
sudo apt-mark hold gitlab-ee
sudo apt-mark showhold
sudo apt-mark unhold <package-name>

# If needed, reapply the configuration manually
sudo gitlab-ctl reconfigure

# user and passwoed
root 
password

```


## Configure: Enabling Https
``` bash
# install certbot on ubuntu
sudo apt update 
sudo apt install -y certbot

# wildcard ssl generate
sudo certbot certonly --manual --preferred-challenges dns -d '*.your_domain.com'

# Copy your .crt and .key files to a directory on your GitLab server
/etc/gitlab/ssl/gitlab.crt
/etc/gitlab/ssl/gitlab.key

# Ensure the directory and files have the correct permissions
sudo mkdir -p /etc/gitlab/ssl
sudo chown -R gitlab-www:gitlab-www /etc/gitlab/ssl
sudo chmod 600 /etc/gitlab/ssl/gitlab.example.com.key
sudo chmod 644 /etc/gitlab/ssl/gitlab.example.com.crt

# Update the GitLab Configuration
sudo vim /etc/gitlab/gitlab.rb
    external_url 'https://gitlab.example.com'
    nginx['redirect_http_to_https'] = true
    nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.crt"
    nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.key"
    nginx['enable'] = true
    nginx['ssl_protocols'] = "TLSv1.2 TLSv1.3"
    # nginx['listen_port'] = 8081 try 
    nginx['real_ip_trusted_addresses'] = ['192.168.1.6']
    nginx['real_ip_header'] = 'X-Forwarded-For'
    nginx['real_ip_recursive'] =' on'


# Reload NGINX configuration
sudo gitlab-ctl hup nginx

# Alternatively, you can restart NGINX
sudo gitlab-ctl restart nginx

# Reconfigure GitLab
sudo gitlab-ctl reconfigure


```


## Configure: Email Notification
``` bash
# 


```


## Resetting root password
``` bash
# Set the Root Password via Rails Console If GitLab is already running, you can set the root password using the Rails console.
# Open the Rails console:
sudo gitlab-rails console

# Run the following command to set the password:
user = User.find_by_username('root')
user.password = 'your_strong_password'
user.password_confirmation = 'your_strong_password'
user.save!

# exit
exit

# Other method
sudo gitlab-rake "gitlab:password:reset[root]"



```

## Uninstall the Linux package 
``` bash
# Optional
sudo gitlab-ctl stop && sudo gitlab-ctl remove-accounts

# Choose whether to keep your data or remove all of them
sudo systemctl stop gitlab-runsvdir
sudo systemctl disable gitlab-runsvdir
sudo rm /usr/lib/systemd/system/gitlab-runsvdir.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
sudo gitlab-ctl uninstall

# To remove all data
sudo gitlab-ctl cleanse && sudo rm -r /opt/gitlab

# Debian/Ubuntu
sudo apt remove gitlab-ee

# RedHat/CentOS
sudo yum remove gitlab-ee

```


## Gitlab-runner install
``` bash
# Adding /etc/hosts
    192.168.1.10    gitlab.devopskings.com.tr
# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start

# Register 
sudo gitlab-runner register --url https://gitlab.devopskings.com.tr/ --registration-token Z4W-z4V7XRyH-MrrgUdb --tls-ca-file /etc/gitlab/ssl/gitlab.crt



```