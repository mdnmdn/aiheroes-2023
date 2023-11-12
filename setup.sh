#set -eo pipefail

if [ -z "$OPENAI_API_KEY" ]; then
    echo "OPENAI_API_KEY is not set"
    return
fi

if [ -z "$(which jq)" ]; then
    echo "Missing jq tool, install from https://jqlang.github.io/jq/"
    return
fi

if [ ! -f "./scripts/floats-to-blob" ]; then
    echo "Compiling floats-to-blob"
    gcc -o ./scripts/floats-to-blob ./assets/floats-to-blob.c
fi

base_path="$(realpath "$(dirname "$0")")"

export REDIS_PORT=6879

docker compose up -d


all_alias=(
emb=embeddings.sh
mm-emb=embeddings.sh
embed=embeddings.sh
dist=distance.sh
mm-dist=distance.sh
distance=distance.sh
rd=redis.sh
mm-rd=redis.sh
)

echo "\nAlias:"
for i in "${all_alias[@]}" ; do
    alias_name=$(echo $i | cut -d'=' -f1)
    alias_cmd=$(echo $i | cut -d'=' -f2)
    echo ${alias_name} = ${alias_cmd}
    alias $alias_name="$base_path/scripts/$alias_cmd"
done


#alias emb=/scripts/embeddings.sh
#alias mm-emb=$base_path/scripts/embeddings.sh
#alias embed=$base_path/scripts/embeddings.sh
#alias dist=$base_path/scripts/distance.sh
#alias mm-dist=$base_path/scripts/distance.sh
#alias distance=$base_path/scripts/distance.sh
#alias rd=$base_path/scripts/redis.sh
#alias red=$base_path/scripts/redis.sh
#alias mm-rd=$base_path/scripts/redis.sh
