#!/bin/bash

# Author: se3d3r
# Creation: 11.01.2023

# Check if root
if [ "$UID" -ne 0 ]; then
    echo "Must be executed as root."
    exit 1
fi


# Creating required directories
sudo mkdir -p /var/guacamole/recordings
sudo rm -r /var/guacamole/data
sudo mkdir -p /var/guacamole/data
sudo chown -R 1000:1001 /var/guacamole/recordings
sudo chmod -R 2750 /var/guacamole/recordings

rc_file="$HOME/.bashrc"

# Setting environment variables for docker images
setting_envs(){
    
    local var_name=$1
    local var_value
    local var_confirmation

    # ask value
    
    read -p "Enter value for ${var_name}: " var_value
    read -p "Confirm value for ${var_name}: " var_confirmation

    # check confirmation
    if [ "${var_value}" != "${var_confirmation}" ]; then
        echo "Confirmation values do not match."
        exit 1
    fi

    # export the variable
    export ${var_name}=${var_value}    
    echo -e "Value successfully set.\n"

}

setting_envs "MYSQL_ROOT_PASSWORD"
setting_envs "MYSQL_USER_PASSWORD"

docker-compose up -d