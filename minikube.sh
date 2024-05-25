#!/bin/bash

# Exit script on any error
set -e

# Update package information
echo "Updating package information..."
sudo apt-get update -y

# Install prerequisite packages
echo "Installing prerequisite packages..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    conntrack

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Start Minikube with Docker driver
echo "Starting Minikube with Docker driver..."
newgrp docker << EOF
minikube start --driver=docker
EOF

# Print Minikube status
echo "Minikube status:"
minikube status

echo "Minikube installation and setup completed successfully."
