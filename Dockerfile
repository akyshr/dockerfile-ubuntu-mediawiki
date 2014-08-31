# ubuntu sshd
#

FROM  ubuntu:14.04
MAINTAINER akyshr "akyshr@gmail.com"

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# make sure the package repository is up to date
RUN apt-get update

# install sshd
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8 || :

RUN apt-get install -y mysql-server apache2 php5
RUN apt-get install -y php5-mysql php5-intl php5-apcu php5-gd

RUN apt-get install -y imagemagick git

# Copy the files into the container
ADD . /src
RUN rm /src/*~ ; true
RUN chown -R root.root /src

#Install MediaWiki
RUN cd /var/lib ; tar xf /src/mediawiki-1.23.3.tar.gz
RUN ln -sf /src/mediawiki.conf /etc/apache2/conf-available/
RUN a2enconf mediawiki

EXPOSE 22

# Start ssh services.
CMD ["/src/startup.sh"]

