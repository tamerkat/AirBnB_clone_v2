#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y nginx
sudo service nginx start

sudo ufw allow 'Nginx HTTP' 

sudo mkdir -p "/data/web_static/releases/test/" "/data/web_static/shared/"

sudo touch /data/web_static/releases/test/index.html

sudo chown -hR ubuntu:ubuntu "/data/"

echo "<h1>Hello World!</h1>" | sudo tee "/data/web_static/releases/test/index.html"

if [ -L /data/web_static/current ]; then
    rm /data/web_static/current
fi
ln -s /data/web_static/releases/test/ /data/web_static/current


printf %s "server {
    listen 80;
    server_name _;

    location /hbnb_static {
        alias /data/web_static/current/;
    }
}" > /etc/nginx/sites-available/default


sudo service nginx restart
