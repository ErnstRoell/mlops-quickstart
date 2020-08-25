echo "Setting up Azure DevOps Project and infra"

echo "Createing Variable group"
az pipelines variable-group create \
	--name $variablegroup \
	--project $project \
	--organization $orguri \
	--authorize true \
	--variables \
		resourcegroup=$resourcegroup \
		workspace=$workspace \
		experiment=$experiment \
		aml_compute_target=$compute \
		serviceconnection=$serviceconnection \
		model_name=$model_name \
		image_name=$image_name

echo "Fetching project id"
projectid=$(az devops project show \
	--organization $orguri \
	--project $project | jq -r ".id")

tenantid=$(az account show | jq -r ".tenantId")
subscription=$(az account show | jq -r ".id")

echo "Creating service connection template"
sed \
	-e "s/\${location}/$location/" \
	-e "s/\${workspace}/$workspace/" \
	-e "s/\${resourcegroup}/$resourcegroup/" \
	-e "s/\${serviceconnection}/$serviceconnection/" \
	-e "s/\${projectid}/$projectid/" \
	-e "s/\${project}/$project/" \
	-e "s/\${tenantid}/$tenantid/" \
	-e "s/\${subscription}/$subscription/" \
	./devops/templates/sc-template.json > ./devops/deploy/sc-config.json


az devops service-endpoint create \
	--service-endpoint-configuration ./devops/deploy/sc-config.json \
	--organization $orguri \
	--project $project > ./logs/sc-logs.txt


scid=$(cat ./logs/sc-logs.txt | jq -r ".id")
echo $scid


az pipelines create \
	--name "mlops-pipeline-test" \
	--organization $orguri \
	--project $project \
	--repository $repository \
	--yaml-path "./azure-pipelines.yml" \
	--repository-type tfsgit 


az devops service-endpoint update \
	--enable-for-all \
	--id $scid \
	--organization $orguri \
	--project $project 
