FROM ubuntu:latest

LABEL maintainer="Stephen.ancliffe@gmail.com"
LABEL description="ubuntu"
LABEL description="BIND9"
LABEL description="stevehome.online"
LABEL description="home.com"

# Change root password
RUN echo root:P@$$w0rd | chpasswd

#Update dist
RUN apt-get update &&\
 apt-get upgrade -y &&\
 DEBIAN_FRONTEND=noninteractive apt-get -y install bind9 &&\
 apt-get clean

#copy named.conf.local
COPY named.conf.local /etc/bind/named.conf.local
RUN chmod 644 /etc/bind/named.conf.local

#copy named.conf.options
COPY named.conf.options /etc/bind/named.conf.options
RUN chmod 644 /etc/bind/named.conf.options

#copy stevehome.online.hosts
COPY stevehome.online.hosts /var/lib/bind/stevehome.online.hosts
RUN chmod 644 /var/lib/bind/stevehome.online.hosts

#copy home.com.hosts
COPY home.com.hosts /var/lib/bind/home.com.hosts
RUN chmod 644 /var/lib/bind/home.com.hosts

#Add start up script
COPY start.sh /usr/local/bin/

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/usr/local/bin/start.sh"]


