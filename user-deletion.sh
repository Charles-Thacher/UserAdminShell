#!/bin/bash

# user backups
function backup_user_home {
    local user=$1 # user parameter
    # read -p "Select user to delete: " user

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


# delete the user
function delete_user {
    read -p "Enter username to be deleted: " user

    backup_user_home "$user"
    if [[ $? -ne 0 ]]; then
        echo "Aborting user deletion due to backup failure."
        exit -1
    fi

    # Actually delete the user
    read -p "Do you really want to delete user '$user'? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        userdel -r "$user"
        if [[ $? -eq 0 ]]; then
            echo "User '$user' has been deleted."
        else
            echo "Failed to delete user '$user'."
        fi
    else
        echo "Deletion cancelled."
    fi

}
