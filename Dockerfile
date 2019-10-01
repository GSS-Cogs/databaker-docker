FROM ubuntu:latest

RUN apt-get update \
  && apt-get install -y git \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

COPY cucumber-format.patch /tmp/
RUN \
     cd /usr/local/lib/python3*/dist-packages/behave/formatter \
  && patch -p1 < /tmp/cucumber-format.patch

VOLUME /workspace
WORKDIR /workspace
