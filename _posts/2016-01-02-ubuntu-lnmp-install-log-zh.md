---
layout: post
category : utuntu
title: utuntu lnmp install
tagline: ""
tags : [utuntu, linux, lnmp]
---
{% include JB/setup %}




***

	sudo apt-get install nginx
	
	sudo apt-get install python-pip
	sudo apt-get install python3-pip
	sudo apt-get install python-dev
	
	pip install django==1.10
	pip install --upgrade pip
	
	sudo pip install uwsgi

***

	sudo apt install php
	sudo apt install postgresql
	ALTER USER postgres with encrypted password 'pwdpwd';

***

	sudo apt-get install mysql-server 
	sudo apt-get install mysql-client
	sudo apt-get install libmysqlclient-dev

***

	sudo systemctl restart nginx
	sudo restart nginx
	sudo gedit /etc/nginx/sites-available/imreser
	sudo ln -s /etc/nginx/sites-available/imreser /etc/nginx/sites-enabled
	sudo mkdir /var/www/imreser.com
	
***

	********sudo gedit /etc/nginx/sites-available/imreser

	server {
		listen 8080;
		listen [::]:8080;
	
		server_name imreser.com www.imreser.com;
	
		root /var/www/imreser.com;
		index index.html index.php;
	
		location / {
			try_files $uri $uri/ =404 index.php;
		}
	
		# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
		#
		location ~ \.php$ {
			include snippets/fastcgi-php.conf;
		
		#	# With php7.0-cgi alone:
		#	fastcgi_pass 127.0.0.1:9000;
		#	# With php7.0-fpm:
			fastcgi_pass unix:/run/php/php7.0-fpm.sock;
		}
	
		# deny access to .htaccess files, if Apache's document root
		# concurs with nginx's one
		#
		location ~ /\.ht {
			deny all;
		}
	}
