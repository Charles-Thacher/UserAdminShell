#!/bin/bash

# Bash sources
source ./user-creation.sh
source ./user-admin.sh
source ./user-deletion.sh

if [ $(id -u) -ne 0 ]; then
    echo "Script failed. Super user required."
    exit -1
fi

echo "1. Create User"
echo "2. Delete User"
echo "3. Administrate Users"
echo "  - List Users"
echo "  - Change User Password"
echo "  - Backup User Home Dir"
echo "X. Exit"

read -p "Select an option: " option

# 0. Select functions
case $option in
    1 | 1. | create | create\ user)
        echo "Create User"
        creation_prompt
        create_user
        echo "User sucessfully created. Exiting."
        echo
        exit 0
        ;;
    2 | 2. | delete | delete\ user)
        echo "You chose to delete a user."
        delete_user
        ;;
    3 | 3. | admin | admin\ user | administrate | administrate\ user)
        echo "You chose to administrate users."
        echo
        echo "a. List Users"
        echo "b. Change Password"
        echo "c. Change Permissions"
        read -p "Please choose suboption: " suboption
        
        # call case switch for user admin
        case "$suboption" in
            a | a. | list | list\ users)
                echo "Listing all (human) users:"
                list_users
                ;;
            b | b. | password | change\ password)
                change_password
                ;;
            c | c. | backup | backup\ user | perms)
                # select user, then call backup                
                read -p "Select user to backup: " user
                backup_user_home "$user"
                ;;
            *)
                echo "Invalid sub-option."
                exit 1
                ;;
        esac
        ;;
    x | x.| exit)
        echo "You chose to exit."
        echo
        echo "Closing process."
        exit 0
        ;;
    *)
        echo "Invalid input. Exiting."
        exit -1
        ;;
esac


# Once module exits, do clean up and exit
## Maybe provide another option to re-run module or select another one