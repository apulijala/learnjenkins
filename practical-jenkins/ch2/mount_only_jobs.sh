sudo mkdir -p /var/lib/jenkins/jobs
sudo yum install -y nfs-utils
# Open port number 2049 in the securiyt group for efs.
# This id should not be used 

sudo bash -c 'cat >> /etc/fstab <<EOF
fs-04067ff5.efs.eu-west-2.amazonaws.com:/ /var/lib/jenkins/jobs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0
EOF'
sudo mount -a
