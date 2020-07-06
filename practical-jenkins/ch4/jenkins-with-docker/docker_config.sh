#!/bin/bash -ex

sudo bash -c "echo writing to docker instance >> /home/ec2-user/log.txt"
sudo yum install -y docker
sudo bash -c "echo writing to docker instance end >> /home/ec2-user/log.txt"
sudo  sed -i -e s/OPTIONS=.*/OPTIONS='\"--selinux-enabled --log-driver=journald  -H unix:\/\/\/var\/run\/docker.sock  -H tcp:\/\/0.0.0.0:2375\"/' /etc/sysconfig/docker
sudo bash -c "echo Making docker file end >> /home/ec2-user/log.txt"
sudo systemctl restart docker
