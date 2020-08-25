echo "Starting prep" 
source params.sh

cp ./azure-template/template.json ./azuredeploy/template.json
sed -e "s/\${rnd}/$rnd/" \
	-e "s/\${location}/$location/" \
	-e "s/\${workspace}/$workspace/" \
	./azure-template/parameters.json > ./azuredeploy/parameters.json

# Now creating rg
az group create --location $location \
                --name $resourcegroup

# Create storage account for 3 datasets. 
az storage create --location $location \
                  --resourcegroup $resourcegroup \ 
				  --name $datastorage

az storage container create --name "DEV"
az storage container create --name "TEST"
az storage container create --name "PROD"


# Deploy ARM
az deployment group create \
	--resource-group $resourcegroup \
	--template-file ./azuredeploy/template.json \
	--parameters ./azuredeploy/parameters.json
