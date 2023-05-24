#!/bin/bash

# List of user names
user_names=(
  "cas-us-east-1"
  "cas-us-east-2"
  "cas-us-west-1"
  "cas-us-west-2"
  "cas-ca-central-1"
  "cas-ap-southeast-1"
  "cas-ap-southeast-2"
  "cas-eu-west-1"
  "cas-eu-west-2"
  "cas-eu-west-3"
  "cas-eu-north-1"
  "cas-eu-south-1"
  "cas-sa-east-1"
)

# Iterate over user names
for user_name in "${user_names[@]}"; do
    # Create IAM user
    aws iam create-user --user-name "$user_name"

    # Add user to the "CAS" group
    aws iam add-user-to-group --user-name "$user_name" --group-name "CAS"

    # Create login profile for the user with password
    aws iam create-login-profile --user-name "$user_name" --password "PASSWORD123"

    # Output success message
    echo "Created user: $user_name"
done