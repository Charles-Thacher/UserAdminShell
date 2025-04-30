#!/bin/bash

# user backups
function backup_user_home {
    read -p "Select user to delete: " user

    # Check if the user exists
    if ! id "$user" &>/dev/null; then
        echo "$user does not exist."
        exit -1
    fi

    local home_dir
    home_dir=$(eval echo "~$user")
    local backup_dir="/backup/${user}_home_$(date +%Y%m%d_%H%M%S).tar.gz"

    echo "Backing up $home_dir to $backup_dir."
    mkdir -p /backup
    tar -czf "$backup_dir" "$home_dir"
    if [[ $? -eq 0 ]]; then 
        echo "Backup successful."
        exit 0
    else
        echo "Backup failed."
        exit -1
    fi
}

# Move assets to /var/backups/users
# 3. Delete the user
userdel -r "$username"