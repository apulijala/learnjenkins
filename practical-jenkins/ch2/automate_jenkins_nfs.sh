#!/bin/bash

# Mount the jenkins. 
sudo mkdir -p /var/lib/jenkins/
sudo yum install -y nfs-utils
# Open port number 2049 in the securiyt group for efs.
# This id should not be used 

sudo bash -c 'cat >> /etc/fstab <<EOF
fs-04176ef5.efs.eu-west-2.amazonaws.com:/ /var/lib/jenkins nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0
EOF'
sudo mount -a

# Install Jenkins.

sudo yum -y install java-1.8.0-openjdk
sudo yum install -y wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins 

# Install nginx.
sudo yum install-y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
sudo yum install -y nginx
sudo bash -c "setsebool httpd_can_network_connect 1"
sudo bash -c "sed -i.bak '38, 57 d' /etc/nginx/nginx.conf"
sudo bash -c 'cat >> /etc/nginx/conf.d/jenkins.conf <<EOF
upstream backend {
    server localhost:8080;
}

server {

        location /
        {
                proxy_pass http://backend;
        }
}
EOF'
# start both the servers.
sudo systemctl start jenkins
sudo systemctl start nginx
sleep 10



# Install all the tools.
sudo yum install -y git
sudo yum install -y python3

result=$(curl localhost)
echo "$result"
