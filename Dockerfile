FROM 	debian:stable-slim
MAINTAINER	jeroen@pyromanic.nl
ENV 	DEBIAN_FRONTEND noninteractive
RUN 	apt-get update &&\
	apt-get dist-upgrade -y &&\
	apt-get install apache2 php php-curl -y

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
RUN	mkdir /var/www/websites && chmod 777 /var/www/websites
VOLUME	/var/www/websites

CMD	["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
