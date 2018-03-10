FROM ubuntu:latest

LABEL maintainer="Stephen.ancliffe@gmail.com"
LABEL description="BIND9 with webmin"

# Change root password
RUN echo root:pass | chpasswd

#Docker specific bug fix
WORKDIR /etc/apt/apt.conf.d
RUN echo "Acquire::GzipIndexes "false";" > docker-gzip-indexes

#Ensure we are up to date
RUN apt update && apt upgrade

#Install wget locales nano ntpdate
RUN apt install -y \
 wget \
 locales\ 
 nano \
 ntpdate
 
#Locale generation
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

#Add webmin repository and repository key
WORKDIR /etc/apt/sources.list.d
RUN echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list
RUN wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -
RUN apt update 

#Install webmin and create log file
RUN apt install -y webmin && touch /var/webmin/miniserv.log && apt autoclean && touch /var/webmin/miniserv.log 

EXPOSE 10000

VOLUME ["/etc/webmin"]

#CMD /usr/sbin/service webmin restart && /usr/bin/tail -f /var/webmin/miniserv.log

RUN apt install -y \
 bind9 \
 dnsutils
