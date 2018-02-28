#!/bin/bash

sudo apt -y update
sudo apt -y install docker.io

cd ~/

sudo systemctl start docker

sudo docker pull jenkins/jenkins:lts

# /sbin/tini -- /usr/local/bin/jenkins.sh
sudo docker run -p 80:8080 -p 50000:50000 jenkins/jenkins:lts &
disown %1

# HACK
sleep 30



export JENKINS_DOCKER_ID=$(sudo docker ps -l --format="{{.ID}}")

echo $JENKINS_DOCKER_ID >> ~/.bashrc

sudo docker exec $JENKINS_DOCKER_ID cat /var/jenkins_home/secrets/initialAdminPassword > ~/jenkins_initial_admin_pass.txt

python3 -m http.server 8000 &

sleep 60

# DANGER
sudo killall python3


################
sudo touch /lib/systemd/jenkins

sudo echo "[Unit]" >> /lib/systemd/jenkins
sudo echo "Description=Jenkins Master Container" >> /lib/systemd/jenkins
sudo echo "After=docker.service" >> /lib/systemd/jenkins
sudo echo "Requires=docker.service" >> /lib/systemd/jenkins

sudo echo "[Service]" >> /lib/systemd/jenkins
sudo echo "TimeoutStartSec=0" >> /lib/systemd/jenkins
sudo echo "Restart=always" >> /lib/systemd/jenkins
sudo echo "ExecStart=/bin/bash -ec 'sudo docker restart $JENKINS_DOCKER_ID'" >> /lib/systemd/jenkins

sudo echo "[Install]" >> /lib/systemd/jenkins
sudo echo "WantedBy=multi-user.target" >> /lib/systemd/jenkins


# ================ SLAVE ================

sudo apt -y update
sudo apt -y install default-jre

cd ~/
mkdir jenkins

mkdir downloads && cd downloads
wget http://MASTERURL/jnlpJars/agent.jar

# Get this from Jenkins
java -jar agent.jar -jnlpUrl http://ec2-35-177-178-236.eu-west-2.compute.amazonaws.com/computer/ubuntu-server-t2.micro/slave-agent.jnlp -secret 2e4373b36312fad808f38eaf5ad8bb952e21fbc493827b847072617bdfe85e03 -workDir "/home/ubuntu/jenkins"