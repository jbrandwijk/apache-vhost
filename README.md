Apache-Vhost
============

An Introduction
---------------

Apache-Vhost is a docker container, which runs Apache with a default
directory based VirtualHost configuration, in such a way, you only have to
create a directory and put your HTML in there, in order to have your website
configured.

Quick start
-----------

Just follow the following steps in order to see Apache-Vhost's power...

1. Add the following line to /etc/hosts
```
127.0.0.1   mywebsite
```
_Although this docker container image is pretty magical, it's not almighty.
In production environments you would need DNS setup._


2. Create a directory /home/something/mywebsite


3. Create an index.html file in /home/something/website


4. Run the container
```
docker run -p 80:80 -v /home/something:/var/www/websites pyromanic/apache2-vhost
```

5. Pick a browser on this local system and point it to http://mywebsite

You'll see the website served through a webserver. Pretty neat huh?

So..


Quick start, part deux
----------------------

Basically it is as follows:
1. Arrange proper DNS setup 
2. Place your website(s) in a directory
3. Start docker with a volume parameter from your website directory to `/var/www/websites`
4. You're good to go...

Good to know
------------

* You can have multiple websites in this website-directory.

For example if you have your websites in /home/www:
You can have /home/www/www.example.com for your website on www.example.com
and you can have /home/www/another.example.com for your website on another.example.com.

* You have PHP 7 support
Basic PHP7 support has been built in.

* There is an init system wihtin the container
In order to facilitate the web server, this image has been built on top of a
debian images with an [s6 overlay](https://github.com/just-containers/s6-overlay)
