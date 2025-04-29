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
echo "  - Change User Groups"
echo "  - Change User Permissions"
echo "X. Exit"

read -p "Select an option:" option

# 0. Select functions
case $option in
    1 | 1. | create | create\ user)
        echo "Create User"
        creation_prompt
        create_user
        ;;
    2 | 2. | delete | delete\ user)
        echo "You chose to delete a user."
        ;;
    3 | 3. | admin | admin\ user | administrate | administrate\ user)
        echo "You chose to administrate users."
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

# Call proper module
## Creation
## Admin
## Deletion

# Once module exits, do clean up and exit
## Maybe provide another option to re-run module or select another one