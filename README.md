# ACIT4640lab2

## Part 3

create and go to the target loaction:

`mkdir -p part1-scripts`

` cd part1-scripts/`

create the environment variable file:

`nano env-vars.sh`

write the following variables:

```
USERAME="admin"
IP_ADDRESS="44.251.116.101"
SSH_KEY_PATH="/home/SarahLinux/.ssh/wkone"
```

### script 1

create the script 1 file:

` nano nginx-install.sh`

write the following commands:

```
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
```

1. Inside the script, firstly *source* to `env_vars.sh` so that the variable defined in that file can be used in the script.

2. Then `ssh` is used to connect to EC2 instance.

3. Finanlly, updating the package management, installing nginx, enabling it, are setting up sequencially.

### script 2
create the script 2 file:

`nano document-write.sh`

write the below commands:

```
#!/bin/bash

#load environment variables
source ./env_vars.sh

#set up today variable to get the current date
today=$(date+"%d/%m/%Y")

#write a new html doc
echo "<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>Hello World</title>
</head>
<body>
  <h1>Hello World!</h1>
  <p>Today's date is: $today</p>
</body>
</html>" > index.html

#copy the html file to EC2 instance
scp -i "SSH_KEY_PATH" index.html "$USERNAME@$IP_ADDRESS:/index.html"

#backup original nginx html file
ssh -i "SSH_KEY_PATH" "$USERNAME@$IP_ADDRESS" "sudo mv /var/www/html/index.html /var/www/html/index.html.bak"

#move the html file we generated above to nginx folder
ssh -i "$SSH_KEY_PATH" "$USERNAME@$IP_ADDRESS" "sudo mv /tmp/index.html /var/www/html/index.html"
```

This script:
1. createa a new html file which we need nginx to load when it starts up.
2. creates a backup for the original html in case we need to restore it. 
3. shows the real today date which is captured from the local machine.




