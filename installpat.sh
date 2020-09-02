# Read configs 
while read -r name value; do
    export $name=$(echo $value | envsubst)
done < <(yq -r 'to_entries[] | "\(.key) \(.value)"' ./model/config/config.yml)
cat pat.txt | az devops login --organization $orguri
