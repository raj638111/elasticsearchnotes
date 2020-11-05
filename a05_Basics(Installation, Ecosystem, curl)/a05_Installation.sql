
https://sundog-education.com/elasticsearch/

-- If time is not set right in Ubuntu, do this...

sudo apt install ntp
sudo apt-get update

-- Install Elastic Search

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install elasticsearch

-- Configure

sudo vi /etc/elasticsearch/elasticsearch.yml
Uncomment the node.name line

Change network.host to 0.0.0.0, discovery.seed.hosts to [“127.0.0.1”],
Change cluster.initial_master_nodes to [“node-1”]

-- Start ElasticSearch

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service

-- [Another way: Docker]

CONTAINER ID        IMAGE                                                                     COMMAND                  CREATED             STATUS                     PORTS                                              NAMES
c87b6e8385ad        docker.elastic.co/elasticsearch/elasticsearch:7.4.2                       "/usr/local/bin/dock…"   2 days ago          Up 3 minutes               0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp     kafka_elasticsearch_1

docker container exec -it kafka_elasticsearch_1 bash

-- Validate if running...

curl -XGET 127.0.0.1:9200

{
  "name" : "node-1",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "IBwf3cY1Ta2E2XsymwiVLg",
  "version" : {
    "number" : "7.9.2",
    "build_flavor" : "default",
    "build_type" : "deb",
    "build_hash" : "d34da0ea4a966c4e49417f2da2f244e3e97b4e6e",
    "build_date" : "2020-09-23T00:45:33.626720Z",
    "build_snapshot" : false,
    "lucene_version" : "8.6.2",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}


-- Load sample data

  -- Get schema of data
  wget http://media.sundog-soft.com/es7/shakes-mapping.json
  cat shakes-mapping.json
  {
  	"mappings" : {
  		"properties" : {
  			"speaker" : {"type": "keyword" },
  			"play_name" : {"type": "keyword" },
  			"line_id" : { "type" : "integer" },
  			"speech_number" : { "type" : "integer" }
  		}
  	}
  }

  -- Submit to ES
  curl -H 'Content-Type: application/json' -XPUT 127.0.0.1:9200/shakespeare --data-binary @shakes-mapping.json
  {"acknowledged":true,"shards_acknowledged":true,"index":"shakespeare"}

  -- Get Data
  wget http://media.sundog-soft.com/es7/shakespeare_7.0.json
  ls -lh
  total 25M
  -rw-rw-r-- 1 student student 215 Apr 15  2019 shakes-mapping.json
  -rw-rw-r-- 1 student student 25M Apr 15  2019 shakespeare_7.0.json

  -- Submit to index
  curl -H 'Content-Type: application/json' -XPOST '127.0.0.1:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare_7.0.json
  ...
    {
      "index" : {
        "_index" : "shakespeare",
        "_type" : "_doc",
        "_id" : "111395",
        "_version" : 1,
        "result" : "created",
        "_shards" : {
          "total" : 2,
          "successful" : 1,
          "failed" : 0
        },
        "_seq_no" : 111395,
        "_primary_term" : 1,
        "status" : 201
      }
    }
    ...

  -- Search for 'to be or not to be' in shakespeare index
  curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/shakespeare/_search?pretty' -d '
  {
  "query" : {
  "match_phrase" : {
  "text_entry" : "to be or not to be"
  }
  }
  }
  '

  {
    "took" : 9317,
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
      "max_score" : 13.889601,
      "hits" : [
        {
          "_index" : "shakespeare",
          "_type" : "_doc",
          "_id" : "34229",
          "_score" : 13.889601,
          "_source" : {
            "type" : "line",
            "line_id" : 34230,
            "play_name" : "Hamlet",
            "speech_number" : 19,
            "line_number" : "3.1.64",
            "speaker" : "HAMLET",
            "text_entry" : "To be, or not to be: that is the question:"
          }
        }
      ]
    }
  }




