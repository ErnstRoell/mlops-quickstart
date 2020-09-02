#!/usr/bin/bash

echo "Starting prep" 

cp $1/templates/template.json $1/deploy/template.json
sed -e "s/\${rnd}/$rnd/" \
	-e "s/\${location}/$location/" \
	-e "s/\${workspace}/$workspace/" \
	$1/templates/parameters.json > $1/deploy/parameters.json

# Now creating rg
az group create --location $location \
                --name $resourcegroup

# Deploy ARM
az deployment group create \
	--resource-group $resourcegroup \
	--template-file $1/deploy/template.json \
	--parameters $1/deploy/parameters.json
