#!/bin/bash
set -e 
base_path="$(dirname "$0")/../"
. $base_path/scripts/_commons.sh

input1=''
input2=''

while [[ $# > 0 ]];do
    input=''
    case "$1" in
                -f|--file)
                        input=$(cat "$2")
                        echo "=> ($2) $input"
                        shift
                        ;;
              
                *) 
                    input="$1"
                    ;;
                    
        esac
        shift
    if [[ -z "$input1" && ! -z "$input" ]]; then input1="$input"
    elif [[ -z "$input2" && ! -z "$input" ]]; then input2="$input"
    fi
done

if [[ -z "$input1" || -z "$input2" ]]; then
    echo "missing input"
    exit 1
fi

echo "input1: $input1"
echo "input2: $input2"

exit


