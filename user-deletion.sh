# 1. Remove all permissions from user

# 2. Reassign the user assets
# Backup user assets

# Move assets to /var/backups/users
# 3. Delete the user
userdel -r "$username"