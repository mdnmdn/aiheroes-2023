### Embeddings for 

vampire


### embed curl

```sh
curl -X POST https://api.openai.com/v1/embeddings -sS
    -H "Content-Type: application/json"
    -H "Authorization: Bearer xxxx_openai_key"
    -d '{
        "input": "vampire\n",
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
        -0.020285347,
        -0.030131293,
        0.010560789,
        -5.1500494e-05,
        -0.014984721,
        0.012105119,
        -0.01988072,
        -0.022214074,
        "..."
      ]
    }
  ],
  "model": "text-embedding-ada-002-v2",
  "usage": {
    "prompt_tokens": 3,
    "total_tokens": 3
  }
}
```


### redis vector search

```redis
FT.SEARCH idx:omi "*=>[KNN 10 @embeddings $query_vector as score]" RETURN 5 score title recipe_name id text SORTBY score DIALECT 2 "PARAMS" "2" "query_vector" "\x75\x2d\xa6\xbc\xe7\xd5\xf6\xbc\x29\x07\x2d\x3c\x3c\x02\x58\xb8\x7a\x82\x75\xbc\x8d\x54\x46\x3c\xe4\xdc\xa2\xbc\x4a\xfa\xb5\xbc\x47\x2a\xbc\xbc\xee\x1c\x0a\xbd\x81\x2c\xe2\x3b\x7b\x7b\x97\x3c\x53\x41\xfb\x38\x3a\x7d\x02\xbd\x1b\x0f\x4f\x3c\xe7\x20\x1b\xbc\x15\x98\x03\x3d\x7a\xcd\x99\xbc\xe8\x49\xf5\x3c\x2d\xbf\x23\xbc\x5c\x1e\x09\xbc\x25\x15\xb7\x3c\x7c\x52\xef\xbb\xfb\x55\x45\xbc\xc8\x78\x68\xbc\xa2\x30\x10\x3c\x54\x29\xf8\x3b\x80\xc9\x08\xbd\x06\xb8\x28\x3c\xa5\x3a\x09\xbc\xee\x90\x08\x3d\x8e\x3c\xc3\xbc\x15\x0c\x02\xbc\x25\xdb\x37\xbc\x52\x18\xa1\xbc\x56\x0a\x97\xbc\xc9\xab\x89\xbc\x59\x14\x90\xbc\x0c\x40\x19\x3c\xed\x6e\x8c\x3c\xa7\x0a\x83\x3b\xc7\x04\xea\x3b\x5f\xdd\xdd\xbb\x5e\xee\x82\xbc\x4b\xe2\xb2\xbc\xe9\xf0\x14\xbb\xfa\x1b\x46\xbb\xbf\x31\xa3\xbc\x34\xe4\x6c\xbc\xe1\x98\x2a\x3c\xa8\x7e\x01\x3d\x30\x03\x1c\x3c\x96\x5a\xae\xbb\xdf\x02\x30\xbc\x2d\xe8\x7d\xbc\x64\x7d\xd1\xbb\xc3\x5d\x18\x3c\x2e\xa7\x20\xbc\xe0\x5e\x2b\xbb\x7f\x96\x67\xbc\x77\xb2\x7b\x39\x07\x2c\xa7\xbb\xcc\x30\xdf\xbc\x3b\x1a\xdb\xba\x6a\x05\x42\x3b\x9c\xe2\x1e\x3a\x35\x51\x8d\xbc\xa7\xd0\x03\x3d\xa4\x8c\x8b\x3b\xa2\x1f\xeb\xba\x4f\x0e\x28\x3d\xf1\x60\x82\x3c\x55\xe8\x9a\x3b\xd4\x88\x49\x3c\xc3\x64\x76\x3c\x09\x77\xfd\xbc\x50\xbc\x25\xbb\xf0\xec\x03\x3b\x76\xca\xfe\xbb\x79\x0e\x77\xbc\xa0\x60\x16\x3d\xd8\x7a\xbf\xbc\xec\xe9\x68\xbc\xea\x64\x93\x3a\xe7\x5a\x1a\x3b\xe3\xf4\x25\x3b\x41\xa2\x4b\xbc\x79\x93\x9a\x39\x06\x7e\x29\xbc\x3b\x2b\x00\xbc\x1f\x01\xc5\xbb\xa1\x48\x93\xbb\xa7\xbf\x5e\x38\xc3\x23\x19\x3d\xe3\x68\x24\xbc\xd2\xf2\xce\x3c\x57\x6d\x70\x3b\x0d\x28\x16\x3d\x52\x52\xa0\xbb\xe7\xd5\x76\xbc\x26\xfd\x33\x3c\x99\x9e\x26\x3c\x35\x58\xeb\xbc\xdf\xb0\xad\xbc\xd4\x4e\x4a\xbc\xe0\x24\xac\xbb\x9c\x23\xfc\xbb\xd7\x92\xc2\xbb\x57\xf2\x13\x3d\xa2\x30\x10\xbc\xc9\xec\xe6\xbc\x16\x46\x01\x3d\xc3\x5d\x98\x3c\x6f\x19\x34\xbd\x52\xde\x21\x3c\x9a\x12\x25\xbc\xbc\xb3\xab\x3b\xbd\xd5\xa7\xbb\xa3\x93\xe9\xba\xd0\x5c\xd4\xbb\x83\x88\x5d\x3c\xef\xf3\xe1\x3c\xf9\xf9\xc9\x3c\xf5\x41\xd3\xbb\x37\x73\x09\x3d\xea\x19\xef\x3c\xc4\x97\x97\xbc\x71\x75\xaf\xbb\x9e\x7f\xf7\xbb\x74\x7f\xa8\xbc\x11\xa6\x0d\x3d\xb1\xc5\xc6\x3b\x8f\x24\xc0\x3c\x30\x03\x1c\xbc\x73\x0b\xaa\xbc\xcd\x29\x81\x3c\x6c\x9b\xbc\xbc\x19\x3f\x55\xbc\x8c\x1a\x47\xbc\x3c\x02\xd8\xbc\x37\x39\x8a\x3c\xc8\x89\x0d\x3d\x4f\xd4\xa8\xbc\xbf\xf7\xa3\x3b\xb6\xd9\xb8\x3c\x6f\xdf\xb4\x3c\x06\xb8\xa8\x3c\x8d\x54\x46\x3a\x46\x08\x40\x3c\xf7\x63\x4f\xbc\x3a\xb7\x81\x3c\x78\xe5\x9c\xbc\x06\xb8\x28\x3d\xef\xb9\xe2\xbc\x30\xb8\x77\x3c\x8e\x76\xc2\x3b\x88\xee\xd1\xbb\x6b\x27\xbe\x3b\xb6\x2b\x3b\xbc\x36\x40\x68\xba\xcd\x29\x01\xbd\x16\x80\x80\xbc\xa5\xef\x64\x3c\x8b\xf8\x4a\xbc\x02\x00\x32\xbc\xad\xd3\xd0\x3c\x40\xf4\x4d\x3b\xdf\x76\x2e\x3c\x5e\xee\x82\x3a\xdf\xb0\x2d\xbc\x3e\xea\xd4\xbb\x58\x66\x12\x3d\x4e\x26\x2b\xbd\xc7\x04\xea\x3c\x5a\xc2\x8d\xbc\xba\x91\x2f\x3d\x5a\x36\x0c\x3c\x01\x18\xb5\x3a\xf0\xb2\x84\xbc\x79\x93\x1a\x3b\xd8\x7a\xbf\xbc\x29\xcd\x2d\x3a\xe8\x08\x18\x3d\xca\x59\x07\x3d\x31\xeb\x18\xbc\xf5\x7b\x52\x3c\x3b\x1a\x5b\x3c\x5a\x3d\x6a\xbc\xe1\x0c\xa9\x3c\x9f\xb2\x98\xbb\x32\x14\x73\x3c\x8d\x02\xc4\x3c\xee\xd1\xe5\x3c\xc5\xb9\x93\xbc\x98\xb6\x29\xbf\x7d\x3a\x6c\xbc\x30\xb8\xf7\xbc\x63\xcf\xd3\xbb\xa3\xa4\x8e\x3c\x57\xf9\x71\x3c\x04\x96\x2c\x3d\xea\x9e\x92\xbc\x09\xeb\x7b\xbb\xde\x54\x32\xbc\x0b\x1e\x9d\x3a\x5c\x99\xe5\x3b\xe1\x0c\x29\xbc\xaa\x8f\x58\xbc\x8d\x54\xc6\xbc\x3b\x54\x5a\xbc\x2b\x9d\x27\xbc\xbd\x9b\x28\xbb\x97\x08\x2c\xba\xa5\x3a\x09\xbb\x1b\x9b\xd0\x3b\x3a\xa6\x5c\x3c\xa8\x6d\x5c\xbc\x33\xbb\x92\x3b\x79\x9a\x78\x3c\x71\x3b\xb0\x3c\x6e\x31\xb7\x3c\x49\x86\x37\x3c\x8a\x4a\x4d\xbc\xc9\x60\x65\x3c\x59\xc9\xeb\xbc\x5c\x1e\x09\x3d\x56\x0a\x17\xbb\x6d\x83\x39\xba\xa3\xa4\x0e\x3d\xc9\xec\x66\xbc\x8b\xf8\x4a\x3c\xbc\x27\xaa\x3c\xa4\x7b\x66\xbc\xe0\x24\x2c\x3c\xaf\x2f\x4c\xbc\x84\x36\x5b\xbc\x7d\x4b\x11\xbc\x9f\xdb\x72\x3c\xa6\x11\x61\xbc\x4b\xe2\x32\x3b\x0c\x7a\x18\x3c\x59\x4e\x8f\x39\x35\x51\x8d\x3b\x95\xac\x30\xbb\xe9\x31\x72\x3c\x8e\xb0\x41\x3c\x4e\xb2\x2c\x3b\x37\x28\xe5\x39\x13\x02\x89\x3c\x00\xa4\x36\x3b\xd8\x7a\xbf\x3c\x9a\x3b\xff\xbc\x18\x57\xd8\x3b\xf0\xa1\xdf\x3b\xff\x81\x3a\xba\x77\xb2\x7b\xbb\x9b\xc0\xa2\x3c\xdb\xbe\x37\xbc\x1b\xd5\x4f\x3c\x11\xcf\x67\x3c\x50\xbc\x25\xbc\xa9\xe1\x5a\x3c\x95\x38\x32\x3b\x7a\xf6\xf3\xbc\xa2\x6a\x8f\x3c\xf1\x89\xdc\x3b\xd9\xb4\xbe\x3b\x50\xbc\x25\x3a\xba\x57\x30\x3c\xd3\xda\xcb\x3b\x97\x08\x2c\x3d\x5c\x99\xe5\x3b\xba\xcb\xae\x3c\x08\x88\xa2\xbc\x75\x2d\xa6\x3a\x25\x89\x35\xbc\x58\xa0\x91\xbc\x32\x88\x71\x3c\xbf\x31\x23\x3d\xc2\xaf\x9a\xbb\xc1\x08\xfb\xbc\x90\x98\xbe\x3b\x77\xc3\xa0\x3b\x11\xcf\x67\xbb\xfa\x1b\xc6\xba\xea\x2a\x94\x3c\x00\xa4\xb6\xbc\xb3\x5b\xc1\xbc\xe8\x49\xf5\xbc\xdc\x6c\xb5\x3c\x0c\x06\x9a\xbc\xa8\x44\x02\xbc\x15\x13\xe0\xbb\x74\x45\xa9\xbc\xaa\x55\x59\xb8\x64\xb7\x50\xbb\x55\x9d\x76\xbb\x31\x5f\x17\xbc\x91\x46\x3c\x3c\x0c\x06\x9a\x3c\xc4\x97\x97\xbb\xfc\xb1\x40\xb8\xa2\x6a\x0f\x3d\xa4\x7b\x66\xbd\xd9\xb4\x3e\x3c\x99\xd8\xa5\xbc\x2c\x4b\xa5\xbb\xc0\xdf\xa0\x3b\x54\xae\x1b\xbc\x3d\x3c\xd7\xbc\xe6\x72\x9d\x3c\xf9\x33\xc9\x3b\x19\xb3\xd3\x3c\xeb\x12\x11\xbd\xa8\x6d\xdc\x3b\xd4\x4e\xca\x3c\x31\xa0\x74\x3c\x9f\xb2\x18\xbc\xd3\xa0\xcc\x3a\x31\xa0\x74\x3b\xe5\xfe\x9e\xbc\x4c\x90\xb0\xbc\xa8\x44\x82\xbc\xb1\xc5\xc6\xbc\x88\x28\x51\x3c\xbe\x49\x26\xbb\x47\xf0\xbc\x3c\xdb\xbe\xb7\xbc\x2d\xf9\x22\x3c\xd7\x1e\xc4\x3b\x15\x4d\xdf\x3c\xc2\x3b\x1c\xbb\x77\x3e\xfd\x3b\x4f\x9a\x29\x3b\xf9\xf9\xc9\xbb\xec\x34\x8d\xba\x51\x6a\xa3\xbc\xbe\x83\xa5\x3c\xd7\x58\xc3\xbb\xf1\x60\x82\xbc\xd5\x36\x47\x3c\x15\x13\xe0\xbc\x21\x5d\xc0\xbc\x2f\x55\x1e\x3c\x65\x9f\xcd\x3b\x77\x3e\xfd\xbb\x9c\x23\xfc\xbc\x97\x42\xab\x3c\xdf\x02\x30\x3c\x33\x70\x6e\xbc\x5c\x99\x65\xbc\x58\x55\xed\xbb\x19\xb3\xd3\xbb\xc3\xd8\x74\x3c\xca\x93\x06\x3c\xd1\x0a\xd2\x3c\x9b\xaf\x7d\xbc\x83\x99\x82\x3a\x5d\x40\x05\x3c\xc8\x78\x68\xbc\x82\x66\xe1\xbb\x9e\x78\x19\x3b\xb7\x13\x38\xbb\xa2\xf6\x10\xbd\x0c\xbb\xf5\x3c\x4d\x04\x2f\x3c\x41\x68\xcc\xbb\x8b\xf8\x4a\xbb\x8a\x4a\x4d\xbc\x21\x5d\xc0\x3b\x3b\x2b\x00\x3c\xdf\x3c\x2f\xbb\xa6\x11\xe1\xbc\x35\x51\x0d\xbb\x15\x4d\xdf\x3a\x1c\x49\x4e\xbc\x14\xea\x85\xbc\x57\xb8\x94\x3c\xba\xcb\xae\x3c\x9e\x7f\xf7\x3b\xeb\x86\x8f\x3c\x1b\x0f\x4f\x3c\xdf\xb0\x2d\x3c\xec\x75\x6a\x3c\xed\xe2\x0a\xbc\x24\xa1\xb8\x3c\x11\x5b\xe9\xbc\xe2\x46\xa8\x3b\x17\xe3\x59\xb9\x33\xbb\x92\xbc\xa7\x4b\x60\x3c\xd1\x44\xd1\x3c\x6c\x61\xbd\xba\x3f\xd2\xd1\x3c\xce\xc6\xd9\x3c\xdf\xb0\xad\xbc\xfc\x3d\xc2\x3c\x5a\x88\x0e\xbc\x0a\xaa\x9e\x3c\x3e\xea\x54\xbd\x9a\x4c\xa4\xbb\xf1\x60\x02\xbc\xf2\xc3\xdb\x3c\x48\x9e\xba\x3c\x9c\x97\x7a\x3c\xdc\x6c\x35\xbb\x16\x80\x00\xbc\xde\xc8\x30\xbb\xeb\xd8\x11\x3d\xf1\x15\xde\x3c\xfc\x77\x41\x3c\x7d\x11\x92\x3c\xe9\x7c\x16\xbb\x7f\xe1\x8b\xbc\x74\xf3\xa6\x3b\x95\x72\xb1\xbc\x87\x06\xd5\x3b\x55\xe8\x1a\xbb\xc1\x7c\x79\x3c\xe9\x31\x72\x3c\x83\x14\x5f\x3b\x5c\x99\x65\x3c\x13\x02\x09\x3a\x92\x68\xb8\xbc\x7e\xae\x6a\xbc\x81\xf2\xe2\x3b\x54\x74\x1c\xbb\xf1\x60\x82\xb9\xfd\xeb\x3f\x3c\x79\x1f\x1c\x3b\xa1\xbc\x91\x3c\x56\x85\xf3\xbc\xdd\xe0\x33\x39\xa2\x30\x90\x3c\x5e\x7a\x04\xbc\x9f\xec\x17\x3d\x5a\x36\x8c\x3c\xb3\x95\x40\xbc\x84\xfc\x5b\x3c\x03\x3a\x31\x3c\x56\x0a\x97\x3c\xe6\x38\x1e\xbc\x35\x58\xeb\xbc\x76\xdb\xa3\x3b\x13\x76\x87\xbc\xbf\x31\xa3\x3c\x3d\x76\x56\xbb\xc3\xd8\x74\x3c\x9d\x1c\x1e\xbc\xed\x5d\xe7\xbc\x75\xa1\x24\x3b\xa8\xb8\x80\xbb\x96\x94\x2d\x3c\x2a\x29\x29\x3c\x6f\x19\xb4\x3c\xc4\x4c\xf3\x3c\x49\x4c\x38\xbc\x5e\xee\x82\xbc\x2d\x74\xff\x3b\x9b\xfa\x21\x3c\xbd\x9b\x28\x3c\x69\xcb\x42\xbc\x16\x46\x01\x3b\xed\xe2\x8a\xba\x9f\x26\x97\xbc\x0a\x5f\x7a\x39\x0e\x8b\x6f\x3c\xa8\x6d\xdc\xb9\x90\x0c\xbd\x3c\x59\x4e\x8f\xbb\xea\x9e\x12\xbc\x54\x29\x78\x3c\x0a\x70\x9f\x3c\x2d\x6d\xa1\x3b\x59\xc9\x6b\xbc\x9d\x56\x1d\xbd\xc0\xdf\x20\x3c\xe1\x0c\xa9\x3c\xc1\x7c\xf9\x3b\xf8\x85\xcb\xbc\x3c\x02\x58\xbc\x48\x9e\x3a\xbc\x10\x73\xec\xb9\xc3\x23\x99\x3c\xd3\x66\xcd\x3c\x73\x0b\xaa\xba\xa6\x22\x86\x3c\x4e\xec\xab\xbc\x32\x14\xf3\xbc\xa8\x33\x5d\x3c\x4c\x90\x30\x3d\x09\xfc\x20\xbd\x7a\x41\x98\x3a\xc7\x90\xeb\x3b\xb1\xc5\x46\xbc\xe1\x98\x2a\x3a\xae\xbb\xcd\xbc\x61\xe7\xd6\x3a\x2d\x6d\xa1\x3c\x67\xc1\xc9\x3b\x10\x73\x6c\xbb\xf3\xab\xd8\xbb\x2e\x1b\x9f\x3c\x2f\x44\x79\x3c\x02\x8c\xb3\xbc\x2d\x33\x22\xbc\x36\xb4\x66\xbc\x50\x48\x27\xbc\x03\x3a\xb1\x3a\x55\x11\xf5\x3c\x3c\x8e\xd9\xbb\x84\x36\x5b\xbc\x20\x3b\xc4\x3c\xcd\x18\x5c\xbb\x04\x96\x2c\x3b\xc4\x97\x17\xbc\x81\xf2\x62\xbc\x5b\xe4\x89\xbc\xe8\x08\x98\x3d\x04\x96\xac\x3c\x77\xc3\xa0\xba\xcc\xb5\x82\x3c\xee\x45\xe4\xbb\xc7\xdb\x8f\xbc\x24\x67\xb9\xbc\x6c\x0f\x3b\x3b\xb3\x5b\xc1\x3c\x6d\x49\x3a\x3b\x33\x47\x14\x3d\x12\x8e\x8a\x3b\x95\xac\x30\xb9\x61\xad\xd7\x3b\x93\x16\xb6\x3c\x2f\xc9\x1c\x3c\xc2\xaf\x9a\xbc\xf0\x26\x03\xbc\xf1\x89\xdc\xba\xc1\x7c\x79\xbc\x52\x59\x7e\x3b\x53\xc6\x1e\xbd\xd5\x36\xc7\x3c\x10\x73\x6c\x3c\x5d\xcc\x86\x3c\x38\x5b\x86\xbc\xc2\xaf\x9a\x3c\xbd\xd5\xa7\xbb\x4a\x6e\x34\xbc\xc9\x60\xe5\xbb\x5e\xa3\xde\xbc\x77\xc3\xa0\x3a\xc4\x97\x17\xbc\x55\x22\x1a\x3a\x6a\x3f\x41\xbb\x7e\xae\x6a\xbc\x6a\x79\xc0\x3b\xa6\x63\xe3\x3b\x93\x50\x35\x3c\xbe\x83\xa5\xbc\xa7\xd0\x03\x3d\x94\xc4\xb3\x3c\x4a\xc0\x36\x3c\x79\x93\x1a\xbc\x21\x23\xc1\x3c\xb2\xe7\xc2\xbc\x65\x65\xce\x3b\x31\xb1\x99\x3b\x94\x8a\x34\x3c\xbf\x31\x23\xbc\x43\xc4\x47\x3d\xb0\x17\x49\xba\x0c\xcc\x1a\xbd\x34\xf5\x91\x3b\xb6\xd9\x38\xbc\xa4\x07\xe8\x3c\xf2\x0e\x80\x3b\xbb\x3f\x2d\x3c\x5e\xb4\x83\xbc\x75\x2d\xa6\x3c\x80\x55\x8a\xbc\x25\xdb\x37\xbd\xfb\x8f\x44\x3c\x81\x3d\x87\xbc\xa2\xab\xec\x3a\x5a\x36\x0c\xbd\xa3\xa4\x8e\x3b\x46\xce\xc0\xbc\x10\x73\xec\xbc\x38\xe7\x87\xbc\x9f\x26\x17\x3b\xd7\x1e\x44\xbc\x30\x77\x1a\xbb\xb0\xdd\xc9\xbb\x83\x14\xdf\xbb\x31\x25\x18\xbc\x5a\x3d\xea\xbb\x0c\xbb\xf5\xbc\x29\x41\x2c\x3c\x44\x72\xc5\xbb\xde\x8e\xb1\xbc\x19\xb3\xd3\xbb\x5b\x25\x67\xbb\xf8\xbf\xca\xbc\xa6\x63\xe3\xbc\x66\x87\x4a\xbc\x25\x4f\xb6\x3b\xa6\x11\x61\xbc\xc0\x94\x7c\x3c\xe7\xe6\x9b\xbc\x1b\x9b\xd0\x3b\xc9\x60\xe5\x3c\xc7\x15\x0f\x3b\x79\x1f\x9c\xbc\xb2\xe7\x42\xbb\x36\xc5\x8b\x3b\x13\x3c\x88\x3c\xa6\x22\x06\xba\xaf\x2f\x4c\xbc\xeb\xd8\x91\x3c\xca\xe5\x08\x3c\xf1\x9a\x01\xbd\xc9\xec\x66\xba\x7e\xae\x6a\xbb\x61\xe7\xd6\x3b\xe4\xdc\xa2\xbb\x72\x5d\xac\x3c\x83\x5f\x03\x3d\x3a\x7d\x82\xbc\xda\xd6\xba\xba\x2a\x29\xa9\x3c\x34\xf5\x11\xbb\x48\xd8\x39\x3c\xe3\xa2\x23\x3b\x82\xeb\x04\x3d\x2f\x8f\x9d\x3c\x79\x9a\x78\xbb\x09\x36\xa0\x3c\x79\x1f\x1c\x3c\x55\xe8\x1a\xbc\x83\xd3\x81\xbc\x4c\x90\xb0\x39\xa7\xbf\xde\x3c\x34\x2f\x11\x3d\x33\x81\x93\xbc\xb8\xfb\xb4\x3c\x15\xd2\x82\x3c\x88\x28\xd1\xbc\x1b\x9b\x50\x3c\xf8\x85\xcb\x3a\x55\x11\xf5\xbb\x85\xe4\x58\x3c\xec\xe9\xe8\x3b\x29\x07\x2d\xbc\x44\xe6\x43\xbd\x2d\xf9\x22\xbc\xb0\x51\xc8\x3a\xe5\xfe\x1e\x3b\xc3\x64\xf6\xbb\x26\xfd\x33\xbc\xed\x5d\xe7\xbc\x56\x0a\x17\xbc\x6f\x19\xb4\x3b\x72\xe9\xad\xbb\xca\x59\x87\xba\xa4\xc6\x0a\xbd\x66\x87\xca\x3b\xb7\x4d\xb7\x3a\x7c\x63\x94\x3b\x32\x99\x96\x3b\x0a\x5f\xfa\xbc\x99\xd8\xa5\xbc\x55\x22\x1a\xbc\x20\x75\x43\xba\x76\xdb\x23\x3c\x3a\x6c\x5d\xbd\xe5\xfe\x1e\xbd\x6d\x83\x39\xbc\x42\xdc\x4a\x3c\x3f\xd2\xd1\x3a\x4c\x90\x30\x3c\x3e\x98\x52\xba\xca\xe5\x08\xba\x1d\xf7\x4b\x3b\xbf\xf7\x23\xbc\x1d\x31\xcb\x3c\x84\x47\x00\xbc\x9f\x26\x17\x3c\x96\x5a\x2e\xbd\x7a\x41\x98\x3c\x02\x00\x32\x3c\x5a\x3d\x6a\x3c\x9f\xb2\x98\x3c\x47\xf0\xbc\x3b\xd1\xd0\xd2\x3b\x9c\x6e\x20\x3d\x0b\x1e\x9d\xb9\xc6\xf3\x12\x3c\x23\xb9\xbb\xbc\xea\x2a\x14\xbd\x8d\x8e\xc5\xbb\xe8\x49\xf5\xbb\xe0\x5e\x2b\xbc\x4e\x26\x2b\x3c\xc5\xb9\x93\x3b\x88\xb4\xd2\xbc\x2c\x85\xa4\x3c\xc6\xa8\x6e\xbc\xb0\xdd\x49\x3c\x7a\xcd\x99\xbc\x37\x73\x89\x3c\x93\xdc\xb6\xbb\x7c\x52\x6f\x3c\x7f\xa7\x8c\xbc\x5a\xb1\x68\x3c\xcd\xde\xdc\xbb\x66\x13\x4c\x3c\x39\x09\x04\x3c\x88\xb4\xd2\xbb\xa1\xbc\x91\x3c\xe3\xa2\xa3\x3c\x8c\xa6\xc8\xbb\xec\xe9\xe8\x3a\xa7\xd0\x83\xbc\x59\x4e\x8f\x3c\x4d\x78\xad\x3c\x6b\xed\x3e\x3c\x5a\xc2\x0d\xbd\xce\x8c\xda\x3c\x3d\x76\xd6\xbc\x78\x37\x1f\xbc\x81\x7e\x64\xbc\x7a\x07\x19\xbd\x3b\x1a\xdb\xbc\x00\xf6\x38\xbc\x13\x76\x07\xbc\x29\x41\x2c\xbd\xbd\x61\x29\x3c\xba\x91\x2f\xbc\xa3\x18\x0d\xbc\x7a\x41\x98\x3c\xf5\x07\x54\xbc\x4a\x34\xb5\x3c\x57\xb8\x94\xbb\x89\x9c\x4f\x3d\xf8\x4b\xcc\x3c\x39\xcf\x84\xbb\x37\xad\x88\xbc\x66\x87\xca\x3b\xe8\xbd\x73\xbb\xce\x8c\xda\xba\xd3\xa0\x4c\xbc\xa2\xf6\x10\x3c\xeb\x12\x91\x3b\xc6\x1c\x6d\xbc\x35\x17\x0e\x3d\xca\xd4\xe3\x3b\x2b\x63\xa8\xbc\xae\x47\xcf\xbc\xf8\x4b\xcc\x3b\x99\x64\xa7\xba\x40\xba\x4e\x3c\x3a\xf8\xde\xbb\x78\x71\x9e\xbc\x73\xd1\xaa\xbc\x74\xf3\x26\x3c\x2e\xa7\x20\xbc\xa2\x6a\x8f\xbc\x0e\x62\x95\xbb\x67\xfb\xc8\xbc\xda\xd6\xba\xbb\xa7\x96\x04\x3c\xd6\x70\xc6\xbb\x02\xc6\xb2\x3a\xc7\x4f\x0e\x3c\xc6\xf3\x12\xbb\x8e\x76\xc2\x3b\xb9\xe3\xb1\xbc\x6a\x3f\x41\xbc\x48\xd8\x39\x3c\x99\xd8\xa5\xbc\x72\x5d\xac\x3c\xa7\xd0\x03\x3a\x5f\x17\xdd\x37\x5d\x40\x05\x3c\x7b\xef\x15\xbb\x66\x13\x4c\x3c\x5e\x7a\x84\x3c\xff\x81\xba\xbc\x04\xe8\xae\x3c\xf2\xc3\x5b\xbc\x55\x22\x1a\x3c\x96\x94\x2d\xbc\x5d\xcc\x06\x3c\x81\x3d\x87\xba\xee\xd1\xe5\x3c\xc3\xd8\x74\xbc\xf0\xec\x83\x3b\xa9\xe1\x5a\x3b\x40\xf4\xcd\xbc\x6d\xbd\x38\x3c\x77\x3e\xfd\x3b\x52\xde\xa1\xbc\x5c\x0d\x64\x3b\xc6\x67\x91\xbc\x98\x7c\x2a\xbc\x75\xa1\x24\xbc\x9d\x90\x9c\x3c\x99\x2a\xa8\x3b\x82\xeb\x84\xbc\xe8\x49\x75\xbb\xe8\xbd\x73\xbc\x14\x5e\x04\xbb\xcd\x63\x00\xbc\xda\x9c\xbb\x3b\xbc\xed\x2a\x3b\x6c\xd5\xbb\xbb\xce\x8c\xda\x3c\x06\xb8\xa8\xbc\x4e\x26\x2b\x3c\xf6\x29\x50\x3a\xc6\x67\x11\x3c\x15\x98\x83\xbc\xd4\x4e\x4a\x3c\xde\x8e\x31\x3c\x7a\x41\x18\xbd\x87\x7a\x53\x3c\x0e\x17\xf1\xbb\xe7\x94\x19\xbb\xc8\x78\x68\xbc\xeb\x86\x0f\xbc\xf6\x29\x50\x3c\x78\x26\x7a\x3b\x27\x71\xb2\xbb\x58\x2c\x13\x3d\x81\xf2\x62\xbb\x13\x02\x89\x3c\x79\x59\x9b\xbc\x37\xad\x08\x3c\x2e\xa7\xa0\x3c\xc3\x64\x76\xbc\x85\x70\x5a\x3c\xcd\x18\xdc\x3b\x65\xd9\xcc\xbc\xcb\x07\x05\x3c\x74\x7f\xa8\x3b\x74\xb9\xa7\x3b\xfa\x1b\x46\xbc\x65\x65\xce\xbc\xec\xc0\x0e\xbd\xd9\xee\xbd\xbc\x56\x96\x18\x3d\x83\x99\x82\xbc\xe6\xac\x1c\xbc\xf8\x11\xcd\xbb\x1a\x27\xd2\xbb\x63\xcf\x53\xbc\x56\x85\x73\x3c\xc9\x60\xe5\xbb\x5d\x81\xe2\x3b\xd3\xa0\xcc\xbb\x8d\x02\x44\x3c\x16\x35\xdc\xbc\x8f\x5e\x3f\x3b\x79\x93\x1a\xbc\x0f\xff\xed\x3c\xce\x00\x59\xbc\xc9\xab\x09\xbd\x55\x11\x75\xbc\xfb\x8f\x44\xbb\x5a\x36\x0c\xbd\x36\x8b\x8c\x3c\x09\xfc\x20\x3c\xe8\xbd\xf3\x3a\xf9\x6d\x48\xbc\xa4\x7b\x66\x3c\x5a\x88\x0e\xbd\x6c\x0f\x3b\x3c\x0a\xe4\x1d\x3c\x7a\xcd\x19\x3d\x81\x03\x08\x3d\x07\xa0\x25\xbc\xd9\xee\xbd\x3c\xba\x57\xb0\xba\x3b\x2b\x00\x3c\xed\xe2\x0a\x3d\xaa\x8f\x58\xbc\x49\x86\xb7\x3b\x9c\x97\xfa\x3c\x0a\x5f\xfa\x3c\xcc\x6a\xde\xbb\xba\x57\xb0\x3c\xef\xca\x07\xbd\xfa\xa7\xc7\x3b\x1f\x01\x45\xbb\xcc\xa4\xdd\x38\x90\xd2\xbd\x3c\x2b\x9d\x27\x3c\xa7\xbf\x5e\xbc\xbe\xbd\x24\xbc\x77\xb2\x7b\x3a\x6c\x61\x3d\x3c\x04\x96\x2c\xbc\xf0\xdb\xde\xba\x81\x7e\xe4\xbb\x05\x0a\x2b\xbd\x02\xc6\x32\xbb\xf5\x7b\xd2\xba\xcd\x18\xdc\x3a\xbd\x61\xa9\xbc\x97\x42\x2b\xbb\x10\xbe\x10\x3c\x31\x5f\x97\xbb\x80\x55\x8a\x3c\x79\x59\x9b\xbc\xb1\x8b\x47\xbc\xa3\x93\xe9\x3b\xbf\xf7\xa3\xbc\x70\x53\xb3\x3c\x56\x96\x98\xbb\x68\x1d\x45\xbc\x7b\xb5\x16\x3d\x81\x2c\xe2\xbb\x08\x14\xa4\xbc\xe5\xc4\x9f\x3c\xea\x64\x93\x3b\x81\x2c\xe2\xbc\xd1\xd0\x52\xbc\x82\x66\xe1\x3b\xf6\xb5\x51\xbb\xc1\x53\x9f\x3c\xfd\x5f\x3e\x3b\x33\x70\xee\x3c\x93\xdc\xb6\xbc\xf2\xc3\xdb\x3c\xd8\x06\xc1\xba\x12\x54\x8b\xbc\x6d\x49\x3a\xbb\x72\x23\xad\x3c\x6f\x19\xb4\x3b\xc9\xec\xe6\x3a\x1d\x31\xcb\x3b\x66\x87\x4a\xbc\x9b\x34\xa1\x3b\xe0\x5e\xab\x3a\x11\xa6\x0d\xbc\x79\x59\x1b\xbb\x58\xa0\x11\x3c\x94\xfe\x32\x3c\x5f\x51\x5c\x3b\x18\xcb\x56\xbb\xa7\x0a\x03\xbd\x7f\xe1\x0b\x3c\x6e\xf7\x37\xbc\xa9\xe1\x5a\x3b\xfb\x55\x45\xbc\x7f\x96\x67\x3e\x2d\x33\xa2\x3a\x05\x0a\x2b\xbb\xe7\x5a\x1a\x3d\x2d\xbf\xa3\xbb\x51\x6a\xa3\x3c\xa3\x18\x8d\x3c\x64\x7d\x51\xbc\xfc\x77\xc1\x3b\xe8\xce\x98\x3c\x7b\x6a\x72\x3b\xef\x04\x07\xbc\x76\x15\x23\xbc\x7d\x4b\x91\xbb\xa3\xde\x8d\xba\xf1\x89\x5c\xbc\xef\x3e\x06\xbd\xfd\x25\x3f\xbb\x2f\x44\xf9\xbc\xb6\xd9\x38\xbd\x15\x13\xe0\xbc\x7f\x96\xe7\xbc\xe9\xf0\x94\xbc\xb2\x73\xc4\xbc\x7f\x22\xe9\x3c\xc7\x4f\x8e\xba\xdc\x6c\xb5\xbb\xe4\x91\xfe\xbb\xbf\x20\x7e\x3c\x1a\x27\x52\x3c\x54\xb5\xf9\xbb\x0e\x17\xf1\xbb\x27\x71\xb2\xbb\x21\xe9\x41\x3b\x53\x8c\x1f\xba\x9b\xfa\x21\x3b\xbe\x49\x26\x3c\x04\xe8\xae\xb8\x7e\x33\x8e\x3c\x5e\xa3\xde\x3c\x98\xb6\xa9\xbc\x68\xa9\x46\x3c\x41\x2e\x4d\xbc\x8a\x4a\x4d\xbc\xc7\x15\x0f\x3c\xad\x0d\xd0\x3c\x02\x8c\xb3\xbc\xfe\x99\xbd\xbc\x44\x72\xc5\xbb\x48\x9e\xba\x3c\xd3\x66\xcd\xbc\x59\x4e\x8f\xbc\xad\xd3\xd0\x3a\x7c\x29\x95\x3c\xe6\xed\x79\x3c\x02\x00\xb2\x3c\xe5\xfe\x9e\x3c\x4b\x1c\xb2\x3c\x13\x2b\x63\xbc\xde\x8e\xb1\xbb\xe8\x08\x18\x3c\x02\x8c\xb3\x3c\x4b\xe2\xb2\xbc\x95\xe6\x2f\x3c\x36\x40\x68\x3c\x35\x58\x6b\x3c\x70\x8d\xb2\xbc\xa9\x1b\x5a\x3b\xd0\x96\x53\x3c\xe2\x46\xa8\xbc\xb3\x21\x42\xba\xef\x3e\x86\xbc\x50\x48\x27\x3c\x07\xa0\xa5\x3c\x83\x5f\x03\xba\x3d\xb0\xd5\xbc\x96\x5a\x2e\x3c\x15\x13\xe0\x3c\x14\x5e\x04\x3c\x2f\x8f\x9d\x3c\xe5\xc4\x9f\xbc\x9f\xb2\x18\xbc\xcf\x74\xd7\x3c\xa1\x37\xee\x3b\xc6\xf3\x92\x3b\x25\x89\x35\xbd\x5d\xcc\x06\x3c\x08\x03\xff\x3b\xe8\x49\x75\xbc\xe9\x31\xf2\x3a\xe9\x31\xf2\x3c\x3e\x24\x54\xbc\x2d\xbf\xa3\x3a\x32\x0d\x95\x3c\xa8\xb8\x00\x3d\x9a\x3b\xff\x3b\x01\xde\xb5\x3b\x80\x1b\x0b\x3c\x93\x50\xb5\x3c\x65\x9f\x4d\xbc\x5e\xee\x82\xbc\xf9\x33\xc9\xbc\xa2\x1f\xeb\x3c\x4a\x34\xb5\xba\x7b\xb5\x16\xbc\xb3\x95\x40\x3c\xca\xd4\xe3\xbc\x7a\x82\xf5\x3b\x44\x72\xc5\x3b\xcb\x48\xe2\xbc\x24\xa1\xb8\xbb\x77\x89\x21\xbc\x69\x57\xc4\xba\xef\xb9\x62\x3c\x00\x6a\xb7\x3b\x26\xfd\x33\xbb\x00\x30\x38\xbb\x62\x95\x54\xbc\x57\xf2\x93\xbc\x48\x64\x3b\xbc\x96\x5a\x2e\x3c\x77\xc3\x20\xbc\x0d\x28\x96\x3c\xe2\xba\x26\xbc\x01\x18\x35\x3c\x9b\x34\x21\xbc\xcb\x48\x62\xbc\x9d\xca\x1b\x3b\x9b\xaf\x7d\xbc\x18\x91\xd7\xbc\xc8\x78\xe8\x3c\xa8\xb8\x80\xbc\xb9\x6f\x33\x3c\xc9\x37\x0b\x3a\x0b\x1e\x9d\x3b\x44\x72\x45\x3c\x6b\xb3\xbf\xbb\xc8\xc3\x0c\xbc\xb4\x43\x3e\x3c\xc1\x53\x9f\x3c\x4d\x3e\x2e\x3a\x0c\x06\x1a\xbc\x3a\x7d\x82\x3b\xbf\xf7\xa3\x3c\xd1\x0a\xd2\xba\xc0\xa5\x21\xbd\x98\x7c\xaa\x3c\x66\x13\x4c\x3b\xa2\xf6\x90\x3b\xa1\x82\x12\x3c\x25\xdb\x37\xbd\xd4\x88\xc9\xbb\xa8\x6d\x5c\x3c\x5e\x28\x82\x3b\xa0\x9a\x95\x3c\xda\x62\x3c\xbc\x07\x2c\x27\xbd\x08\x03\xff\xbc\xef\xb9\xe2\xba\xdb\x10\x3a\xbc\xc6\xa8\xee\xbc\x82\xda\x5f\x3c\x5e\xee\x02\x3d\x81\x3d\x87\xbc\x35\xcc\x69\xbb\x80\xc9\x88\x3b\x94\xfe\x32\xbe\xf5\x7b\xd2\x3a\x2e\x5c\xfc\x3b\xa6\x63\xe3\xbc\xc4\x4c\x73\x3c\x23\x7f\xbc\xba\xb9\xe3\xb1\x3c\xdd\x1a\x33\xbc\x92\x2e\xb9\xbc\x10\xf8\x8f\x3c\x81\x77\x86\x3c\xcc\x6a\x5e\xbc\xc7\x90\xeb\xbc\x58\x2c\x93\xbc\x63\xcf\x53\x3c\x74\x45\x29\xbc\xa7\xbf\x5e\xbc\x16\x80\x00\x3d\x5d\x06\x06\x3c\x4f\x9a\x29\xbc\x7a\x07\x19\x3d\x32\x88\xf1\x3b\x86\x58\x57\xbb\x88\xee\xd1\xbc\x13\x3c\x08\x3c\x56\x96\x98\x3b\xef\x78\x85\x3b\xb1\xff\xc5\x3c\x08\x88\xa2\xbb\x10\xbe\x10\x3c\x9e\xf3\xf5\xbc\xc9\x60\xe5\xbc\xe9\xa5\xf0\x3b\x10\xe7\xea\xb9\x11\xa6\x8d\x3b\x4d\x04\x2f\xbc\xe9\xf0\x14\x3c\x5a\x3d\xea\x39\xa2\x6a\x8f\x3b\x58\x66\x92\x3c\x1a\x27\xd2\x3c\x3a\xb7\x01\x3c\x0f\x84\x91\xbc\xcb\x41\x04\x3c\x91\x46\xbc\xbb\x4f\xd4\xa8\xba\x33\x70\x6e\x3c\x57\xf2\x13\x3b\xc6\xa8\x6e\x3b\x29\xcd\x2d\xbc\xf0\xb2\x04\x3c\xeb\xd8\x91\xbc\xf0\xb2\x84\x3c\x59\xda\x90\xbc\xc9\xab\x89\x3c\xc8\xc3\x0c\x3c\x8b\x6c\x49\x3c\x02\x8c\x33\x3c\xc4\xc0\x71\xbb\xbe\x0f\x27\xbc\xf1\x89\x5c\xbc\x63\xcf\x53\x3b\xa6\x63\xe3\xbb\x16\x35\xdc\x3b\x41\x2e\xcd\xbb\xdb\x4a\x39\xbc\x00\x6a\xb7\xbc\x18\xcb\xd6\x3c\x4e\xec\xab\xbb\x37\x73\x09\xbc\xcc\x7b\x03\xbd\xcb\x07\x85\xbc\xd2\xb8\xcf\xba\xcb\x48\xe2\xbc\x48\x9e\xba\x3c\xae\x47\x4f\x3c\xcc\xa4\xdd\xbc\x2d\x74\xff\x3c\xf8\x4b\x4c\xbb\xa6\x22\x86\xbc\xc8\xc3\x8c\xbb\xa6\xe8\x06\x3d\xf4\x1f\xd7\xbb\x74\xb9\x27\xba\x07\xa0\x25\xbc\x5c\x1e\x89\x3c\xca\x93\x06\x3b\x9b\xaf\x7d\xbc\x1b\xd5\x4f\x3c\xa6\xe8\x86\xbc\x54\x29\xf8\x3c\x79\x9a\xf8\xbc\xde\x8e\xb1\xbb\x5e\x28\x82\xbb\x4c\xca\xaf\x3b\x28\x1f\x30\x3c\x36\xff\x0a\x3c\x51\xf6\x24\xbc\x7a\x07\x19\x3c\x7a\x82\xf5\xba\x17\xe3\x59\x3c\x35\xdd\x8e\x3a\x5d\x81\xe2\xbc\xf4\x93\xd5\x3b\xb1\xc5\xc6\x3c\x9d\x56\x9d\x3b\x7c\x29\x15\x3c\x7f\xe1\x8b\x3c\x53\xc6\x1e\x3d\xbc\xed\x2a\x3c\xc3\x64\x76\xbc\x54\x29\x78\xbc\x83\x88\xdd\x3c\x4a\x34\xb5\x3c\x34\x69\x90\xbc\x77\xc3\xa0\x3c\xe4\xdc\xa2\x3b\xf4\x93\x55\xbc\xe9\x31\x72\x3b\xcc\xb5\x02\xbc\xe9\x31\xf2\x3c\xd6\xe4\x44\x3c\xc8\x89\x8d\x3c\x83\xd3\x81\x3c\x58\xe1\xee\xbc\x08\x03\x7f\xbc\x1e\x19\xc8\xbd\x46\x7c\xbe\xbb\xdf\x76\xae\xbb\x21\x97\xbf\xba\x38\x9c\xe3\xbb\x9a\x3b\x7f\x3c\xf7\x63\xcf\x3b\x79\x59\x1b\x3c\xed\xe2\x8a\xbc\xc5\x45\x95\x3b\x17\xe3\x59\x3b\x2f\x55\x9e\xbc\x52\xcd\x7c\xbc\xea\x19\xef\x3a\x0e\x17\xf1\x3c\xc1\xc7\x1d\x3c\x31\xa0\xf4\xbb\xd0\x5c\x54\xbc\x3c\x8e\x59\xbc\xf2\xfd\xda\x3c\x3b\x54\xda\x3b\x3d\xb0\x55\x3c\xbf\x6b\x22\xbc\xb8\xfb\xb4\x3b\x5d\xbb\xe1\xbc\xb9\x6f\x33\x3c\x76\xca\xfe\xbb\x01\x18\x35\x3c\xe9\xb6\x95\x3c\x51\xf6\x24\x3c\x80\x0a\xe6\xba\x5d\xf5\xe0\xbc\xe4\x05\x7d\x3b\x1b\x0f\xcf\xbc\x46\x08\xc0\xbc\x55\x9d\xf6\x3b\xb4\x43\xbe\xbc\x9a\x4c\xa4\xbc\xc8\x89\x8d\x3c\xea\x2a\x14\xbd\x95\xe6\xaf\x3b\xb0\x17\xc9\x3a\x25\x15\xb7\x3c\xcb\xf6\x5f\xbc\xeb\x8d\x6d\x3b\x07\xa0\xa5\x3b\xcf\xae\xd6\xbc\x39\x09\x84\x3c\xf0\xec\x83\x3c\xc7\x4f\x8e\xbc\xe6\x61\x78\xbc\x9c\x23\x7c\xbc\x9d\x90\x9c\xbc\x58\x2c\x13\xbc\x13\x02\x09\x3d\xc3\xe9\x19\xbd\xfa\xe1\x46\x3c\x98\x7c\xaa\x3c\xf0\xec\x03\xbc\x16\x80\x80\x3c\x1b\x9b\x50\x3b\x5c\x0d\xe4\x3b\x82\x66\x61\xbc\x64\x7d\x51\x3c\xc7\x15\x0f\xbc\x15\xc1\x5d\xbc\x69\xcb\x42\xbc\x29\x7b\xab\xbc\x53\xc6\x9e\x3c\x00\x30\xb8\xbc\x59\xc9\xeb\xbc\x21\x5d\x40\x3b\x4d\x04\xaf\xbb\xa3\xde\x0d\xbb\xf4\x93\xd5\xbc\x69\xcb\x42\x3c\x6c\x61\x3d\x3c\x7b\x6a\xf2\x3b\x50\x82\xa6\x3c\x56\x96\x98\xbc\x33\x81\x93\xbc\x57\x7e\x95\xbc\xe2\xba\xa6\x3c\x5f\x9c\x80\xba\x86\x92\xd6\x3c\x7f\x6d\x0d\x3c\xe2\x80\x27\x3c\xc4\xd1\x16\xbc\x2b\x63\xa8\x3c\x67\xc1\x49\xbc\x65\x9f\xcd\xba\x52\xcd\x7c\x3c\xac\x25\x53\x3c\xb2\xad\xc3\xbc\xdc\xf8\x36\xbc\xba\x1d\x31\x3c\x5f\x51\x5c\x3c\x5a\x36\x8c\x3a\xe2\x46\xa8\x3c\x27\x71\xb2\x3c\xef\xb9\xe2\xb9\x5a\x36\x8c\xbc\x13\xb7\x64\xbd\xde\xc8\x30\x3c\x96\x5a\x2e\xbb\x09\xeb\xfb\xbb\xbc\x27\xaa\x3c\x04\x96\xac\xbb\x65\xd9\x4c\x3c\x80\x1b\x0b\xbb\xff\x81\xba\xbc\x34\x2f\x11\x3c\x11\x1a\x8c\xbc\xd8\x7a\xbf\x3b\x9b\xfa\xa1\xbc\x73\x0b\xaa\x3a\x36\xff\x0a\xbd\x5c\x92\x07\xbd\xbb\x79\xac\x3c\xef\x78\x05\x3c\xfd\x5f\xbe\xbb\x59\xda\x90\x3c\x10\xbe\x90\xbb\x7d\x11\x92\x3c\xb6\xd9\x38\xbc\x93\xdc\xb6\x3c\x83\x99\x02\xbc\xad\x99\x51\xbb\xc7\x04\xea\x3b\x1f\xc7\xc5\x3b\xc0\x94\x7c\xbc\x7f\x22\xe9\xba\x9d\x90\x1c\x3c\x95\xe6\x2f\xbd\x28\x59\x2f\x3c\x37\xad\x88\x3c\xf0\x26\x83\x3c\xe9\x31\xf2\xbc\x66\x13\xcc\xbc\x7a\x41\x98\x3c\x11\xa6\x8d\xbb\x23\x7f\x3c\x3c\xe8\x49\x75\xbc\xa4\x07\xe8\xbc\x78\x37\x9f\x3b\x0b\x92\x9b\xbc\xf9\x6d\xc8\xbb\x39\x09\x04\x3c\x16\x46\x01\xbd\xde\xc8\x30\x3c\xc8\x89\x8d\x3c\xd5\xfc\x47\xbc\x37\x73\x09\x3d\x7a\x82\x75\x3c\xe1\x98\xaa\xbc\x7b\xef\x95\xbc\x32\xd3\x15\xbd\xbe\x83\x25\xbd\x39\xcf\x84\x3c\x56\xd0\x17\x3b\x6e\xf7\x37\xbb\xe7\x5a\x9a\xbc\x82\xa0\xe0\x3c\xb8\xc1\x35\x3c\xf0\xdb\x5e\xbb\x7c\x63\x94\xbc\x30\x3d\x1b\x3c\x9c\xe2\x1e\xbc\xfc\x03\x43\xbb\xdc\x32\x36\xbc\x85\xaa\xd9\x3c\x38\x5b\x06\xbd\x4e\x26\xab\xbc\xcd\x18\x5c\xbc\x21\x23\x41\x3b\xf1\x60\x02\x3c\xaa\x8f\x58\x3c\xcc\xa4\xdd\xba\x7f\xe1\x8b\x3b\x7c\x9d\x13\x3c\x1d\x6b\xca\xbc\xef\x78\x05\x3d\xc1\xc7\x1d\x3c\x8d\xc8\xc4\xbb\x13\x02\x89\xbc\xd9\x28\x3d\x3c\xfa\xa7\xc7\x3c\xca\x93\x06\xbb\x59\x4e\x8f\x3b\x4c\x56\xb1\x3c\x74\xb9\xa7\x3c\x04\x5c\x2d\x3c\x53\xc6\x9e\xbb\x83\x4e\xde\x3c\x4d\x04\xaf\x3c\xe9\xa5\xf0\xbb\xc6\xa1\x90\x3c\x8e\xb0\x41\x3b\xd0\x22\xd5\xbc\x2b\xd7\x26\xbc\x99\x2a\xa8\x3c\x1d\xa5\xc9\x3c\x9f\xec\x97\x3b\x43\xfe\x46\x3c\x2e\x5c\x7c\x3c\x31\x25\x18\xbd\x2e\xd0\x7a\xbb\xcb\x41\x04\x3b\x92\xa2\xb7\xbc\x5e\x69\x5f\xbc\x5e\x7a\x04\xbd\x3a\xb7\x81\xbb\x82\xeb\x04\x3d\x5d\x06\x86\x3c\x3e\x98\x52\xba\x5f\x17\xdd\x3c\xd9\xee\x3d\xbc\xef\x04\x07\x3c\x20\x75\x43\xbc\xae\x81\x4e\xbc\xcd\x52\xdb\xbc\xe8\x08\x98\x3c\xea\x64\x13\x3c\x74\xb9\xa7\x3c\x82\xeb\x84\x3c\x53\x00\x9e\xbc\x75\xa1\xa4\xbb\x2d\xbf\x23\x3c\xc4\x0b\x16\x3c\xd7\xcc\xc1\xbc\x56\x44\x96\x3c\x48\x64\xbb\xba\x02\x8c\xb3\xbb\x06\xb8\xa8\xbb\x18\x57\xd8\xbb\x69\xcb\xc2\xbc\xa7\x0a\x83\xbc\x6c\xd5\xbb\xb9\xa8\x7e\x01\x3b\xd4\x88\x49\x3c\xcb\xcd\x05\xbc\xf9\x6d\x48\x3d\x78\x71\x9e\x3b\x27\xab\xb1\xbc\xcb\x82\x61\x3a\xf0\xec\x83\xbc\x0b\xd3\xf8\x3b\x25\xdb\x37\x3c\x9b\xfa\x21\x3b\xad\x0d\xd0\xbc\x0c\xbb\x75\x3b\x83\x14\x5f\x3c\x47\xf0\xbc\xbc\x82\xeb\x84\x3c\xef\x04\x07\xbd\xe3\xa2\x23\xbd\xa4\x07\x68\x3c\x9e\xf3\xf5\xbc\x32\xd3\x15\x3c\xd7\x1e\x44\xbc\xec\x34\x0d\x3b\x72\x5d\xac\x3b\x10\xf8\x0f\x3c\x83\x5f\x03\x3d\x5e\x7a\x04\xbc\xd2\xf2\x4e\x3a\x77\xb2\x7b\x3b\x4e\xb2\x2c\x3d\x57\xb8\x14\x3c\x2b\x63\xa8\xbb\xed\xa8\x8b\xbc\x2d\xf9\xa2\x3c\x31\xa0\xf4\x3b\x34\x2f\x11\xbd\xf3\xe5\x57\xbc\x2a\xef\xa9\x3c\x84\xfc\x5b\xbc\x00\xf6\xb8\xbc\x75\xa1\xa4\xbc\xc1\xc7\x1d\x3c\x44\xe6\xc3\x3c\x50\x82\xa6\xbc\xa1\xc3\xef\x3c\x88\xee\xd1\xbc\xdd\x1a\xb3\xbc\xee\x56\x89\x3c\x52\xcd\xfc\xbb\x85\xaa\x59\xbc\x33\x70\xee\xb9\x34\xf5\x91\xbb"
```


### redis search results

```json
{
  "attributes": [],
  "error": [],
  "total_results": 10,
  "format": "STRING",
  "results": [
    {
      "id": "omi:werewolf-garlic-bread.md",
      "extra_attributes": {
        "score": "0.201129853725",
        "title": "Werewolf Garlic Bread",
        "recipe_name": "werewolf-garlic-bread.md",
        "id": "omi:werewolf-garlic-bread.md",
        "text": "## Werewolf Garlic Bread\n\nA pungent and flavorful garlic bread.\n\nThis recipe is loved by: Werewolves, Vampires\n\nIngredients:\n\n* 4 slices of bread\n* 50g Werewolf Garlic, minced\n* 30g Unicorn Truffle, grated\n\nPreparation steps:\n\n1. Preheat the oven to 180°C.\n2. Mix minced Werewolf Garlic with butter and spread on the bread slices.\n3. Sprinkle grated Unicorn Truffle on top.\n4. Bake for 5-7 minutes or until golden brown.\n\nFinal comments: A garlic lover's delight.\n"
      },
      "values": []
    },
    {
      "id": "omi:werewolf-walnut-cookies.md",
      "extra_attributes": {
        "score": "0.209924697876",
        "title": "Werewolf Walnut Cookies",
        "recipe_name": "werewolf-walnut-cookies.md",
        "id": "omi:werewolf-walnut-cookies.md",
        "text": "## Werewolf Walnut Cookies\n\nButtery cookies with a crunch.\n\nThis recipe is loved by: Werewolves, Goblins\n\nIngredients:\n\n* 200g Vampire Vanilla butter\n* 100g Werewolf Walnuts\n* 250g Vampire Vanilla sugar\n* 2 Eggs\n* 300g Ghostly Greens flour\n\nPreparation steps:\n\n1. Cream Vampire Vanilla butter and Vampire Vanilla sugar.\n2. Add eggs and mix well.\n3. Stir in Ghostly Greens flour and chopped Werewolf Walnuts.\n4. Drop spoonfuls of dough onto a baking sheet and bake at 180°C for 10-12 minutes.\n\nFinal comments: A nutty delight.\n"
      },
      "values": []
    },
    {
      "id": "omi:ghostly-greens-and-vampire-vinegar-pork-chops.md",
      "extra_attributes": {
        "score": "0.21469438076",
        "title": "Ghostly Greens and Vampire Vinegar Pork Chops",
        "recipe_name": "ghostly-greens-and-vampire-vinegar-pork-chops.md",
        "id": "omi:ghostly-greens-and-vampire-vinegar-pork-chops.md",
        "text": "## Ghostly Greens and Vampire Vinegar Pork Chops\n\nPork chops served with a side of enchanting greens.\n\nIngredients:\n\n* 2 Pork chops\n* 30ml Vampire Vinegar\n* 150g Ghostly Greens\n\nPreparation steps:\n\n1. Season pork chops with Vampire Vinegar and grill for 6-8 minutes on each side.\n2. Serve with sautéed Ghostly Greens.\n\nFinal comments: A well-balanced meal.\n"
      },
      "values": []
    },
    {
      "id": "omi:magenta-magician-pasta.md",
      "extra_attributes": {
        "score": "0.215799808502",
        "title": "Magenta Magician Pasta",
        "recipe_name": "magenta-magician-pasta.md",
        "id": "omi:magenta-magician-pasta.md",
        "text": "## Magenta Magician Pasta\n\n\nMagenta-colored pasta made with dragonfruit, served with a tangy Vampire Vinegar dressing.\n\nIngredients:\n\n* 200g Magenta Magician Pasta\n* 30ml Vampire Vinegar\n* 10g Basilisk Basil\n\nPreparation steps:\n\n1. Cook Magenta Magician Pasta according to package instructions.\n2. Toss the cooked pasta with Vampire Vinegar dressing.\n3. Garnish with Basilisk Basil.\n4. Serve chilled.\n\nFinal comments: A visually striking pasta salad.\n"
      },
      "values": []
    },
    {
      "id": "omi:ghostly-green-soup.md",
      "extra_attributes": {
        "score": "0.216566205025",
        "title": "Ghostly Green Soup",
        "recipe_name": "ghostly-green-soup.md",
        "id": "omi:ghostly-green-soup.md",
        "text": "## Ghostly Green Soup\n\nA hauntingly green soup with a dash of mystery.\n\nThis recipe is loved by: Ghosts, Banshees\n\nIngredients:\n\n* 300g Ghostly Greens\n* 30ml Vampire Vinegar\n* 250ml Griffin Ginger broth\n\nPreparation steps:\n\n1. Blanche Ghostly Greens in boiling water for 2 minutes.\n2. Drain and blend them with Vampire Vinegar and Griffin Ginger broth.\n3. Reheat and serve hot.\n\nFinal comments: A bewitching and healthy soup.\n"
      },
      "values": []
    },
    {
      "id": "omi:basilisk-basil-panna-cotta.md",
      "extra_attributes": {
        "score": "0.223661124706",
        "title": "Basilisk Basil Panna Cotta",
        "recipe_name": "basilisk-basil-panna-cotta.md",
        "id": "omi:basilisk-basil-panna-cotta.md",
        "text": "## Basilisk Basil Panna Cotta\n\nA petrifyingly good and creamy dessert.\n\nThis recipe is loved by: Gorgons, Basilisks\n\nIngredients:\n\n* 300ml Yeti Yogurt\n* 100ml Vampire Vinegar\n* 50g Basilisk Basil\n\nPreparation steps:\n\n1. Mix Yeti Yogurt with Vampire Vinegar and Basilisk Basil.\n2. Pour the mixture into small serving dishes.\n3. Chill in the refrigerator for 4 hours or until set.\n4. Serve cold.\n\nFinal comments: A delightful and herby dessert.\n"
      },
      "values": []
    },
    {
      "id": "omi:starry-night-pasta.md",
      "extra_attributes": {
        "score": "0.227531433105",
        "title": "Starry Night Pasta",
        "recipe_name": "starry-night-pasta.md",
        "id": "omi:starry-night-pasta.md",
        "text": "## Starry Night Pasta\n\n\nMidnight-blue pasta made with dragonfruit and served with a starlit basilisk basil sauce.\n\nIngredients:\n\n* 200g Starry Night Pasta\n* 30g Basilisk Basil\n* 30ml Vampire Vinegar\n\nPreparation steps:\n\n1. Cook Starry Night Pasta according to package instructions.\n2. Blend Basilisk Basil and Vampire Vinegar to create a sauce.\n3. Toss cooked pasta in the starlit basilisk basil sauce.\n4. Serve with a sprinkle of edible stardust.\n\nFinal comments: A pasta that looks like the night sky.\n"
      },
      "values": []
    },
    {
      "id": "omi:goblin-green-spinach-pasta.md",
      "extra_attributes": {
        "score": "0.228452563286",
        "title": "Goblin Green Spinach Pasta",
        "recipe_name": "goblin-green-spinach-pasta.md",
        "id": "omi:goblin-green-spinach-pasta.md",
        "text": "## Goblin Green Spinach Pasta\n\n\nVibrant green pasta made with goblin green spinach, served with a garlic and vampire vinegar sauce.\n\nIngredients:\n\n* 200g Goblin Green Spinach Pasta\n* 50g Vampire Vinegar\n* 3 cloves of garlic, minced\n\nPreparation steps:\n\n1. Cook Goblin Green Spinach Pasta according to package instructions.\n2. In a pan, sauté minced garlic with Vampire Vinegar.\n3. Toss cooked pasta in the garlic and vampire vinegar sauce.\n4. Serve hot.\n\nFinal comments: A visually striking and flavorful dish.\n"
      },
      "values": []
    },
    {
      "id": "omi:ghostly-gouda-fondue.md",
      "extra_attributes": {
        "score": "0.230891466141",
        "title": "Ghostly Gouda Fondue",
        "recipe_name": "ghostly-gouda-fondue.md",
        "id": "omi:ghostly-gouda-fondue.md",
        "text": "## Ghostly Gouda Fondue\n\nA hauntingly good cheese fondue.\n\nThis recipe is loved by: Ghosts, Goblins\n\nIngredients:\n\n* 300g Ghostly Gouda\n* 100ml Vampire Vinegar\n* 100ml Griffin Ginger beer\n\nPreparation steps:\n\n1. Grate Ghostly Gouda and set aside.\n2. In a fondue pot, heat Vampire Vinegar and Griffin Ginger beer.\n3. Gradually add the grated Ghostly Gouda, stirring until melted and smooth.\n4. Serve with crusty bread or vegetables.\n\nFinal comments: A spookily delicious treat.\n"
      },
      "values": []
    },
    {
      "id": "omi:medusas-grilled-lamb.md",
      "extra_attributes": {
        "score": "0.231808364391",
        "title": "Medusa's Grilled Lamb",
        "recipe_name": "medusas-grilled-lamb.md",
        "id": "omi:medusas-grilled-lamb.md",
        "text": "## Medusa's Grilled Lamb\n\nTender lamb chops with a gaze-worthy marinade.\n\nIngredients:\n\n* 4 Lamb chops\n* 30ml Vampire Vinegar\n* 50g Basilisk Basil\n\nPreparation steps:\n\n1. Marinate lamb chops in Vampire Vinegar and Basilisk Basil for 1-2 hours.\n2. Grill for 8-10 minutes on each side.\n\nFinal comments: A hypnotic dish.\n"
      },
      "values": []
    }
  ]
}
```


