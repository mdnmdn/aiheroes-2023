#!/bin/bash
set -e

base_path="$(dirname "$0")/.."
. $base_path/scripts/_commons.sh

operation="$1"
content1=""
shift

case "$operation" in
   set|embed)
    content1=$(get_content "$@")
    redis_embed_hash "$content1" ""
    ;;
   embed-folder)
    content1=$(get_content "$@")
    redis_embed_folder "$content1"
    ;;
   get)
    content1=$(get_content "$@")
    redis_get_json "$content1"
    ;;
   search)
    content1=$(get_content "$@")
    redis_search_vector "$content1" | jq '.results[].extra_attributes' | jq '.score + "   " + .title'  -r
    ;;
    search-json)
    content1=$(get_content "$@")
    redis_search_vector "$content1" | jq '.results[].extra_attributes'
    ;;
    search-text-full)
    content1=$(get_content "$@")
    redis_search_vector "$content1" | jq '.results[].extra_attributes'\
      | jq '"-----------------------------------------------------------------\n" + .text'  -r
    ;;

   create-index)
    redis_create_index
    ;;
   check-index)
    redis_check_index
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