#!/bin/bash

/etc/init.d/apache2 start 

MYSQL_PASS=${MYSQL_PASS:-admin}

chown -R mysql:mysql /var/lib/mysql
chmod 700 /var/lib/mysql

if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql
fi

/etc/init.d/mysql start
mysqladmin -u root password "$MYSQL_PASS" ; true

