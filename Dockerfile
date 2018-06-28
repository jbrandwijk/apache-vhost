FROM 	pyromanic/debian-s6
MAINTAINER	jeroen@pyromanic.nl
ENV 	DEBIAN_FRONTEND noninteractive
RUN 	apt-get update &&\
	apt-get dist-upgrade -y &&\
	apt-get install apache2 php php-curl php-sqlite3 -y

#	Add daemons (apache for now) to run as a service within s6' init
ADD	services.d /etc/services.d
RUN	chmod u+x /etc/services.d/*/run

#	Expose web server
EXPOSE 	80

#	Config...
RUN	sed -i -e 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
RUN	ln -s /etc/apache2/mods-available/vhost_alias.load \
	/etc/apache2/mods-enabled/vhost_alias.load
RUN	rm -rf /etc/apache2/sites-enabled &&\
	rm -rf /etc/apache2/sites-available &&\
	mkdir /etc/apache2/sites-enabled
ADD	conf.d/* /etc/apache2/conf-enabled/
RUN	mkdir /var/www/default && chmod 777 /var/www/default
ADD	content/default/index.html /var/www/default/
RUN	mkdir /var/www/websites && chmod 777 /var/www/websites
VOLUME	/var/www/websites

#	Give the container something to do...
ADD	scripts/control.sh /control.sh
RUN	chmod u+x /control.sh
CMD	/control.sh
