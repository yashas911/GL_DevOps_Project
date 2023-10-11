#!/bin/bash
sudo yum update
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<html><body><h1>Congratulations for Successful installation of NGINX on Amazon EC2 instance upon $(hostname -f)</h1></body></html>" | sudo tee /usr/share/nginx/html/index.html
