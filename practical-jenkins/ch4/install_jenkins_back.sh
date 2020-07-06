#!/bin/bash -ex


sudo bash -c "echo wrtiting to fstab >> /home/ec2-user/log.txt"
sudo bash -c 'echo "${dev_name}     /var/lib/jenkins          ext4   defaults  0  0" >> /etc/fstab'
sudo mkfs.ext4 ${dev_name}
sudo mkdir -p /var/lib/jenkins
sudo mount -a
sudo bash -c "echo disk finally mounted >> /home/ec2-user/log.txt"


# Installing Jenkins
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y git
sudo bash -c "wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo"
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins
sudo bash -c "echo disk finally mounted >> /home/ec2-user/log.txt"





