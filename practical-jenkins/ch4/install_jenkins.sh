#!/bin/bash -ex


sudo bash -c "echo wrtiting to fstab >> /home/ec2-user/log.txt"
sudo mkdir -p /var/lib/jenkins
diskname=$(sudo fdisk -l | grep Disk |  grep ${volsize} | awk '{print $2}' | sed -E 's/://')
sudo bash -c "echo Writing to the log file >> /home/ec2-user/log.txt"
sudo bash -c "echo 'Got disk name' >> /home/ec2-user/log.txt"
sudo bash -c "echo $diskname  /var/lib/jenkins          ext4   defaults  0  0 >> /etc/fstab"
sudo bash -c "echo 'made an entry in fstab' >> /home/ec2-user/log.txt"
sudo mkfs.ext4 $diskname
sudo bash -c "echo 'created the file system' >> /home/ec2-user/log.txt"
sudo mount -a
sudo bash -c "echo 'Mounted the file system' >> /home/ec2-user/log.txt"
# Installing Jenkins
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y git
sudo bash -c "echo 'Installed git and java' >> /home/ec2-user/log.txt"
sudo bash -c "wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo"
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo bash -c "echo Jenkins repo configured >> /home/ec2-user/log.txt"
sudo yum install -y jenkins
sudo bash -c "echo Jenkiins install complete mounted >> /home/ec2-user/log.txt"
sudo mkdir -p /var/lib/jenkins/init.groovy.d/
sudo sed -i -e 's/JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true"/JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"/' /etc/sysconfig/jenkins
sudo bash -c "echo Jenkins customized >> /home/ec2-user/log.txt"

sudo bash -c 'cat > /var/lib/jenkins/init.groovy.d/initialize.groovy << EOF
// 17:58

import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule
import hudson.security.csrf.DefaultCrumbIssuer
import jenkins.model.Jenkins
import java.util.logging.Logger


def jenkinsInstance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "admin")
jenkinsInstance.setSecurityRealm(hudsonRealm)

def loggedinAuthStrategy = new FullControlOnceLoggedInAuthorizationStrategy()
loggedinAuthStrategy.setAllowAnonymousRead(false)
jenkinsInstance.setAuthorizationStrategy(loggedinAuthStrategy)
jenkinsInstance.save()

Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class)
def j = Jenkins.instance
if (j.getCrumbIssuer() == null) {
    j.setCrumbIssuer(new DefaultCrumbIssuer())
    j.save()
    prinln("CSRF Protection configuration has changed. Enabled CSRF Protection.")
} else {
    println("Nothing Changed. CSRF Protection already configured")
}

def pluginlist =
        "ws-cleanup timestamper credentials-binding build-timeout antisamy-markup-formatter".plus(
                "cloudbees-folder pipeline-stage-view pipeline-github-lib github-branch-source "
        ).plus("workflow-aggregator gradle ant mailer email-ext ldap pam-auth matrix-auth ")
println(pluginlist)
def instance = Jenkins.getInstance()
def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()



pluginlist.split().each {
    if (!pm.getPlugin(it)) {
        if (!isInitialized) {
            // uc.updateAllSites()
            isInitialized = true
        }
    }
    def plugin = uc.getPlugin(it)
    if (plugin) {
        def installFuture = plugin.deploy()
        while (!installFuture.isDone()) {
            sleep(1000)
        }
        isInstalled =true
    }
}

if (isInstalled) {
    instance.save()
    instance.restart()
}
EOF'


sleep 10
sudo systemctl start jenkins




