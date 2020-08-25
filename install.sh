# Set Azure Env Variables

# Read configs 
while read -r name value; do
    export $name=$(echo $value | envsubst)
done < <(yq -r 'to_entries[] | "\(.key) \(.value)"' ./config/config.yml)

echo $rnd
echo $resourcegroup

# Deploy azure resources
source ./azure/scripts/1_DeployARM.sh
source ./devops/scripts/2_DeployDevOps.sh
source ./devops/scripts/3_CreatePipeline.sh
