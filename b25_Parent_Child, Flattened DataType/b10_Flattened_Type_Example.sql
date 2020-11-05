

#26
-- Create an index

curl -H "Content-Type: application/json" -XPUT "http://127.0.0.1:9200/demo-flattened"

{"acknowledged":true,"shards_acknowledged":true,"index":"demo-flattened"}

-- Create a mapping

curl -H "Content-Type: application/json" -XPUT "http://127.0.0.1:9200/demo-flattened/_mapping" -d '{
  "properties": {
    "host": {
      "type": "flattened"
    }
  }
}'
{"acknowledged":true}%

-- Insert a document to index

curl -H "Content-Type: application/json" -XPUT "http://127.0.0.1:9200/demo-flattened/_doc/1" -d'{
  "message": "[5592:1:0309/123054.737712:ERROR:child_process_sandbox_support_impl_linux.cc(79)] FontService unique font name matching request did not receive a response.",
  "fileset": {
    "name": "syslog"
  },
  "process": {
    "name": "org.gnome.Shell.desktop",
    "pid": 3383
  },
  "@timestamp": "2020-03-09T18:00:54.000+05:30",
  "host": {
    "hostname": "bionic",
    "name": "bionic"
  }
}'
{"_index":"demo-flattened","_type":"_doc","_id":"1","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":0,"_primary_term":1}%

-- Check if the field 'host' is flattened in the mapping

curl -H "Content-Type: application/json" -XGET http://127.0.0.1:9200/demo-flattened/_mapping?pretty=true

# Note: 'host' field no longer has the nested field

{
  "demo-flattened" : {
    "mappings" : {
      "properties" : {
        "@timestamp" : {
          "type" : "date"
        },
        "fileset" : {
          "properties" : {
            "name" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            }
          }
        },
        "host" : {
          "type" : "flattened"
        },
        "message" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "process" : {
          "properties" : {
            "name" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "pid" : {
              "type" : "long"
            }
          }
        }
      }
    }
  }
}

-- Update a new host inner field & see what happpens

curl -H "Content-Type: application/json" -XPOST "http://127.0.0.1:9200/demo-flattened/_update/1" -d '{
  "doc": {
    "host": {
      "osVersion": "Bionic Beaver",
      "osArchitecture": "x86_64"
    }
  }
}'
{"_index":"demo-flattened","_type":"_doc","_id":"1","_version":2,"result":"updated","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":1,"_primary_term":1}%


-- Ensure the 'host' field is still flat in mapping (Although it should be available in the doc)

curl -H "Content-Type: application/json" -XGET http://127.0.0.1:9200/demo-flattened/_mapping?pretty=true

{
  "demo-flattened" : {
    "mappings" : {
      "properties" : {
        "@timestamp" : {
          "type" : "date"
        },
        "fileset" : {
          "properties" : {
            "name" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            }
          }
        },
        "host" : {
          "type" : "flattened"
        },
        "message" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "process" : {
          "properties" : {
            "name" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "pid" : {
              "type" : "long"
            }
          }
        }
      }
    }
  }
}

-- Search for 'Bionic Beaver' in parent object (ie Host)


curl -H "Content-Type: application/json" -XGET "http://127.0.0.1:9200/demo-flattened/_search?pretty=true" -d '{
  "query": {
    "match": {
      "host": "Bionic Beaver"
    }
  }
}'

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
    "max_score" : 0.3955629,
    "hits" : [
      {
        "_index" : "demo-flattened",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 0.3955629,
        "_source" : {
          "message" : "[5592:1:0309/123054.737712:ERROR:child_process_sandbox_support_impl_linux.cc(79)] FontService unique font name matching request did not receive a response.",
          "fileset" : {
            "name" : "syslog"
          },
          "process" : {
            "name" : "org.gnome.Shell.desktop",
            "pid" : 3383
          },
          "@timestamp" : "2020-03-09T18:00:54.000+05:30",
          "host" : {
            "hostname" : "bionic",
            "name" : "bionic",
            "osVersion" : "Bionic Beaver",
            "osArchitecture" : "x86_64"
          }
        }
      }
    ]
  }
}


-- Search for 'Bionic Beaver' in specific inner object

  # Done through host.os_version
  # Probably this is faster than the previous one (as the previous searches all the fields in the parent)

curl -H "Content-Type: application/json" -XGET "http://127.0.0.1:9200/demo-flattened/_search?pretty=true" -d '{
  "query": {
    "match": {
      "host.osVersion": "Bionic Beaver"
    }
  }
}'

{
  "took" : 1,
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
    "max_score" : 0.41501677,
    "hits" : [
      {
        "_index" : "demo-flattened",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 0.41501677,
        "_source" : {
          "message" : "[5592:1:0309/123054.737712:ERROR:child_process_sandbox_support_impl_linux.cc(79)] FontService unique font name matching request did not receive a response.",
          "fileset" : {
            "name" : "syslog"
          },
          "process" : {
            "name" : "org.gnome.Shell.desktop",
            "pid" : 3383
          },
          "@timestamp" : "2020-03-09T18:00:54.000+05:30",
          "host" : {
            "hostname" : "bionic",
            "name" : "bionic",
            "osVersion" : "Bionic Beaver",
            "osArchitecture" : "x86_64"
          }
        }
      }
    ]
  }
}

