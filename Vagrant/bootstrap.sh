#!/usr/bin/env bash

# install apache http24
wget -q http://repos.fedorapeople.org/repos/jkaluza/httpd24/epel-httpd24.repo
sudo mv epel-httpd24.repo /etc/yum.repos.d
sudo yum install -yq httpd24.x86_64
sudo chkconfig --add httpd24-httpd
sudo chkconfig httpd24-httpd on
sudo service httpd24-httpd start

# install php55
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum install -yq php55w php55w-opcache

# install mysql56
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el6-5.noarch.rpm
sudo yum -yq install mysql-server
sudo chkconfig --add mysqld
sudo chkconfig mysqld on
sudo service mysqld start

