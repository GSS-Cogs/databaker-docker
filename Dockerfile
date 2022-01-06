FROM python:3.9

ENV PIPENV_TIMEOUT=36000 

COPY requirements.git.txt requirements.pypi.txt requirements-dev.git.txt requirements-dev.pypi.txt ./

ARG dev

# Only install dev package in dev
RUN if [ "$dev" = "true" ] ; \
    then pip install -r requirements-dev.pypi.txt && install -r requirements-dev.git.txt  ; \
    else pip install -r requirements.pypi.txt && install -r requirements.git.txt ; \
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
