#!/bin/bash

#load environment variables
source ./env_vars.sh

#connect to EC2 instance using SSH
ssh -i "$SSH_KEY_PATH" "$USERNAME@$IP_ADDRESS" <<  'EOF'

#update the package management system to get the latest nginx
sudo apt update

#install nginx
sudo apt install -y nginx

#starte nginx
sudo systemctl start nginx

#make nginx start when the instance is boot up
sudo systemctl enable ngin
EOF

