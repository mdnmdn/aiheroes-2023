
cache_path="$base_path/.cache"
data_path="$base_path/.data"


mkdir -p $cache_path $data_path



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