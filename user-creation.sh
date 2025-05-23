#!/bin/bash

# Functions in this source:
# creation_prompt
# create_user
# select_password

# Sudo required to run script
if [ $(id -u) -ne 0 ]; then
    echo "Script failed. Super user required."
    exit -1
fi

# prompt username creation
function creation_prompt {
    read -p "Enter new username: " username
    read -p "Enter full name: (e.g. John Smith) " name_of_user
}

function create_user {
    # This function checks if a user exists and creates it if it doesn't

    echo "Checking if $username is valid."

    # ensure username only contains valid alphanumerical characters
    if [[ ! "$username" =~ ^[a-zA-Z0-9_]+$ ]]; then
        echo "$username is not valid."
        echo
        echo "You may only use alpha-numeric characters. (A-z, 0-9)."
        echo
        echo "Exiting."

        exit -1        
    fi

    
    if [[ ! $name_of_user =~ ^[A-Za-z\ ]+$ ]]; then
        echo "$name_of_user is not valid."
        echo
        echo "You may only use the Latin alphabet and spaces. (A–Z or a–z)."
        echo
        echo "Sorry hyphenated and apostrophed names, I couldn't get the regex working."
        echo
        echo "Exiting."
        exit 1
    fi

    # check for availability
    echo "Checking if $username exists."
    
    if grep -q "^${username}:" /etc/passwd; then
        echo "$username is not available."

        read -p "Do you want to try again? (Y/N): " answer
        case "$answer" in
            [Yy]*) 
                create_user
                ;;
            [Nn]*) 
                echo "Script cancelled. Exiting."
                exit 0
                ;;
            *) 
                echo "Invalid response. Exiting."
                exit -1
                ;;
        esac

    else
        echo
        echo "$username is available. Creating user $username."
        echo
        useradd -m "$username" -c "$name_of_user"

        if grep -q "^${username}:" /etc/passwd; then
            echo "$username successfully created!"

        else
            echo "Failed to create account for username $username."
            echo "Script failed."
            echo
            echo "Exiting."
            exit -1
        fi
    fi
}


function select_password {
    passwd $username
}

# function end_user_creation {
#     read -p "Would you like to configure settings for "$username"? (Y/N): " answer
#             case "$answer" in
#                 [Yy]*) 
#                     ./user-admin.sh
#                     ;;
#                 [Nn]*) 
#                     echo "Script finished. Exiting."
#                     exit 0
#                     ;;
#                 *) 
#                     echo "Invalid response. Exiting."
#                     exit -1
#                     ;;
#             esac
#     exit
# }


