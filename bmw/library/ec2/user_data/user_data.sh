#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "Starting system update and package installation..."
apt-get update -y
apt-get upgrade -y

# Install prerequisites
apt-get install -y git gnupg wget fontconfig curl

# 2. Install Java 21 (Jenkins requires Java 21 minimum)
apt-get install -y openjdk-21-jre

# Install Jenkins
mkdir -p /usr/share/keyrings
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update -y
systemctl stop jenkins || true
apt-get install -y jenkins

# Install Terraform 
apt-get install -y software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

apt-get update -y
apt-get install -y terraform

#Install AWS CLI v2
apt-get install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

#Enable and Start jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins

echo "All tools installed and services configured successfully!"