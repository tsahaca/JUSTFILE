set positional-arguments := true

default:
  @just --list --unsorted
  

filter PATTERN:
   echo {{PATTERN}}  

publish-order JSON:
  curl http://localhost:9080/tickets/order/publish/order_tanmay -X POST -H 'Content-Type: Application/json' -d @{{JSON}}

alter-config TOPICS MS: 
  #!/bin/bash
     
  RED='\e[31m'
  NOCOLOR='\033[0m'
  GREEN='\e[92m'
  
  TOPICS={{TOPICS}}
  
  echo -e "${GREEN}Altering topics (${TOPICS}) in bootstrap-server=$BOOTSTRAP_SERVERS to retention.ms={{MS}}"
  echo -e ${NOCOLOR}
  
  
  
  # Read a string with spaces using for loop
  for value in $TOPICS
  do
  /c/installed/kafka_2.12-2.5.1/bin/windows/kafka-configs.bat --alter --bootstrap-server $BOOTSTRAP_SERVERS --entity-type topics --entity-name $value --add-config retention.ms={{MS}}
  done

delete-schema TOPIC VERSION:
  curl -X DELETE $REGISTRY/subjects/{{TOPIC}}-value/versions/{{VERSION}}

delete-schema-permanent TOPIC:
  curl -X DELETE $REGISTRY/subjects/{{TOPIC}}-value?permanent=true  
  
delete-all-docs INDEX:
  curl -X POST "$ELASTIC_SEARCH/{{INDEX}}/_delete_by_query?conflicts=proceed" -H 'Content-Type: application/json' -d '{ "query": {  "match_all": {} } }'
  
get-all-docs INDEX:
  curl -X GET  $ELASTIC_SEARCH/{{INDEX}}/_search
   
  
  
