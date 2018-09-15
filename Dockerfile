FROM ubuntu:latest

LABEL maintainer="Stephen.ancliffe@gmail.com"
LABEL description="BIND9"

# Change root password
RUN echo root:password | chpasswd

RUN apt-get update \
 && apt-get upgrade -y

#Install BIND9
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install bind9


#copy named.conf.local
COPY named.conf.local /etc/bind/named.conf.local
RUN chmod 644 /etc/bind/named.conf.local

#copy stevehome.online.hosts
COPY stevehome.online.hosts /var/lib/bind/stevehome.online.hosts
RUN chmod 644 /var/lib/bind/stevehome.online.hosts


EXPOSE 53/udp 53/tcp

ADD start.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/start.sh"]


