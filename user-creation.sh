#!/bin/bash

# 1. Create a new user
# prompt username creation

choose_username

function choose_username {
    read -p "Enter new username: " username
    check_for_existence
}


function check_for_existence {
    # This function checks if a user exists and creates it if it doesn't

    echo "Checking if $username exists."
    
    if grep -q "^${username}:" /etc/passwd; then
        echo "$username is not available."

        read -p "Do you want to try again? (Y/N): " answer
        case "$answer" in
            [Yy]*) 
                do_something
                ;;
            [Nn]*) 
                echo "Exiting."
                exit 0
                ;;
            *) 
                echo "Invalid response. Exiting."
                exit 1
                ;;
        esac

    else
        echo "$username is available. Creating user $username."
        useradd "$username"
        if grep -q "^${username}:" /etc/passwd; then
            echo "$username successfully created!"
        else
            echo "Failed to create account for username "$username.\nScript failed.\n\nExiting."
        fi
    fi
}


# 2. Initial configuration of user

function select_password {

}