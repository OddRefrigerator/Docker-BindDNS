FROM alpine:latest

ARG	webmin_version=1.880
ARG install_dir="/etc"

LABEL maintainer="Stephen.ancliffe@gmail.com"
LABEL webmin=$webmin_version
LABEL bind=""
LABEL perl="5.26.1"
LABEL description="BIND9 with webmin"

#Install Perl for webmin and update openssl
RUN apk --update upgrade && apk add perl perl-net-ssleay openssl bash bash-doc bash-completion grep

#Install webmin
RUN wget  http://prdownloads.sourceforge.net/webadmin/webmin-$webmin_version-minimal.tar.gz -P $install_dir 

WORKDIR  $install_dir 
RUN gunzip webmin-$webmin_version-minimal.tar.gz && \
 tar xvf webmin-$webmin_version-minimal.tar && \
 mv webmin-$webmin_version webmin

#RUN  $install_dir/webmin/setup.sh

#RUN rm -rf /var/cache/apk/*

