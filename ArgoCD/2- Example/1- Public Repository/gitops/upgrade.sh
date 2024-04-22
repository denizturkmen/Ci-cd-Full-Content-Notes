#!/bin/bash

# exit when any command fails
set -e

new_ver=$1

echo "new version: $new_ver"

# Simulate release of the new docker images
docker tag nginx:latest denizyoutube/nginx:$new_ver

# Push new version to dockerhub
docker push denizyoutube/nginx:$new_ver

# Create temporary folder
tmp_dir=$(mktemp -d)
echo $tmp_dir

# Clone GitHub repo
git clone git@github.com:dnztest/Argocd.git $tmp_dir

# Docker image from dockerfile
# docker tag . denizyoutube/nginx:$new_ver

# Push new version to dockerhub
# docker push denizyoutube/nginx:$new_ver

# Update image tag
sed -i -e "s/denizyoutube\/nginx:.*/denizyoutube\/nginx:$new_ver/g" $tmp_dir/my-app/1-deployment.yaml

# Commit and push
cd $tmp_dir
git config --global user.email uudemytest@gmail.com
git config --global user.name dnztest
git add .
git commit -m "Update image to $new_ver"
git push

# Optionally on build agents - remove folder
rm -rf $tmp_dir