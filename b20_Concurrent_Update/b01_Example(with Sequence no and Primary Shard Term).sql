

-- Search for a document (To Update)

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_search?q=Inter

{"took":4,"timed_out":false,"_shards":{"total":1,"successful":1,"skipped":0,"failed":0},"hits":{"total":{"value":1,"relation":"eq"},"max_score":1.9844898,"hits":[{"_index":"movies","_type":"_doc","_id":"109487","_score":1.9844898,"_source":{ "id": "109487", "title" : "Interstellar", "year":2014 , "genre":["Sci-Fi", "IMAX"] }}]}}%

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_doc/109487?pretty

{
  "_index" : "movies",
  "_type" : "_doc",
  "_id" : "109487",
  "_version" : 1,
  "_seq_no" : 2,        //**
  "_primary_term" : 1,  //**
  "found" : true,
  "_source" : {
    "id" : "109487",
    "title" : "Interstellar",
    "year" : 2014,
    "genre" : [
      "Sci-Fi",
      "IMAX"
    ]
  }
}

--  Client 1
--  (Restrict the Update to a specific sequence number & primary term)

curl -H "Content-Type: application/json"  -XPUT "127.0.0.1:9200/movies/_doc/109487?if_seq_no=2&if_primary_term=1" -d '{
  "genres": ["IMAX", "Sci-Fi"],
  "title": "Interstellar foo",
  "year": 2014
}'

{"_index":"movies","_type":"_doc","_id":"109487","_version":2,"result":"updated","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":5,"_primary_term":1}%
^^ Note here we get new Sequence no 5

-- Client 2 (Does the same update as ^)

curl -H "Content-Type: application/json"  -XPUT "127.0.0.1:9200/movies/_doc/109487?if_seq_no=2&if_primary_term=1" -d '{
  "genres": ["IMAX", "Sci-Fi"],
  "title": "Interstellar typo",
  "year": 2014
}'

{"error":{"root_cause":[{"type":"version_conflict_engine_exception","reason":"[109487]: version conflict, required seqNo [2], primary term [1]. current document has seqNo [5] and primary term [1]","index_uuid":"4s-d_-gfRiewWIc-k00Sgw","shard":"0","index":"movies"}],"type":"version_conflict_engine_exception","reason":"[109487]: version conflict, required seqNo [2], primary term [1]. current document has seqNo [5] and primary term [1]","index_uuid":"4s-d_-gfRiewWIc-k00Sgw","shard":"0","index":"movies"},"status":409}%

-- Retry on conflict parameter

  + What do we do if we get error? (Like in this case of Client 2)
    - Option 1
      . Get new sequence no & retry
        (or)
      . Ask ES to do that for us with retry-on-conflict parameter



(Note: We are using Partial Update)
curl -H "Content-Type: application/json"  -XPOST "127.0.0.1:9200/movies/_doc/109487/_update?retry_on_conflict=5" -d '{
  "doc": {
    "title": "Interstellar Typo"
  }
}'

{"_index":"movies","_type":"_doc","_id":"109487","_version":3,"result":"updated","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":6,"_primary_term":1}
^ New sequence no 6

curl -H "Content-Type: application/json" -XGET 127.0.0.1:9200/movies/_doc/109487?pretty


