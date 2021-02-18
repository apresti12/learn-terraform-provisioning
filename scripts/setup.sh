#!/bin/bash
set -x

#YUM updates
sudo yum update -y

sudo yum install -y udo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo chkconfig httpd on
sudo usermod -a -G apache ec2-user