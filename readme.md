Monster menu - Demo AI Heroes 2023
-----------------------------------

Source of the demo of the talk _Integrate LLM in your applications 101_ 
of [AI Heroes 2023](https://aiheroes.it/2023/agenda/) .

The demo is a simple bash application integrated with OpenAI
in order to build a chief assistant bot for a fictional restaurant.

This demo is tested on MacOS and *should* work on any posix system. 

## Requirements
* A valid OpenAI API key in the environment variable `OPENAI_API_KEY`
* `jq` installed
* `curl` installed
* `docker` installed to run redis
* `gcc` installed in order to build the tool to convert the embeddings in binary/utf8 format

## Structure

### Project folders

* assets: intermediate files used by the demo
* data: demo data as recipes
* scripts: bash scripts
* templates: templates from the prompts

### Runtime folders

* .cache: cache of embeddings
* .data: docker volume for redis and other runtime data
* sessions: markdown logs of the operations

### Scripts:

`session`: manages the current log session (in the ./session folder)

```bash
# show the current session id
session

# start a new session
session new
```

`ask`: main script to interact with the openai api

Samples:

```bash
# simple prompt with no template
ask what could I offer to a vampire guest

# prompt using the template 'templates/prompts-recipe.txt'
ask -p recipes what could I offer to a vampire guest
```

`embeddings`: (alias `emb`, `embed`) generates an embedding for a given text

```bash
# simple embedding with full vector output
emb what could I offer to a vampire guest

# token count
emb -t what could I offer to a vampire guest

# embedding summary (token + first 10 values of vector)
emb -s what could I offer to a vampire guest

# embedding json response 
emb -j what could I offer to a vampire guest
```

`rd`: redis interface

```bash
# search via semantic search
rd search vampire

# add vector record to redis
rd embed what could I offer to a vampire guest

# scan a folder and add all the files contents with vector embeddings to redis 
rd embed-folder ./data/recipes

# create a vector search index
rd create-index 

# empty the redis database
rd clear-all  
```


## Usage

Before start you should run the `setup` command in order to initialize all the tools and set 
the alias.

```bash
. ./setup.sh 
```

* startups the redis container
* builds the tool to convert the embeddings in binary/utf8 format (float-to-blob)
* checks the OpenAI API key




