#!/usr/bin/env bash
# script bash
sudo apt-get update
sudo apt-get install -y nginx
sudo service nginx start

sudo ufw allow 'Nginx HTTP' 

sudo mkdir -p /data
sudo chown -R /data
sudo mkdir -p /data/web_static
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

sudo touch /data/web_static/releases/test/index.html

sudo echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html


ln -sf /data/web_static/releases/test/ /data/web_static/current

sudo chown -R ubuntu:ubuntu /data/

printf %s "server {
    listen 80;
    server_name _;

    location /hbnb_static {
        alias /data/web_static/current/;
    }
}" > /etc/nginx/sites-available/default


sudo service nginx restart
