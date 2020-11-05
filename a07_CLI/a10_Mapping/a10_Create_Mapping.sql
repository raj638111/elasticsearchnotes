

-- Create a Mapping

curl -H "Content-Type: application/json" -XPUT 127.0.0.1:9200/movies -d '
{
  "mappings": {
    "properties": {
      "year": {"type": "date"}
    }
  }
}'

{"acknowledged":true,"shards_acknowledged":true,"index":"movies"}%