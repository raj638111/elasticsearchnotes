
-- Update (Partial update: Using _update)

# Note: We have POST request here
#19
# Here we are updating one of the field in the doc

curl -H "Content-Type: application/json" -XPOST 127.0.0.1:9200/movies/_doc/109487/_update\?pretty -d '{
  "doc": {
    "title": "Interstellar"
  }
}'

{
  "_index" : "movies",
  "_type" : "_doc",
  "_id" : "109487",
  "_version" : 3, // New version
  "result" : "updated",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 6,
  "_primary_term" : 1
}
