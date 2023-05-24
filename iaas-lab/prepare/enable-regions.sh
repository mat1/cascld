#!/bin/bash

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

for region in "${regions[@]}"; do
  echo "Enabling region $region..."
  aws enable-region --region-name "$region"
  echo "Region $region enabled."
done
