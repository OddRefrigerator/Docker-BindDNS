FROM alpine:3.5

ARG	webmin_version=1.880

LABEL maintainer="Stephen.ancliffe@gmail.com"
LABEL webmin=$webmin_version
LABEL bind=""
LABEL perl=""
LABEL description="BIND9 with webmin front end"

#Install Perl for webmin and update openssl
RUN apk --update upgrade && apk add perl perl-net-ssleay openssl bash bash-doc bash-completion grep

#Install webmin
RUN wget  http://prdownloads.sourceforge.net/webadmin/webmin-$webmin_version-minimal.tar.gz -P /etc

WORKDIR /etc
RUN gunzip webmin-$webmin_version-minimal.tar.gz && \
 tar xvf webmin-$webmin_version-minimal.tar && \
 mv webmin-$webmin_version webmin

RUN /etc/webmin/setup.sh

RUN rm -rf /var/cache/apk/*

