#!/bin/bash
set -e 
base_path="$(dirname "$0")/.."
. $base_path/scripts/_commons.sh

input1=''
input2=''

while [[ $# > 0 ]];do
    input=''
    case "$1" in
                -f|--file)
                        input=$(cat "$2")
                        #echo "=> ($2) $input"
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

#echo "input1: $input1"
#echo "input2: $input2"

emb="$(dirname "$0")/embeddings.sh"

embeddings1=($("$emb" -o embeddings "$input1" | sed 's/\,//g'))
embeddings2=($("$emb" -o embeddings "$input2" | sed 's/\,//g'))
#echo "${embeddings1[@]}" 
#echo "${#embeddings1[@]}"
#echo "${#embeddings2[@]}"


#https://weaviate.io/blog/distance-metrics-in-vector-search
function euclidean_distance() {
    embeddings1="$1"
    embeddings2="$2"

    formula="sqrt(0 "
    for i in "${!embeddings1[@]}"; do
        formula="$formula + ((${embeddings1[i]}) - (${embeddings2[i]}))^2"
    done
    formula="$formula)"

    distance=$(echo "sqrt($formula)" | bc -l)

    echo $distance
}


function cosine_distance() {
    embeddings1="$1"
    embeddings2="$2"

    formula_dotproduct="(0"
    formula_norm1="sqrt(0"
    formula_norm2="sqrt(0"
    for i in "${!embeddings1[@]}"; do
        formula_dotproduct="$formula_dotproduct + (${embeddings1[i]}) * (${embeddings2[i]})"
        formula_norm1="$formula_norm1 + (${embeddings1[i]})^2"
        formula_norm2="$formula_norm2 + (${embeddings2[i]})^2"
    done
    formula_dotproduct="$formula_dotproduct)"
    formula_norm1="$formula_norm1)"
    formula_norm2="$formula_norm2)"

    distance=$(echo "$formula_dotproduct / ($formula_norm1 * $formula_norm2)" | bc -l)

    echo $distance
}

#cosine_distance "${embeddings1[@]}" "${embeddings2[@]}"

euclidean_distance=$(euclidean_distance "${embeddings1[@]}" "${embeddings2[@]}")
cosine_distance=$(cosine_distance "${embeddings1[@]}" "${embeddings2[@]}")

echo euclidean_distance: $euclidean_distance
echo cosine_distance: $cosine_distance



