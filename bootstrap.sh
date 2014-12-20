#!/usr/bin/env bash

# install apache httpd22
#sudo yum install -y httpd httpd-tools 
#sudo chkconfig --add httpd
#sudo chkconfig httpd on
#sudo service httpd start

# install apache httpd24
#wget -q http://repos.fedorapeople.org/repos/jkaluza/httpd24/epel-httpd24.repo
#sudo mv epel-httpd24.repo /etc/yum.repos.d
#sudo yum install -yq httpd24.x86_64
#sudo chkconfig --add httpd24-httpd
#sudo chkconfig httpd24-httpd on
#sudo service httpd24-httpd start

# install nginx 1.6.2
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum install -y nginx16
sudo chkconfig --add nginx
sudo chkconfig nginx on
sudo service nginx start

# install php55
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum install -y php55w php55w-cli php55w-opcache php55w-fpm php55w-gd
sudo chkconfig --add php-fpm
sudo chkconfig php-fpm on
sudo service php-fpm start

# install mysql56
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el6-5.noarch.rpm
sudo yum -y install mysql-server
sudo chkconfig --add mysqld
sudo chkconfig mysqld on
sudo service mysqld start

