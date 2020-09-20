#!/bin/bash

export PACKER_VER=1.5.6
export TF_VER=0.12.29

# UPDATE
RUN apk update && apk upgrade

# COMMON
RUN apk add bash bash-doc bash-completion curl wget zip  gzip vim openssl

# ADMINISTRATION
RUN apk add net-tools tree lynx file

# DEVELOPER TOOLS
RUN apk add make git htop build-base nodejs npm

# CLOUD
## AWS CLI
RUN apk add aws-cli

# INFRUSTRUCTURE AS CODE
## Packer
RUN  wget https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_amd64.zip
RUN  unzip packer_${PACKER_VER}_linux_amd64.zip && rm -rf packer_${PACKER_VER}_linux_amd64.zip 
RUN  mv packer /usr/local/bin

## TERRAFORM
RUN  wget https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip
RUN  unzip terraform_${TF_VER}_linux_amd64.zip && rm -rf terraform_${TF_VER}_linux_amd64.zip
RUN  mv terraform /usr/local/bin/

# CONTAINERS
## KUBERNETES
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

## HELM
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

## EKSUtil
RUN curl --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN chmod +x /tmp/eksctl
RUN mv /tmp/eksctl /usr/local/bin

## SNYK
RUN npm install -g snyk

# Create drive for user data
#ForDriveMount
RUN mkdir /opt/userdata -p
