### Embeddings for 

what could I offer to a vampire guest 


### embed curl

```sh
curl -X POST https://api.openai.com/v1/embeddings -sS
    -H "Content-Type: application/json"
    -H "Authorization: Bearer xxxx_openai_key"
    -d '{
        "input": "what could I offer to a vampire guest\n",
        "model": "text-embedding-ada-002"
    }' 
```


### embeddings curl response

```json
{
  "object": "list",
  "data": [
    {
      "object": "embedding",
      "index": 0,
      "embedding": [
        0.01577543,
        -0.028280683,
        0.017740339,
        -0.0045192954,
        4.747804e-05,
        0.030849103,
        -0.019326303,
        -0.02141753,
        "..."
      ]
    }
  ],
  "model": "text-embedding-ada-002-v2",
  "usage": {
    "prompt_tokens": 9,
    "total_tokens": 9
  }
}
```


### Embeddings for 

basilisk biscuits 


### embed curl

```sh
curl -X POST https://api.openai.com/v1/embeddings -sS
    -H "Content-Type: application/json"
    -H "Authorization: Bearer xxxx_openai_key"
    -d '{
        "input": "basilisk biscuits\n",
        "model": "text-embedding-ada-002"
    }' 
```


### embeddings curl response

```json
{
  "object": "list",
  "data": [
    {
      "object": "embedding",
      "index": 0,
      "embedding": [
        -0.022405274,
        0.0043938267,
        0.00060960295,
        0.0020995932,
        0.022794554,
        0.0047398545,
        -0.01907476,
        -0.028230067,
        "..."
      ]
    }
  ],
  "model": "text-embedding-ada-002-v2",
  "usage": {
    "prompt_tokens": 5,
    "total_tokens": 5
  }
}
```


