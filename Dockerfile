FROM python:3.11-alpine

ENV CONFIG=/etc/prosafe_exporter/config.yml

COPY prosafe_exporter prosafe_exporter

RUN apk add --no-cache --virtual .build-deps gcc libc-dev libxml2-dev libxslt-dev && \
    apk add --no-cache libxslt && \
    apk add --no-cache py3-pip && \
    pip install --upgrade pip && \
    pip install -r ./prosafe_exporter/requirements.txt && \
    pip install -r ./prosafe_exporter/setup_requirements.txt && \
    pip install -r ./prosafe_exporter/test_requirements.txt && \
    pip install ./prosafe_exporter/ && \
    apk del .build-deps

CMD prosafe_exporter ${CONFIG}
