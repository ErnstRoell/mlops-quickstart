#!/usr/bin/bash
echo "Setting up Azure DevOps Project and infra"

git clone https://$organization@dev.azure.com/$organization/$project/_git/$repository
