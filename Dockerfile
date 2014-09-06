# ubuntu mediawiki server
#

FROM  akyshr/ubuntu-sshd
#FROM  akyshr/ubuntu-lamp
MAINTAINER akyshr "akyshr@gmail.com"

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# make sure the package repository is up to date
RUN apt-get update

RUN apt-get install -y mysql-server apache2 php5
RUN apt-get install -y  php5-mysql php5-intl php5-apcu php5-gd

RUN apt-get install -y imagemagick git

RUN wget http://releases.wikimedia.org/mediawiki/1.23/mediawiki-1.23.3.tar.gz

#Install MediaWiki
RUN cd /var/lib ; tar xf /mediawiki-1.23.3.tar.gz ; rm /mediawiki-1.23.3.tar.gz
RUN mv /var/lib/mediawiki-1.23.3 /var/lib/mediawiki ; \
    chown -R www-data.www-data /var/lib/mediawiki 
ADD mediawiki.conf     /etc/apache2/conf-available/
RUN a2enconf mediawiki

# Copy the files into the container
ADD README.md          /src/README.md
ADD start_lamp.sh      /src/start_lamp.sh
ADD start_mediawiki.sh /src/start_mediawiki.sh
ADD init.sh            /src/init.sh


#
CMD ["/src/init.sh"]
