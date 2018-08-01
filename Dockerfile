FROM python:3-alpine

RUN \
     apk add --no-cache libxslt libxml2 libstdc++ \
  && apk add --no-cache -t .dev g++ python3-dev libxml2-dev libxslt-dev \
  && pip install --no-cache-dir jupyter databaker pandas requests rdflib cachecontrol[filecache] SPARQLWrapper titlecase behave \
  && apk del .dev

COPY cucumber-format.patch /tmp/
RUN \
     cd /usr/local/lib/python3*/site-packages/behave/formatter \
  && patch -p1 < /tmp/cucumber-format.patch

VOLUME /workspace
WORKDIR /workspace
