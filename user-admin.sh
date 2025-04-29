#!/bin/bash
# Administrate network users
# Functions in this source:
# list_users


# Option a: List Users
function list_users {
    awk -F: '$3 >= 1000 && $3 < 65534 { print $1 }' /etc/passwd
}

# Option 2: Change password