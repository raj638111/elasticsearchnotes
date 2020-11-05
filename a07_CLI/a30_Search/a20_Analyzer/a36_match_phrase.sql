

-- match_phrase

  # Expected: search term = 'sci' should yield docs with 'sci-fi', 'Sci-Fi', 'sci', etc...
  #23

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?pretty -d '{
  "query": {
    "match_phrase": {
      "genre": "sci"
    }
  }
}
'

# Note
  + Here the analyzer  splits 'sci-fi' into 'sci' & 'fi' after which it tries to maps with the search term
  + Here "genre" is interpreted as a **'Text Field'
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 3,
      "relation" : "eq"
    },
    "max_score" : 0.320456,
    "hits" : [
      {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "1924",
        "_score" : 0.320456,
        "_source" : {
          "id" : "1924",
          "title" : "Plan 9 from Outer Space",
          "year" : 1959,
          "genre" : [
            "Horror",
            "Sci-Fi"
          ]
        }
      },
      {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "135569",
        "_score" : 0.2876821,
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
        "_score" : 0.2388304,
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
