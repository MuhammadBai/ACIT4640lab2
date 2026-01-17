#!/bin/bash

#load environment variables
source ./env_vars.sh

#set up today variable to get the current date
today=$( date +"%d/%m/%Y")

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
scp -i "$SSH_KEY_PATH" index.html "$USERNAME@$IP_ADDRESS:/tmp/index.html"



ssh -i "$SSH_KEY_PATH" "$USERNAME@$IP_ADDRESS" << EOF
	#backup original nginx html file
	sudo mv /var/www/html/index.html /var/www/html/index.html.bak
	
	echo "current index:"
	cat /var/www/html/index.html

	echo "expected index"
	cat /tmp/index.html

	#move the html file we generated above to nginx folder
	sudo mv /tmp/index.html /var/www/html/index.html
EOF

