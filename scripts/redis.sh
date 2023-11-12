#!/bin/bash
set -e

base_path="$(dirname "$0")/../"
. $base_path/scripts/_commons.sh

redis_cmd="$(which redis-cli) -p $REDIS_PORT"

function get_json() {
    key=$(generate_short_key "$1")
    key=$(add_redis_prefix "$key")
    $redis_cmd json.get $key | jq
} 


function embed_json() {
    key=$(generate_short_key "$1")
    key=$(add_redis_prefix "$key")
    text="$(jsonize_text "$1")"

    emb="$(dirname "$0")/embeddings.sh"
    #echo "$emb" -o embeddings "$text"
    embeddings="$("$emb" -o embeddings "$text")"

    json='{
        "id": "'"$key"'",
        "input": '"$text"',
        "embbedings": ['"$embeddings"']
    }'
    echo "$json" | jq | $redis_cmd -x json.set  "$key" \$
}

embed_folder() {
    local folder="$1"
    if [ -z "$folder" ]; then
      echo "folder is empty"
      exit 1
    fi
    if [ ! -d "$folder" ]; then
      echo "folder does not exist: $folder"
      exit 1
    fi
    local files=$(find "$folder" -type f)
    echo files: $files
    local file

    for file in $files; do
      echo "embedding file: $file"
      local content=$(cat "$file")
      embed_json "$content"
    done
}


function set_json() {
    key=$(generate_short_key "$1")
    key=$(add_redis_prefix "$key")
    text="$(jsonize_text "$1")"

    emb="$(dirname "$0")/embeddings.sh"
    embeddings="$("$emb" -o embeddings "$text")"
    json='{
        "id": "'"$key"'",
        "input": '"$text"',
        "embeddings": ['"$embeddings"']
    }'

    echo "$json" | jq | $redis_cmd -x json.set "$key" \$
} 

create_index() {
  echo "create index"
  prefix=$(get_redis_prefix)
  local cmd='FT.CREATE idx:'"$prefix"' ON JSON
  PREFIX 1 pp: SCORE 1.0
  SCHEMA
    $.input  TEXT WEIGHT 1.0
    $.embeddings VECTOR FLAT 6 TYPE FLOAT32 DIM 1536 DISTANCE_METRIC COSINE'

  $redis_cmd $cmd
  #$redis_cmd FT.CREATE idx:'"$prefix"' ON JSON \
  #PREFIX 1 pp: SCORE 1.0 \
  #SCHEMA \
  #  $.input  TEXT WEIGHT 1.0 \
  #  $.embeddings VECTOR FLAT 6 TYPE FLOAT32 DIM 1536 DISTANCE_METRIC COSINE
}

search_vector() {
  local text="$1"
   if [ -z "$text" ]; then
    echo "text is empty"
    exit 1
  fi

  echo "search vector"

  emb="$(dirname "$0")/embeddings.sh"
  embeddings="$("$emb" -o embeddings "$text")"

  prefix=$(get_redis_prefix)
  local cmd='FT.SEARCH idx:'"$prefix"' "@embeddings:[0.1 0.2 0.3 0.4 0.5 0.6]"'
  $redis_cmd $cmd
}

check_index() {
  echo "create index"
  prefix=$(get_redis_prefix)
  local cmd='FT.INFO idx:'"$prefix"
  local result=$(echo "$cmd" | $redis_cmd)
  if [[ "$result" == *"Unknown index name"* ]]; then
    echo "no"
  else
    echo "ok"
  fi
}

operation="$1"
content1=""
shift

case "$operation" in
   set)
    content1=$(get_content "$@")
    set_json "$content1"
    ;;
   embed)
    content1=$(get_content "$@")
    embed_json "$content1"
    ;;
   embed-folder)
    content1=$(get_content "$@")
    embed_folder "$content1"
    ;;
   get)
    content1=$(get_content "$@")
    get_json "$content1"
    ;;
   search)
    content1=$(get_content "$@")
    search_vector "$content1"
    ;;

   create-index)
    create_index
    ;;
   check-index)
    check_index
    ;;
   prefix)
    prefix=$(get_content "$@")
    if [ -z "$prefix" ]; then
      get_redis_prefix
    else
      set_redis_prefix "$prefix"
    fi
    ;;
   cmd)
    set -f
    $redis_cmd "$@"
    set +f
    ;;
   *) 
    echo "invalid operation: $operation, valid: set, embed, get, prefix, cmd"
    exit 1;
    ;;  
esac        