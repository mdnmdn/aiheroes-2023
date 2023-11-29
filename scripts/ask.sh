#!/bin/bash
set -eo pipefail

base_path="$(dirname "$0")/.."
. $base_path/scripts/_commons.sh

function call_gpt() {
    local text="$1"
    local json_friendly_text=$(echo $text | jq --raw-input  --slurp  .)
#"prompt": '"$json_friendly_text"',
    local json_input='{
        "messages": [{
          "role": "user",
          "content": '"$json_friendly_text"'
        }],
        "model": "gpt-3.5-turbo",
        "temperature": 1,
        "max_tokens": 500
    }'

    print_in_session "$text" "openai text input"

    print_session_openai_curl "$json_input"

    local result=$(call_openai "$json_input")

    echo "$result" | jq | print_in_session - "openai curl response"  json

    local text_response="$(echo -n $result  | jq '.choices[0].message.content' -r)"

    echo "$text_response" | print_in_session - "openai text response"

    echo "$text_response"
}

print_session_openai_curl() {
  local json_input=$1

  echo "curl -X POST https://api.openai.com/v1/chat/completions -sS
    -H \"Content-Type: application/json\"
    -H \"Authorization: Bearer xxxx_openai_key\"
    -d '$json_input' " | print_in_session - 'openai curl' sh

}

call_openai() {
    json_input=$1
    result=$(echo "$json_input" | curl -X POST https://api.openai.com/v1/chat/completions -sS \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d @-)

    if [[ "$result" == "{ \"error\":"* ]]; then
        echo $result >&2
        exit 1
    fi

    echo "$result"

}


process_embeddings() {
  local input="$1"
  local body="$2"

  if [[ "$body" == *"@@memory@@"* ]]; then
    local memory="$(redis_search_vector "$input" | jq '.results[].extra_attributes'\
      | jq '"-----------------------------------------------------------------\n" + .text'  -r)"

    body="${body/@@memory@@/$memory}"
  fi
  echo "$body"
}


process_template() {
  local input="$1"
  local template="$2"
  local prompt_path="$base_path/templates/prompt-${template}.txt"
  if [ -n "$template" ] && [ ! -f "$prompt_path" ]; then
    echo "Prompt file $prompt_path not found" >&2
    exit 1
  fi

  local original_input="$input"

  local prompt_body=""
  if [ -n "$prompt_template" ]; then
    prompt_body="$(cat $prompt_path)"
  fi
  #echo $prompt_body
  if [ -n "$prompt_body" ]; then
    input="${prompt_body/@@input@@/$input}"
    #input="$(echo "$prompt_body" | sed "s/@@input@@/$input/g")"

    print_in_session "$original_input" "original prompt"

  fi
  echo $input
}


prompt_template=""
input=""
verbose=false

while [[ $# -gt 0 ]];do
    case "$1" in
      -p|--prompt)
        prompt_template="$2"
        shift
        ;;
      -v|--verbose)
        verbose=true
        ;;
       *)
        input="$input $1"
        ;;
    esac
    shift
done

if [ -z "$input" ]; then
  input="$(cat -)"
fi

body="$(process_template "$input" "$prompt_template")"
body="$(process_embeddings "$input" "$body")"

if $verbose; then
  echo -e "${lightgray}$body" >&2
  echo -e "---------- ${nc}">&2
fi

response="$(call_gpt "$body")"
echo -e "${yellow}$response${nc}"

