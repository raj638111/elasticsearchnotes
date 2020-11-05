
-- Search (Using query)

#20
curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?q=Star
                                                                               ^ This is called URI Search
                                                                                 where we do not use JSON query,
                                                                                 but provide a direct string
                                                                                 for search

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?q=Star
{"took":2,"timed_out":false,"_shards":{"total":1,"successful":1,"skipped":0,"failed":0},
"hits":{"total":{"value":2,"relation":"eq"},"max_score":0.9579736,
"hits":[{"_index":"movies","_type":"_doc","_id":"135569",
"_score":0.9579736,"_source":{ "id": "135569",
"title" : "Star Trek Beyond", "year":2016 ,
"genre":["Action", "Adventure", "Sci-Fi"] }},{"_index":"movies","_type":"_doc","_id":"122886","_score":0.65114933,"_source":{ "id": "122886", "title" : "Star Wars: Episode VII - The Force Awakens", "year":2015 , "genre":["Action", "Adventure", "Fantasy", "Sci-Fi", "IMAX"] }}]}}