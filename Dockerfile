FROM python:3.8

ENV PIPENV_TIMEOUT=36000 

COPY Pipfile Pipfile.lock ./
ENV PIP_NO_CACHE_DIR=false
RUN pip install pipenv
RUN pipenv sync --system

COPY cucumber-format.patch /tmp/
RUN cd /usr/local/lib/python3*/site-packages/behave/formatter \
    && patch -p1 < /tmp/cucumber-format.patch \
    && sed -i 's/SECLEVEL=2/SECLEVEL=1/g' /etc/ssl/openssl.cnf

VOLUME /workspace
WORKDIR /workspace
