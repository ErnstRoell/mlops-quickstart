# Read configs 
while read -r name value; do
    declare "$name=$value"
done < <(yq -r 'to_entries[] | "\(.key) \(.value)"' test.yml)

# Set Azure Env Variables

