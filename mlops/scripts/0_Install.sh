#!/usr/bin/bash
# Set Azure Env Variables

echo "filepath" $1
echo "suffix" $2
export rnd=$2

# Read configs 
while read -r name value; do
    export $name=$(echo $value | envsubst)
done < <(yq -r 'to_entries[] | "\(.key) \(.value)"' $1/config/config.yml)


echo $rnd
echo $resourcegroup

# Deploy azure resources
source $1/scripts/1_DeployARM.sh
source $1/scripts/2_DeployDevOps.sh
source $1/scripts/3_CreatePipeline.sh
source $1/scripts/4_CreateLocalFolder.sh
