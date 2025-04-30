#!/bin/bash
# Administrate network users
# Functions in this source:
# list_users


# Option a: List Users
function list_users {
    awk -F: '$3 >= 1000 && $3 < 65534 { print $1 }' /etc/passwd
}


# Option b: Change password
function change_password {
    read -p "Enter user whose password you would like to change: " user
    read -p "Enter new password: " new_pass
    echo "Changing user password."
    echo '$user:$new_pass' | chpasswd
}