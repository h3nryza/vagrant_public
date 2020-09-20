#!/bin/bash

export PACKER_VER=1.5.6
export TF_VER=0.12.29

# UPDATE
apk update && apk upgrade

# COMMON
apk add bash bash-doc bash-completion curl wget zip  gzip vim openssl

# ADMINISTRATION
apk add net-tools tree lynx file

# DEVELOPER TOOLS
apk add make git htop build-base nodejs npm

# CLOUD
## AWS CLI
apk add aws-cli

# INFRUSTRUCTURE AS CODE
## Packer
 wget https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_amd64.zip
 unzip packer_${PACKER_VER}_linux_amd64.zip && rm -rf packer_${PACKER_VER}_linux_amd64.zip 
 mv packer /usr/local/bin

## TERRAFORM
 wget https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip
 unzip terraform_${TF_VER}_linux_amd64.zip && rm -rf terraform_${TF_VER}_linux_amd64.zip
 mv terraform /usr/local/bin/

# CONTAINERS
## KUBERNETES
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

## HELM
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

## EKSUtil
curl --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
chmod +x /tmp/eksctl
mv /tmp/eksctl /usr/local/bin

## SNYK
npm install -g snyk

# Create drive for user data
#ForDriveMount
mkdir /opt/userdata -p
