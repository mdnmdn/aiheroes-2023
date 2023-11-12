
cache_path="$base_path/.cache"


mkdir -p $cache_path

function cache_key() {
    prefix="$1"
    value_key="$2"

    key="$prefix-$(echo $value_key | md5sum | cut -d' ' -f1)"

    #[ ! -z "$3" ] && key="$key$3"

    echo "$key"
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
  echo "$1" | jq --raw-input  --slurp  .
}

function get_content() {
  content=""
  if [[ "||-f||--file||" == *"||$1||"* ]]; then content=$(cat $2)
  elif [[ "||-||" == *"||$1||"* ]]; then content=$(cat -)
  else content="$1"
  fi

  echo $content
}