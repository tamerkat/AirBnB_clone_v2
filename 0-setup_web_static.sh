#!/usr/bin/env bash
# script bash

sudo apt-get update
sudo apt-get install -y nginx

sudo ufw allow 'Nginx HTTP' 

sudo mkdir -p /data
sudo mkdir -p /data/web_static
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo touch /data/web_static/releases/test/index.html

sudo chown -R ubuntu:ubuntu "/data/"

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


sudo systemctl restart nginx
sudo service nginx restart
