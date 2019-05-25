FROM postgres:9.6-alpine

ENV PGTAP_VERSION v1.0.0

RUN apk update && apk upgrade \
  && apk add perl \
  && apk add --virtual build-deps git make perl-utils \
  && git clone git://github.com/theory/pgtap.git \
  && cd pgtap \
  && git checkout tags/$PGTAP_VERSION \
  && make && make install && cd .. && cpan TAP::Parser::SourceHandler::pgTAP \
  && apk del build-deps

COPY create_extension_pgtap.sql /docker-entrypoint-initdb.d/
