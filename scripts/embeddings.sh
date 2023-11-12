#!/bin/bash
set -e 
base_path="$(dirname "$0")/../"
. $base_path/scripts/_commons.sh

output_type="embeddings"

while [[ $# > 0 ]];do
    case "$1" in
                -f|--file)
                        input=$(cat "$2")
                        shift
                        ;;
                -t|--tokens|--token)
                        output_type="tokens"
                        ;;
                -j|--json)
                        output_type="tokens"
                        ;;
                -s|--short)
                        output_type="short"
                        ;;
                -o|--out)
                        output_type="$2"
                        shift
                        ;;

                --help)
                        echo "Usage:"
                        echo "    --valueA \"value\""
                        echo "    --valueB \"value\""
                        echo "    --help"
                        exit 1
                        ;;
                *)
                    input="$input$1 "

                    ;;
                    
        esac
        shift
done

if [ -z "$input" ]; then
  input=$(cat -)
fi

if  [[ ! "||embedding||embeddings||json||token||tokens||short||" == *"||$output_type||"* ]]; then 
    echo "invalid output type: $output_type (valid: embeddings, json, tokens)"
    exit 1
fi

function call_openai_embedding() {
    json_input=$1
    result=$(echo "$json_input" | curl -X POST https://api.openai.com/v1/embeddings -sS \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d @-)

    if [[ "$result" == "{ \"error\":"* ]]; then
        echo $result >&2
        exit 1
    fi

    echo $result
}

function generate_embeddings() {
    text="$1"
    json_friendly_text=$(echo $text | jq --raw-input  --slurp  .)

    # search in cache
    cached_value=$(read_cache "embeddings" "$json_friendly_text" ".json")
    if [ ! -z "$cached_value" ]; then
        echo $cached_value
        return
    fi

    json_input='{
        "input": '"$json_friendly_text"',
        "model": "text-embedding-ada-002"
    }'
    result=$(call_openai_embedding "$json_input")

    # write to cache
    write_cache "embeddings" "$json_friendly_text" "$result" ".json"

    echo $result

}

#generate_embeddings "$input"

json=$(generate_embeddings "$input")

if [[ "$output_type" == "embeddings" || "$output_type" == "embedding" ]]; then
    echo $json | jq '.data[0].embedding| join(", ") ' -r
elif [ "$output_type" == "json" ]; then
    echo $json
elif [ "$output_type" == "tokens" ]; then
    echo $json | jq '.usage.total_tokens'
elif [ "$output_type" == "short" ]; then
    tokens=$(echo $json | jq '.usage.total_tokens')
    embeddings=$(echo $json | jq '.data[0].embedding[:6] | join(", ")' -r )
    echo "t:$tokens [ $embeddings, ... ]"

fi

#echo $json
#tokens=$(echo $json | jq '.usage.total_tokens')
#echo tokens: $(echo $json | jq '.usage.total_tokens')







