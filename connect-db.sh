#!/usr/bin/env bash
root_dir=$(pwd)
cd infrastructure/terraform

instance_id=$(cat terraform.tfstate | jq '.outputs.instance_id.value')
database=$(cat terraform.tfstate | jq '.outputs.db_name.value')

# Remove quotes
instance_id=${instance_id//\"/}
database=${database//\"/}

cd $root_dir

PGDATABASE=$database gcloud sql connect $instance_id --user=admin
