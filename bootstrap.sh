#!/usr/bin/env bash

# install yum-utils
yum install -y yum-utils

# install repos
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum-config-manager --enable remi remi-test

# install apache httpd22
yum install -y httpd httpd-tools mod_ssl 
chkconfig --add httpd
chkconfig httpd on
service httpd start

# install apache httpd24
#wget -q http://repos.fedorapeople.org/repos/jkaluza/httpd24/epel-httpd24.repo
#mv epel-httpd24.repo /etc/yum.repos.d
#yum install -yq httpd24.x86_64
#chkconfig --add httpd24-httpd
#chkconfig httpd24-httpd on
#service httpd24-httpd start

# install nginx 1.6.2
#rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
#yum install -y nginx16
#chkconfig --add nginx
#chkconfig nginx on
#service nginx start

# install php55
yum install -y php55 \
	       php55-php \
               php55-php-cli \
               php55-php-opcache \
	       php55-php-mysqlnd \
	       php55-php-xml \
	       php55-php-gd \

# install php55 optional packages
yum install -y php55-php-pecl-uopz \
               php55-php-soap \
	       php55-php-pecl-xdebug
#               php-phpunit-PHP-Invoker 

ln -s /usr/bin/php55 /usr/bin/php

# install mysql55
yum install -y mysql mysql-server
chkconfig --add mysqld
chkconfig mysqld on
service mysqld start

# install git
yum install -y git

# install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer

# install drush
git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
cd /usr/local/src/drush
git checkout 6.5.0
composer install
ln -s /usr/local/src/drush/drush /usr/bin/drush
drush --version

# install vim (optional)
yum install -y vim

# link drupal
ln -s /vagrant/drupal /var/www/html/drupal

