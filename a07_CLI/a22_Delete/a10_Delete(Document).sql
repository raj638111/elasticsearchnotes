

-- Delete

#20

curl -XDELETE 127.0.0.1:9200/movies/_doc/58560?pretty
{
  "_index" : "movies",
  "_type" : "_doc",
  "_id" : "58560",
  "_version" : 1,
  "result" : "not_found",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 8,
  "_primary_term" : 1
}


