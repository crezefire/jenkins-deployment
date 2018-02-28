FROM jenkins/jenkins:lts
COPY set-master-executors.groovy /usr/share/jenkins/ref/init.groovy.d/set-master-executors.groovy
