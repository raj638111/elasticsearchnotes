

-- Manual rollover of the alias
  (Not sure what this is???)
  curl --location --request POST 'localhost:9200/<alias>/_rollover/<new_index_name>' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "conditions": {
      "max_docs":  1
    }
  }'