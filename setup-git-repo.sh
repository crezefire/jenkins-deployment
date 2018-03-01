#!/bin/bash

sudo apt -y update
sudo apt -y install git

git clone https://github.com/crezefire/jenkins-deployment.git

cd jenkins-deployment
chmod +x *.sh

./setup-install-jenkins-master.sh
