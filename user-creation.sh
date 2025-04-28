#!/usr/bin/env bash

# Found online as a snippet. Keeps script from being run without sudo privalages.
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi



# 1. Create a new user
# prompt username creation

function create_user {
    # This function checks if a user exists and creates it if it doesn't

    read -p "Enter new username: " username

    echo "Checking if $username is valid."

    # ensure username only contains valid alphanumerica characters
    if [[ ! "$username" =~ ^[a-zA-z0-9_]+$ ]]; then
        

    else
        
    fi

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
            echo "Failed to create account for username $username."
            echo "Script failed."
            echo
            echo "Exiting."
            exit 1
        fi
    fi
}




function select_password {

}


choose_username


# 2. Initial configuration of user

