#!/bin/bash

sudo apt -y update
sudo apt -y install default-jre

cd ~/
mkdir jenkins

mkdir downloads && cd downloads

wget "http://${jenkins_master_url}/jnlpJars/agent.jar"

# Get this from Jenkins
java -jar agent.jar -jnlpUrl "http://${jenkins_master_url}/computer/${jenkins_slave_name}/slave-agent.jnlp" -secret "${jenkins_secret}" -workDir "/home/ubuntu/jenkins"
