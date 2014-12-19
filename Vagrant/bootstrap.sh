#!/usr/bin/env bash

# install apache http24
sudo yum install -y httpd httpd-tools 
sudo chkconfig --add httpd
sudo chkconfig httpd on
sudo service httpd start

# install php55
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum install -y php55w php55w-opcache php55w-fpm php55w-gd

# install mysql56
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el6-5.noarch.rpm
sudo yum -y install mysql-server
sudo chkconfig --add mysqld
sudo chkconfig mysqld on
sudo service mysqld start

