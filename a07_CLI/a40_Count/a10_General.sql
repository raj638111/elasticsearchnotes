

https://www.elastic.co/guide/en/elasticsearch/reference/current/search-count.html


GET /my-index-000001/_count?q=user:kimchy


PUT /my-index-000001/_doc/1?refresh
{
  "user.id": "kimchy"
}

GET /my-index-000001/_count?q=user:kimchy

GET /my-index-000001/_count
{
  "query" : {
    "term" : { "user.id" : "kimchy" }
  }
}

{
  "count": 1,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  }
}

--
