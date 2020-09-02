#!/usr/bin/bash
echo "Setting up Azure DevOps Project and infra"

az devops project create \
	--name $project \
	--org $orguri \
        --source-control git \
	--visibility public


az repos create \
	--name $repository \
        --org $orguri \
	--project $project \
	--name $repository

az repos import create --git-source-url https://github.com/ErnstRoell/mcw-mlops-starter-v2.git\
	--organization $orguri \
	--project $project \
	--repository $repository 



