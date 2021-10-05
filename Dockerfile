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
    && rm -rf /var/cache/apk/*

# INSTALLATION

ENV OPENSSL_VERSION="1.0.2u"

RUN set -x \
 ### BUILD OpenSSL
 && wget --no-check-certificate -O /tmp/openssl-${OPENSSL_VERSION}.tar.gz "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz" \
 && tar -xvf /tmp/openssl-${OPENSSL_VERSION}.tar.gz -C /tmp/ \
 && rm -rf /tmp/openssl-${OPENSSL_VERSION}.tar.gz \ 
 && cd /tmp/openssl-${OPENSSL_VERSION} \
 && ./config enable-ssl2 enable-ssl3 no-shared enable-weak-ssl-ciphers -DOPENSSL_TLS_SECURITY_LEVEL=0 \
 && make depend \
 && make \
 && make test \
 && make install \
 && cd .. \
 && rm -rf openssl-${OPENSSL_VERSION}
 
ENV PATH /usr/local/ssl/bin:$PATH
 
RUN adduser -D -u 1000 openssl-test

WORKDIR /home/openssl-test

COPY dane-check getmx starttls-ciphers /usr/local/bin/

USER openssl-test
