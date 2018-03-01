# Jenkins Deployment

Setup Jenkins Environment

## Setup Master

```bash
wget https://raw.githubusercontent.com/crezefire/jenkins-deployment/master/setup-git-repo.sh && chmod +x setup-git-repo.sh && ./setup-git-repo.sh
```

## Setup Slave

```bash	
export jenkins_master_url="" && export jenkins_slave_name="" && export jenkins_secret="" && wget https://raw.githubusercontent.com/crezefire/jenkins-deployment/master/setup-install-jenkins-slave.sh && chmod +x setup-install-jenkins-slave.sh && ./setup-install-jenkins-slave.sh
```
