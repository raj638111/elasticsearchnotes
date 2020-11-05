

-- match_phrase

  # Expected
    + search term = 'sci' should only match 'sci'
    + Should be a case-sensitive search

  #23

-- Remove existing index

curl -XDELETE http://localhost:9200/movies
{"acknowledged":true}%

-- Create new mapping

  # Here,
    - type = keyword ensure we get only exact match + case sensitive (ie No analyzer is applied)
    - type = text enables us to user Analyzers,
      . Partial mapping, normalize upper & lower case, synonyms etc...
      . analyzer = english
        ~ Can apply stop words, synonyms specific to the language

curl -H "Content-Type: application/json" -XPUT 127.0.0.1:9200/movies -d '
{
  "mappings": {
    "properties": {
      "id": {"type": "integer"},
      "year": {"type": "date"},
      "genre": {"type": "keyword"},
      "title": {"type": "text", "analyzer": "english"}
    }
  }
}'

{"acknowledged":true,"shards_acknowledged":true,"index":"movies"}

-- Index the data

curl -H "Content-Type: application/json" -XPUT 127.0.0.1:9200/_bulk\?pretty --data-binary @movies.json

-- Search for genre

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?pretty -d '{
  "query": {
    "match_phrase": {
      "genre": "sci"
    }
  }
}
'
# Good. Empty as we do not have any exact match
{
  "took" : 632,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 0,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  }
}

-- Search for title ('match`)

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?pretty -d '{
  "query": {
    "match": {
      "title": "Star Wars"
    }
  }
}
'

{
  "took" : 3,
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
    "max_score" : 1.7228093,
    "hits" : [
      {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "122886",
        "_score" : 1.7228093,
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
      },
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
      }
    ]
  }
}
-- Search for title ('match_phrase`)

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?pretty -d '{
  "query": {
    "match_phrase": {
      "title": "Star Wars"
    }
  }
}
'
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
      "value" : 1,
      "relation" : "eq"
    },
    "max_score" : 1.7228093,
    "hits" : [
      {
        "_index" : "movies",
        "_type" : "_doc",
        "_id" : "122886",
        "_score" : 1.7228093,
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