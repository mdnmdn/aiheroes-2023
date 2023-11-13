#!/bin/bash
set -e

base_path="$(dirname "$0")/.."
. $base_path/scripts/_commons.sh

redis_cmd="$(which redis-cli) -p $REDIS_PORT"

emb="$(dirname "$0")/embeddings.sh"


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
      #embed_json "$content"
      embed_hash "$content"
    done
}


function embed_hash() {
    local key=$(generate_short_key "$1")
    key=$(add_redis_prefix "$key")
    local original_text="$1"
    local text="$(jsonize_text "$original_text")"
    local title="$(extract_title "$original_text")"


    local embeddings="$("$emb" -o embeddings "$text")"
    local blob_embeddings="$(echo "$embeddings" | embeddings_to_hex )"
    local json='{
        "id": "'"$key"'"
        "text": '"$text"',
        "embeddings": ['"$embeddings"']
    }'

    echo hset "$key" id "$key" title '"'"$title"'"' text "$text" embeddings '"'"$blob_embeddings"'"' > $base_path/.data/redis_command.txt
    $redis_cmd < $base_path/.data/redis_command.txt
    #echo $redis_cmd -x hset "$key" id "$key" title "$title" text \""$text"\" embeddings \""$blob_embeddings"\"
    #echo -n ${blob_embeddings}  | $redis_cmd -x hset "$key" id "$key" title "$title" text "$original_text" embeddings

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
  local prefix=$(get_redis_prefix)
  local index_name="idx:$prefix"

  echo "create index $index_name"
  local index_exists=$(check_index)
  if [ "$(check_index)" == "ok" ]; then
    $redis_cmd FT.DROP "$index_name"
  fi

  local cmd='FT.CREATE '"$index_name"' ON HASH
  PREFIX 1 '"$prefix"': SCORE 1.0
  SCHEMA
    text TEXT WEIGHT 0.8
    title TEXT WEIGHT 1.0
    embeddings VECTOR FLAT 6 TYPE FLOAT32 DIM 1536 DISTANCE_METRIC COSINE'

  $redis_cmd $cmd

}

search_vector() {
  local text="$1"
   if [ -z "$text" ]; then
    echo "text is empty"
    exit 1
  fi

  echo "search vector"

  emb="$(dirname "$0")/embeddings.sh"

  blob_embeddings="$(echo -n "$text" |"$emb" -h)"

  local prefix=$(get_redis_prefix)
  local index_name="idx:$prefix"
  echo 'FT.SEARCH '"$index_name"' "*=>[KNN 10 @embeddings $query_vector as score]" RETURN 3 score title id SORTBY score DIALECT 2 "PARAMS" "2" "query_vector" "'"$blob_embeddings"'"' > $base_path/.data/redis_command.txt
  #local cmd='FT.SEARCH '"$index_name"' {*}=>[KNN {num} $embeddings $embeddings as vector_store] sortby vector_store limit 0 4 params 2 @embeddings '

  $redis_cmd < $base_path/.data/redis_command.txt
}

check_index() {
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
   set|embed)
    content1=$(get_content "$@")
    embed_hash "$content1"
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