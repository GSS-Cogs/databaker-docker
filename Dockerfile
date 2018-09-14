FROM python:3.7

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

COPY cucumber-format.patch /tmp/
RUN \
     cd /usr/local/lib/python3*/site-packages/behave/formatter \
  && patch -p1 < /tmp/cucumber-format.patch

VOLUME /workspace
WORKDIR /workspace
