#  GithubRepo Connection via SSH


Create ssh keygen
``` bash
# generate
ssh-keygen -t rsa -b 4096 -C "uudemytest@gmail.com"

# show
cat ~/.ssh/id_rsa.pub 

# git config
git config --global user.email uudemytest@gmail.com
git config --global user.name dnztest


```

Put on ssh keygen
``` bash
go to settings
and 
ssh keygen (public key) 

```
