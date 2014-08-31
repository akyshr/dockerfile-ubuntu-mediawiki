Ubuntu & MediaWiki
=================================================

##Usage 
````
docker run -d akyshr/ubuntu-mediawiki
````

##Account
* username: **admin**
* password: **admin**

##Change Language 
````
 docker run -d -e "LANG=ja_JP.UTF-8" -e "TZ=JST-9" akyshr/ubuntu-mediawiki
````

###Configuration Parameters
Below is the list of parameters that can be set using environment variables.
* USER : user account name. Defaults to 'admin'.
* PASSWORD : user password. Defaults to 'admin'.
* LANG  : Language. Defaults to 'en_US.UTF-8'.
* TIMEZONE : timezone. Defaults to 'Etc/UTC'
* MYSQL_PASS : mysql root password. Defaults to 'admin'

