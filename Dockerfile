FROM python:3.9

ENV PIPENV_TIMEOUT=36000 

COPY Pipfile Pipfile.lock ./
ENV PIP_NO_CACHE_DIR=false
RUN pip install pipenv

ARG dev

# Only install dev package in dev
RUN if [ "$dev" = "true" ] ; \
    then pipenv install --ignore-pipfile --deploy --system --dev; \
    else pipenv install --ignore-pipfile --deploy --system ; \
    fi
  
# Only install gnupg2 in dev
RUN if [ "$dev" = "true" ] ; \
    then apt-get update && apt-get install gnupg2 -y ; \
    fi

COPY cucumber-format.patch /tmp/
RUN cd /usr/local/lib/python3*/site-packages/behave/formatter \
    && patch -p1 < /tmp/cucumber-format.patch \
    && sed -i 's/SECLEVEL=2/SECLEVEL=1/g' /etc/ssl/openssl.cnf

VOLUME /workspace
WORKDIR /workspace
