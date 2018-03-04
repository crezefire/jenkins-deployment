#!/bin/bash

sudo apt -y update # Should have been run before
sudo apt -y install docker.io python3

mkdir ~/jenkins-master-data
sudo chown 1000 ~/jenkins-master-data

sudo systemctl start docker

sudo docker build -t vimmy/jenkins-master .

# Port mapping for Java API: -p 50000:50000
sudo docker run -p 80:8080 -p 13370:13370 -v ~/jenkins-master-data:/var/jenkins_home vimmy/jenkins-master &
disown %1

# HACK
sleep 30

export JENKINS_DOCKER_ID=$(sudo docker ps -l --format="{{.ID}}")

echo $JENKINS_DOCKER_ID >> ~/.bashrc

sudo docker exec $JENKINS_DOCKER_ID cat /var/jenkins_home/secrets/initialAdminPassword > jenkins_initial_admin_pass.txt

python3 -m http.server 8000 &

sleep 60

# DANGER
sudo killall python3

