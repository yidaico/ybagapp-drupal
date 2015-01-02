#!/usr/bin/env bash

# set up timezone
cp /usr/share/zoneinfo/Canada/Pacific /etc/localtime
date

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
yum remove php*
yum install -y php55 \
	       php55-php \
               php55-php-cli \
               php55-php-opcache \
	       php55-php-mysqlnd \
	       php55-php-mbstring \
	       php55-php-xml \
	       php55-php-gd \
	       php55-php-pecl-uploadprogress 

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

# set up ssl certificates
rm -f /etc/pki/tls/certs/localhost.crt
rm -f /etc/pki/tls/private/localhost.key
cp /vagrant/config/httpd/ssl/localhost.crt /etc/pki/tls/certs
cp /vagrant/config/httpd/ssl/localhost.key /etc/pki/tls/private

# set up httpd conf 
ln -s /vagrant/drupal /var/www/ybagapp.com
mkdir /etc/httpd/conf/vhosts
cp /vagrant/config/httpd/vhosts/* /etc/httpd/conf/vhosts
rm -f /etc/httpd/conf/httpd.conf
cp /vagrant/config/httpd/httpd.conf /etc/httpd/conf

# set up php conf
rm -f /opt/remi/php55/root/etc/php.ini
cp /vagrant/config/php/php.ini /opt/remi/php55/root/etc
rm -f /opt/remi/php55/root/etc/php.d/xdebug.ini
cp /vagrant/config/php/extensions/xdebug.ini /opt/remi/php55/root/etc/php.d

# restart httpd
service httpd restart

# set up mysql user and database
mysql -u root < /vagrant/config/mysql/init.sql

# install drupal site
cd /var/www/ybagapp.com
drush si -y standard \
    --site-name=ybagapp.com \
    --sites-subdir=ybagapp.com \
    --account-name=hong \
    --account-pass=hong \
    --account-mail=admin@ybagapp.com \
    --db-url=mysql://ybagapp:ybagapp@localhost/ybagapp

