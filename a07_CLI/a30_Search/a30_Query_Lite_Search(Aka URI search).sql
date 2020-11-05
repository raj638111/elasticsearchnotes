

-- Query Lite Search

  #30
  # Provides ability to avoid full bodied search queries (ie where we provide the JSON query using -d option)

  # Can be used for,
    - Simple queries (for quick experimenting. DO NOT use in production)

  #* Also called as URL search

-- Disadvantages

  # Cannot be used for complex queries because,
    - We would need to URL encode special characters
      (when using in Browser, not in curl though I believe)

  # Security issue
    - As it provides ability for the user to send arbitary data

  # Fragile
    - One wrong character and we are hosed

-- Example

  curl $h -XGET "127.0.0.1:9200/movies/_search?q=title:star&pretty"

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
        "value" : 2,
        "relation" : "eq"
      },
      "max_score" : 0.919734,
      "hits" : [
        {
          "_index" : "movies",
          "_type" : "_doc",
          "_id" : "135569",
          "_score" : 0.919734,
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
          "_score" : 0.66685396,
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

  // Note: + is used as combining of boolean... I believe
  curl $h -XGET "127.0.0.1:9200/movies/_search?q=+year>2010+title:trek&pretty"