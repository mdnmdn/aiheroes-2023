
cache_path="$base_path/.cache"
data_path="$base_path/.data"
session_id_path="$data_path/session"
session_path="$base_path/sessions"


mkdir -p $cache_path $data_path $session_path

nc='\033[0m'
black="\033[0;30m"
red="\033[0;31m"
green="\033[0;32m"
orange="\033[0;33m"
blue="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
lightgray="\033[0;37m"
darkgray="\033[1;30m"
lightred="\033[1;31m"
lightgreen="\033[1;32m"
yellow="\033[1;33m"
lightblue="\033[1;34m"
lightpurple="\033[1;35m"
lightcyan="\033[1;36m"
white="\033[1;37m"





function cache_key() {
    prefix="$1"
    value_key="$2"

    key="$prefix-$(echo $value_key | md5sum | cut -d' ' -f1)"

    #[ ! -z "$3" ] && key="$key$3"

    echo "$key"
}



redis_prefix_file="$data_path/redis_prefix"
set_redis_prefix() {
    redis_prefix="$1"
    if [ -z "$redis_prefix" ]; then
      rm "$redis_prefix_file" 2>/dev/null
    else
      echo "$redis_prefix" > "$redis_prefix_file"
    fi
}

get_redis_prefix() {
    if [ -f "$redis_prefix_file" ]; then
      cat "$redis_prefix_file"
    else
      echo "<no prefix>"
    fi
}

add_redis_prefix() {
    key="$1"
    if [ -z "$redis_prefix_file" ]; then
      echo "$key"
    else
      prefix=$(cat "$redis_prefix_file")
      echo "$prefix:$key"
    fi

}

function read_cache() {
    key=$(cache_key "$1" "$2" "$3")
    if [ -f "$cache_path/$key" ]; then
        cat "$cache_path/$key"
    fi
}

function write_cache() {
    key=$(cache_key "$1" "$2" "$3")
    value="$3"
    echo "$value" > "$cache_path/$key"
}

function generate_short_key(){
    echo "$1" | md5sum | head -c8
}

function jsonize_text() {
  if [ -z "$1" ]; then
    cat -
  else
    echo "$1"
  fi | remove_trailing_newline | jq --raw-input  --slurp  . | remove_trailing_newline
  #echo "$txt" | jq --raw-input  --slurp  .
}

extract_title() {
  if [ -z "$1" ]; then
    cat -
  else
    echo "$1"
  fi |  grep '\w' | head -n 1 | tr -d "\#\n" | sed -e 's/^[[:space:]]*//' | remove_trailing_newline
}

remove_trailing_newline() {
  if [ -z "$1" ]; then
    cat -
  else
    echo "$1"
  fi | sed -e 's/[[:space:]]*$//'
}

embeddings_to_blob() {
  if [ -z "$1" ]; then
    cat -
  else
    echo "$1"
  fi | tr -d '[],'| "${base_path}/scripts/floats-to-blob"
  #echo "$txt" | jq --raw-input  --slurp  .
}

embeddings_to_hex() {
  if [ -z "$1" ]; then
    cat -
  else
    echo "$1"
  fi | tr -d '[],'| "${base_path}/scripts/floats-to-hex"
  #echo "$txt" | jq --raw-input  --slurp  .
}

function get_content() {
  content=""
  if [[ "||-f||--file||" == *"||$1||"* ]]; then content=$(cat $2)
  elif [[ "||-||" == *"||$1||"* ]]; then content=$(cat -)
  else content="$1"
  fi

  echo $content
}


# ------------------- REDIS -------------------

redis_cmd="$(which redis-cli) -p $REDIS_PORT --json "

emb="$(dirname "$0")/embeddings.sh"

function redis_get_json() {
    key=$(generate_short_key "$1")
    key=$(add_redis_prefix "$key")
    $redis_cmd json.get $key | jq
}


function redis_embed_json() {
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

redis_embed_folder() {
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
    #echo files: $files
    local file

    for file in $files; do
      echo "embedding file: $file"
      local content=$(cat "$file")
      #embed_json "$content"
      redis_embed_hash "$content" "$file"
    done
}


redis_embed_hash() {
    local filename=$([ -n "$2" ] && basename "$2" || echo '')

    local key=$([ -z "$filename" ] && generate_short_key "$1" || echo $filename)
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

    echo hset "$key" id "$key" title '"'"$title"'"' recipe_name  '"'"$filename"'"' text "$text" embeddings '"'"$blob_embeddings"'"' > $base_path/.data/redis_command.txt

    cat "$base_path/.data/redis_command.txt" | print_in_session - "redis create embed" "redis"

    local output=$($redis_cmd < $base_path/.data/redis_command.txt)
    if [[ "$output" == *"error"* ]]; then
      echo -e ${red} ${key}: ${output} ${nc} >&2
    else
      echo "${key} (${output})"
    fi
    #echo $redis_cmd -x hset "$key" id "$key" title "$title" text \""$text"\" embeddings \""$blob_embeddings"\"
    #echo -n ${blob_embeddings}  | $redis_cmd -x hset "$key" id "$key" title "$title" text "$original_text" embeddings


}

redis_set_json() {
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

redis_create_index() {
  local prefix=$(get_redis_prefix)
  local index_name="idx:$prefix"

  echo "create index $index_name"
  local index_exists=$(redis_check_index)
  if [ "$(redis_check_index)" == "ok" ]; then
    $redis_cmd FT.DROP "$index_name"
  fi

  local cmd='FT.CREATE '"$index_name"' ON HASH
  PREFIX 1 '"$prefix"': SCORE 1.0
  SCHEMA
    text TEXT WEIGHT 0.8
    title TEXT WEIGHT 1.0
    embeddings VECTOR FLAT 6 TYPE FLOAT32 DIM 1536 DISTANCE_METRIC COSINE'

  echo -e "$cmd" | print_in_session - "redis create index" "redis"

  $redis_cmd $cmd

}

redis_search_vector() {
  local text="$1"
   if [ -z "$text" ]; then
    echo "text is empty"
    exit 1
  fi

  #echo -e "${yellow}search vector${nc}" >&2

  emb="$(dirname "$0")/embeddings.sh"

  blob_embeddings="$(echo -n "$text" |"$emb" -h)"

  local prefix=$(get_redis_prefix)
  local index_name="idx:$prefix"
  echo 'FT.SEARCH '"$index_name"' "*=>[KNN 10 @embeddings $query_vector as score]" RETURN 5 score title recipe_name id text SORTBY score DIALECT 2 "PARAMS" "2" "query_vector" "'"$blob_embeddings"'"' > $base_path/.data/redis_command.txt
  #local cmd='FT.SEARCH '"$index_name"' {*}=>[KNN {num} $embeddings $embeddings as vector_store] sortby vector_store limit 0 4 params 2 @embeddings '

  cat "$base_path/.data/redis_command.txt" | print_in_session - "redis vector search" "redis"

  result="$($redis_cmd < "$base_path/.data/redis_command.txt")"
  if [[ "$result" == "error"* ]]; then
    echo -e ${red} ${result} ${nc} >&2
  else
    echo "$result" | jq | print_in_session - "redis search results" json

    echo "$result" | jq
  fi
  #echo -e ${red} ${result} ${nc}
}

redis_check_index() {
  prefix=$(get_redis_prefix)
  local cmd='FT.INFO idx:'"$prefix"
  local result=$(echo "$cmd" | $redis_cmd)
  if [[ "$result" == *"Unknown index name"* ]]; then
    echo "no"
  else
    echo "ok"
  fi
}

redis_clear_all() {
  local cmd='FLUSHDB'
  local result=$(echo "$cmd" | $redis_cmd)
}

get_current_session() {
  # check if file in $session_path don't exists
  if [ ! -f "$session_id_path" ]; then
    # create new session
    session_id=$(uuidgen)
    echo "$session_id" > "$session_id_path"
  fi
  cat "$session_id_path"
}

set_session() {
  if [ ! -f "$session_id_path" ]; then
    mkdir -p "$(dirname "$session_id_path")"
    echo 001 > "$session_id_path"
  else
    local current_session=$(get_current_session)
    local new_session=$(echo "0000000$(echo "$current_session" + 1| bc)" | tail -c 4)
    #echo "new session: $new_session   -   $current_session"
    echo "$new_session" > "$session_id_path"
  fi

  cat "$session_id_path"
}
current_session_file() {
  local current_session=$(get_current_session)
  echo "$session_path/${current_session}.md"
}
clear_current_session() {
  echo ""> $(current_session_file)
}

print_current_session() {
  cat $(current_session_file)
}

print_in_session() {
  local title="$2"
  local contents="$1"
  local text_type="$3"
  [ -z "$text_type" ] && text_type="text";

  if [ "$contents" == "-" ]; then
    contents=$(cat -)
  fi

  local session_file=$(current_session_file)
  printf "### %s\n\n" "$title" >> "$session_file"
  if [ "$text_type" == "text" ]; then
    echo -e "$contents" >> "$session_file"
  else
    echo "\`\`\`$text_type" >> "$session_file"
    echo "$contents" >> "$session_file"
    echo "\`\`\`" >> "$session_file"
  fi
  printf "\n\n" >> "$session_file"
}

print_session_separator() {
  printf "_____________________________" >> "$(current_session_file)"
}