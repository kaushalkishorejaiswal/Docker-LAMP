############################################################
# Dockerfile to build LAMP (Linux, Apache2, MySQL, PHP) Installed Containers
# Based on Ubuntu 12.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Kaushal Kishore <kaushal.rahuljaiswal@gmail.com>

# Set the enviroment variable
ENV DEBIAN_FRONTEND noninteractive

# Install required packages
RUN apt-get clean all
RUN apt-get update 
RUN apt-get -y install supervisor 
RUN apt-get -y install mysql-server 
RUN apt-get -y install apache2 
RUN apt-get -y install php5 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc php5-curl curl lynx-cur

# Add shell scripts for starting apache2
ADD apache2-start.sh /apache2-start.sh

# Add shell scripts for starting mysql
ADD mysql-start.sh /mysql-start.sh
ADD run.sh /run.sh

# Give the execution permissions
RUN chmod 755 /*.sh

# Add the Configurations files
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-lamp.conf /etc/supervisor/conf.d/supervisord-lamp.conf


# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Enviroment variable for setting the Username and Password of MySQL
ENV MYSQL_USER root
ENV MYSQL_PASS root

# Add MySQL utils
ADD mysql_user.sh /mysql_user.sh
RUN chmod 755 /*.sh

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite


# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]
VOLUME /var/www

# Set the port
EXPOSE 80 3306

# Execut the run.sh 
CMD ["/run.sh"]
