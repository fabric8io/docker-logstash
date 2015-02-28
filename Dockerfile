FROM java:8-jre

MAINTAINER Douglas Palmer <dpalmer@redhat.com>

ENV LOGSTASH_VERSION 1.4.2

RUN apt-get update && apt-get install -y wget ca-certificates && rm -rf /var/lib/apt/lists/*

RUN wget -qO- https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz | tar xzv -C /opt && \
    ln -s /opt/logstash* /opt/logstash

ADD logstash.conf /opt/logstash/config/logstash.conf

ADD run.sh /run.sh

CMD ["/run.sh"]
