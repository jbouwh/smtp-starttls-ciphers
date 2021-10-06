### Dockerfile for building latest OpenSSL

FROM alpine:3.12

MAINTAINER Jan Bouwhuis <jan@jbsoft.nl>

RUN set -x \
    && apk add --no-cache \
        bash \
        wget \
        gcc \
        tar \
        alpine-sdk \
        perl \
        linux-headers \
        bind-tools \
    && rm -rf /var/cache/apk/*

# INSTALLATION

ENV OPENSSL_VERSION="1.1.1k"

RUN set -x \
 ### BUILD OpenSSL
 && wget --no-check-certificate -O /tmp/openssl-${OPENSSL_VERSION}.tar.gz "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz" \
 && tar -xvf /tmp/openssl-${OPENSSL_VERSION}.tar.gz -C /tmp/ \
 && rm -rf /tmp/openssl-${OPENSSL_VERSION}.tar.gz \ 
 && cd /tmp/openssl-${OPENSSL_VERSION} \
 && ./config no-shared enable-weak-ssl-ciphers -DOPENSSL_TLS_SECURITY_LEVEL=0 \
 && make depend \
 && make \
 && make test \
 && make install_sw \
 && cd .. \
 && rm -rf openssl-${OPENSSL_VERSION}
 
ENV LDNS_VERSION="1.7.1"

RUN set -x \
 ### BUILD dane-utils
 && wget --no-check-certificate -O /tmp/ldns-${LDNS_VERSION}.tar.gz "https://www.nlnetlabs.nl/downloads/ldns/ldns-${LDNS_VERSION}.tar.gz" \
 && tar -xvf /tmp/ldns-${LDNS_VERSION}.tar.gz -C /tmp/ \
 && rm -rf /tmp/ldns-${LDNS_VERSION}.tar.gz \ 
 && cd /tmp/ldns-${LDNS_VERSION} \
 && ./configure --with-examples --with-drill \
 && make \
 && make install \
 && cd .. \
 && rm -rf ldns-${LDNS_VERSION}
 
ENV PATH /usr/local/ssl/bin:$PATH
 
RUN adduser -D -u 1000 openssl-test

WORKDIR /home/openssl-test

COPY dane-check getmx starttls-ciphers /usr/local/bin/

USER openssl-test
