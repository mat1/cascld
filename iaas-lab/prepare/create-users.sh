#!/bin/bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <password>"
  exit 1
fi

password="$1"
group_name="cas"

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

if aws --no-cli-auto-prompt iam get-group --group-name "$group_name" >/dev/null 2>&1; then
  echo "Group already exists: $group_name"
else
  aws --no-cli-auto-prompt iam create-group --group-name "$group_name" >/dev/null
  echo "Created group: $group_name"
fi

for user_name in "${user_names[@]}"; do
  aws --no-cli-auto-prompt iam create-user --user-name "$user_name" >/dev/null

  aws --no-cli-auto-prompt iam add-user-to-group \
    --user-name "$user_name" \
    --group-name "$group_name"

  aws --no-cli-auto-prompt iam create-login-profile \
    --user-name "$user_name" \
    --password "$password" >/dev/null

  echo "Created user: $user_name"
done
