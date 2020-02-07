FROM python:3.7

COPY Pipfile Pipfile.lock ./
RUN pip3 install --no-cache-dir pipenv
RUN pipenv install --system

COPY cucumber-format.patch /tmp/
RUN \
     cd /usr/local/lib/python3*/site-packages/behave/formatter \
  && patch -p1 < /tmp/cucumber-format.patch \
  && sed -i 's/SECLEVEL=2/SECLEVEL=1/g' /etc/ssl/openssl.cnf

VOLUME /workspace
WORKDIR /workspace
