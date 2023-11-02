#!/bin/bash

script_path=$(dirname "$0")

#input_file=$1
#output_directory=$2

input_directory="$script_path/../data/recipes"
output_directory="$script_path/../data/embeddings"

#rm -rf $output_directory
mkdir -p $output_directory

function generate_embeddings() {
    recipe_file="$1"
    recipe_text=$(cat "$input_directory/$recipe_file.md" | jq --raw-input  --slurp  .)

    echo processing $recipe_file

    json_input='{
        "input": '"$recipe_text"',
        "model": "text-embedding-ada-002"
    }'

    echo $json_input | curl -X POST https://api.openai.com/v1/embeddings -sS \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d @- > "$output_directory/$recipe_file.json"


    #$cmd #> "$output_directory/$recipe_file.json"
}


#generate_embeddings "abyssal-black-ink-pasta"

for recipe_file in $(ls $input_directory); do
    file=$(basename $recipe_file .md)
    if [ ! -f "$output_directory/$file.json" ]; then
        generate_embeddings $file
    fi
    #generate_embeddings $file
done





