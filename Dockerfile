FROM python:3.9

COPY pyproject.toml poetry.lock ./
ENV PIP_NO_CACHE_DIR=false
RUN pip install poetry

ARG dev

# Only install dev package in dev
RUN if [ "$dev" = "true" ] ; \
    then poetry export --format requirements.txt --output requirements.txt --without-hashes --with dev ; \
    else poetry export --format requirements.txt --output requirements.txt --without-hashes ; \
    fi

RUN pip install -r requirements.txt
  
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
