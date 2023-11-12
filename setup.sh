#if  [ ! -d "./venv" ] 
#then
#  python3 -m venv venv
#  . ./venv/bin/activate
#  python3 -m pip install --upgrade pip
#  
#fi
#. ./venv/bin/activate
#pip install -r requirements.txt

if [ -z "$OPENAI_API_KEY" ]; then
    echo "OPENAI_API_KEY is not set"
    return
fi

if [ -z "$(which jq)" ]; then
    echo "Missing jq tool, install from https://jqlang.github.io/jq/"
    return
fi

base_path="$(dirname "$0")/"

export REDIS_PORT=6879

docker compose up -d



alias emb=$base_path/scripts/embeddings.sh
alias embed=$base_path/scripts/embeddings.sh
alias dist=$base_path/scripts/distance.sh
alias distance=$base_path/scripts/distance.sh
alias rd=$base_path/scripts/redis.sh