#!/bin/bash

# List of all AWS regions
aws_regions=(
    "us-east-1" "us-east-2" "us-west-1" "us-west-2" "af-south-1" "ap-east-1"
    "ap-south-1" "ap-northeast-1" "ap-northeast-2" "ap-northeast-3" "ap-southeast-1"
    "ap-southeast-2" "ca-central-1" "cn-north-1" "cn-northwest-1" "eu-central-1"
    "eu-west-1" "eu-west-2" "eu-west-3" "eu-north-1" "eu-south-1" "me-south-1"
    "sa-east-1"
)

run_cloud_nuke() {
    local region=$1
    echo "Running cloud-nuke for region: $region"
    cloud-nuke aws --region "$region" --force
    if [ $? -eq 0 ]; then
        echo "Success: $region"
    else
        echo "Error: $region"
    fi
}

export -f run_cloud_nuke

# Run cloud-nuke in parallel for all regions
parallel -j 0 run_cloud_nuke ::: "${aws_regions[@]}"
