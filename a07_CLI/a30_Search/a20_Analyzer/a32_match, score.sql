

-- match

  # Expected: Get doc event if it has only partial match
  # 'Star Trek'
    - Any document with Star or Trek will be returned

#23

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?pretty -d '{
  "query": {
    "match": {
      "title": "Star Trek"
    }
  }
}
'

  # Note
    + We get both Star Trek & Star Wars because of the use of Analyzer
    + Those document with partial match also gets less 'score'

{
  "took" : 10,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 2,
      "relation" : "eq"
    },
    "max_score" : 2.679688,
    "hits" : [
      {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "135569",
        "_score" : 2.679688, // ***********
        "_source" : {
          "id" : "135569",
          "title" : "Star Trek Beyond",
          "year" : 2016,
          "genre" : [
            "Action",
            "Adventure",
            "Sci-Fi"
          ]
        }
      },
      {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "122886",
        "_score" : 0.7100825, // ***************
        "_source" : {
          "id" : "122886",
          "title" : "Star Wars: Episode VII - The Force Awakens",
          "year" : 2015,
          "genre" : [
            "Action",
            "Adventure",
            "Fantasy",
            "Sci-Fi",
            "IMAX"
          ]
        }
      }
    ]
  }
}

