#!/bin/bash

if [[ -n "${ELASTICSEARCH_URL}" ]]; then
    ELASTICSEARCH_URL=${ELASTICSEARCH_URL#*://}
    ELASTICSEARCH_HOST=${ELASTICSEARCH_URL%:*}
    ELASTICSEARCH_PORT=${ELASTICSEARCH_URL#*:} 
    sed -i "s|ELASTICSEARCH_HOST|${ELASTICSEARCH_HOST}|" /opt/logstash/config/logstash.conf
    sed -i "s|ELASTICSEARCH_PORT|${ELASTICSEARCH_PORT}|" /opt/logstash/config/logstash.conf
elif [[ -n "${ELASTICSEARCH_SERVICE_NAME}" ]]; then
    SVC_HOST=${ELASTICSEARCH_SERVICE_NAME}_SERVICE_HOST
    SVC_PORT=${ELASTICSEARCH_SERVICE_NAME}_SERVICE_PORT
    sed -i "s|ELASTICSEARCH_HOST|${!SVC_HOST}|" /opt/logstash/config/logstash.conf
    sed -i "s|ELASTICSEARCH_PORT|${!SVC_PORT}|" /opt/logstash/config/logstash.conf
fi


exec /opt/logstash/bin/logstash -f /opt/logstash/config/logstash.conf
