

-- Get mapping from the index

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_mapping

{
   "movies":{
      "mappings":{
         "properties":{
            "genre":{
               "type":"text",
               "fields":{
                  "keyword":{
                     "type":"keyword",
                     "ignore_above":256
                  }
               }
            },
            "title":{
               "type":"text",
               "fields":{
                  "keyword":{
                     "type":"keyword",
                     "ignore_above":256
                  }
               }
            },
            "year":{
               "type":"date"
            }
         }
      }
   }
}
