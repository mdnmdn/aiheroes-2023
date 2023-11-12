#!/bin/bash
set -e

base_path="$(dirname "$0")/../"
. $base_path/scripts/_commons.sh



redis_cmd="$(which redis-cli) -p $REDIS_PORT"


function get_json() {
    key=$(generate_short_key "$1")
    $redis_cmd json.get $key | jq
} 

function set_json() {
    key=$(generate_short_key "$1")
    text="$(jsonize_text "$1")"

    emb="$(dirname "$0")/embeddings.sh"
    embeddings="$("$emb" -o embeddings "$text")"
    json='{
        "id": "'"$key"'",
        "input": '"$text"',
        "embbedings": ['"$embeddings"']
    }' 
    echo "$json" | jq |$redis_cmd -x json.set "$key"
} 

function create_index


operation="$1"
content1=""
shift

case "$operation" in
   set)
    content1=$(get_content "$@")
    set_json "$content1"
    ;;
   get)
    content1=$(get_content "$@")
    get_json "$content1"
    ;;
   cmd)
    set -f
    $redis_cmd "$@"
    set +f
    ;;
   *) 
    echo "invalid operation: $operation, valid: set"
    exit 1;
    ;;  
esac        