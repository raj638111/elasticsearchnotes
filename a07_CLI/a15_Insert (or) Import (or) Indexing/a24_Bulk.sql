
-- Bulk insert

# Note: Suppose the redundant _id is used for Hashing to the right Shard???
# 18
# -data-binary: Makes it possible to import from a file

--
cat movies.json

{ "create" : { "_index" : "movies", "_id" : "135569" } }
{ "id": "135569", "title" : "Star Trek Beyond", "year":2016 , "genre":["Action", "Adventure", "Sci-Fi"] }
{ "create" : { "_index" : "movies", "_id" : "122886" } }
{ "id": "122886", "title" : "Star Wars: Episode VII - The Force Awakens", "year":2015 , "genre":["Action", "Adventure", "Fantasy", "Sci-Fi", "IMAX"] }
{ "create" : { "_index" : "movies", "_id" : "109487" } }
{ "id": "109487", "title" : "Interstellar", "year":2014 , "genre":["Sci-Fi", "IMAX"] }
{ "create" : { "_index" : "movies", "_id" : "58559" } }
{ "id": "58559", "title" : "Dark Knight, The", "year":2008 , "genre":["Action", "Crime", "Drama", "IMAX"] }
{ "create" : { "_index" : "movies", "_id" : "1924" } }
{ "id": "1924", "title" : "Plan 9 from Outer Space", "year":1959 , "genre":["Horror", "Sci-Fi"] }'

--

curl -H "Content-Type: application/json" -XPUT 127.0.0.1:9200/_bulk\?pretty --data-binary @movies.json
# Note: Interstellar failed as we have already inserted the document earlier...and we cannot insert
#       a document with the same document id

{
  "took" : 41,
  "errors" : true,
  "items" : [
    {
      "create" : {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "135569",
        "_version" : 1,
        "result" : "created",
        "_shards" : {
          "total" : 2,
          "successful" : 1,
          "failed" : 0
        },
        "_seq_no" : 1,
        "_primary_term" : 1,
        "status" : 201
      }
    },
    {
      "create" : {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "122886",
        "_version" : 1,
        "result" : "created",
        "_shards" : {
          "total" : 2,
          "successful" : 1,
          "failed" : 0
        },
        "_seq_no" : 2,
        "_primary_term" : 1,
        "status" : 201
      }
    },
    {
      "create" : {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "109487",
        "status" : 409,
        "error" : {
          "type" : "version_conflict_engine_exception",
          "reason" : "[109487]: version conflict, document already exists (current version [1])",
          "index_uuid" : "hhXrnKuuToqlyb4cVjGpaA",
          "shard" : "0",
          "index" : "movies"
        }
      }
    },
    {
      "create" : {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "58559",
        "_version" : 1,
        "result" : "created",
        "_shards" : {
          "total" : 2,
          "successful" : 1,
          "failed" : 0
        },
        "_seq_no" : 3,
        "_primary_term" : 1,
        "status" : 201
      }
    },
    {
      "create" : {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "1924",
        "_version" : 1,
        "result" : "created",
        "_shards" : {
          "total" : 2,
          "successful" : 1,
          "failed" : 0
        },
        "_seq_no" : 4,
        "_primary_term" : 1,
        "status" : 201
      }
    }
  ]
}