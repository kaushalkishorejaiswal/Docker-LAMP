#!/bin/bash
# Executing supervisord and mysql_user
# Author : Kaushal Kishore <kaushal.rahuljaiswal@gmail.com>

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    mysql_install_db > /dev/null 2>&1
    /mysql_user.sh
fi

exec supervisord -n

