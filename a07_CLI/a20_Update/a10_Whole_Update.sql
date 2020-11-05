
-- Update (Specifying all part of the document will be treated as update)

#19
curl -H "Content-Type: application/json" -XPUT 127.0.0.1:9200/movies/_doc/109487\?pretty -d '{
  "genres": ["IMAX", "Sci-Fi"],
  "title": "Interstellar foo",
  "year": 2014
}'

{
  "_index" : "movies",
  "_type" : "_doc",
  "_id" : "109487",
  "_version" : 2, // New version no
  "result" : "updated",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 5,
  "_primary_term" : 1
}

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_doc/109487\?pretty

{
  "_index" : "movies",
  "_type" : "_doc",
  "_id" : "109487",
  "_version" : 2,
  "_seq_no" : 5,
  "_primary_term" : 1,
  "found" : true,
  "_source" : {
    "genres" : [
      "IMAX",
      "Sci-Fi"
    ],
    "title" : "Interstellar foo",
    "year" : 2014
  }
}

