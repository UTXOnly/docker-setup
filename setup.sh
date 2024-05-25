#!/bin/bash

# Update the apt package index
sudo apt-get update

# Install necessary packages
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    -y

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker APT repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce -y

# Add your user to the docker group
sudo usermod -aG docker $USER

# Verify installation
docker --version

echo "Docker has been installed successfully."
echo "You may need to log out and log back in to apply the user group changes."
