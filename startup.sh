#!/bin/bash

USER=${USER:-admin}
PASSWORD=${PASSWORD:-admin}
LANG=${LANG:-en_US.UTF-8}
TIMEZONE=${TIMEZONE:-Etc/UTC}
DB_PASS=${DB_PASS:-admin}

echo ${TIMEZONE} > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
dpkg-reconfigure locales
update-locale LANG=${LANG}

if [ ! -d /home/${USER} ] ; then
  useradd -m -k /etc/skel -s /bin/bash  ${USER}
  echo "${USER}:${PASSWORD}" |chpasswd
  usermod -a --group sudo ${USER}
fi
/etc/init.d/apache2 start 

/etc/init.d/mysql start
mysqladmin -u root password "$DB_PASS"

/usr/sbin/sshd -D
