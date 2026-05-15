#!/bin/bash

set -euo pipefail

account_region="${AWS_ACCOUNT_REGION:-us-east-1}"

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
  status="$(aws account list-regions \
    --region "$account_region" \
    --region-opt-status-contains ENABLED ENABLED_BY_DEFAULT ENABLING \
    --query "Regions[?RegionName=='$region'].RegionOptStatus | [0]" \
    --output text)"

  if [[ "$status" != "None" ]]; then
    echo "Region $region already $status."
    continue
  fi

  echo "Enabling region $region..."
  aws account enable-region --region "$account_region" --region-name "$region"
  echo "Region $region enable requested."
done
