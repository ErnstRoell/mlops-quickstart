echo "Starting prep" 

# Read configs 
while read -r name value; do
    export $name=$(echo $value | envsubst)
done < <(yq -r 'to_entries[] | "\(.key) \(.value)"' ./azure/config/config.yml)

cp ./azure/templates/template.json ./azure/deploy/template.json
sed -e "s/\${rnd}/$rnd/" \
	-e "s/\${location}/$location/" \
	-e "s/\${workspace}/$workspace/" \
	./azure/templates/parameters.json > ./azure/deploy/parameters.json

# Now creating rg
az group create --location $location \
                --name $resourcegroup

# Deploy ARM
az deployment group create \
	--resource-group $resourcegroup \
	--template-file ./azure/deploy/template.json \
	--parameters ./azure/deploy/parameters.json
