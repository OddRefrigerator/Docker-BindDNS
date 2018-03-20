FROM ubuntu:latest

LABEL maintainer="Stephen.ancliffe@gmail.com"
LABEL description="BIND9"

# Change root password
#RUN echo root:pass | chpasswd

#Docker specific bug fix
WORKDIR /etc/apt/apt.conf.d
RUN echo "Acquire::GzipIndexes "false";" > docker-gzip-indexes

#Ensure we are up to date
RUN apt update && apt upgrade -y

#Install bind9
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install bind9

#copy bind directory
COPY bind /etc/bind

EXPOSE 53

VOLUME /data

CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f"]



