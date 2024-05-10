#!/bin/bash

# List of AWS regions
regions=(
  us-east-1
  us-east-2
  us-west-1
  us-west-2
  ca-central-1
  ap-southeast-1
  ap-southeast-2
  eu-west-1
  eu-west-2
  eu-west-3
  eu-north-1
  eu-south-1
  sa-east-1
)

# Domain name
domain="*.cascld.com"

# Iterate over the regions
for region in "${regions[@]}"
do
  # Create certificate in the region
  echo "Creating wildcard certificate for $domain in region $region"
  aws --region $region acm request-certificate --domain-name $domain --validation-method DNS

  # Sleep for a few seconds before proceeding
  sleep 5
done
