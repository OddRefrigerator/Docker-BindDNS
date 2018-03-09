FROM ubuntu:latest

LABEL maintainer="Stephen.ancliffe@gmail.com"
LABEL description="BIND9 with webmin"

#Ensure we are up to date
RUN apt update && apt upgrade

#Add webmin repository
WORKDIR /etc/apt/sources.list.d
RUN echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list

 #Install wget and add repository key
RUN apt install -y wget
RUN wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -

#Docker specific bug fix
WORKDIR /etc/apt/apt.conf.d
RUN echo "Acquire::GzipIndexes "false";" > docker-gzip-indexes

#Install webmin
RUN apt update

#Load my BASH prefs
RUN wget https://raw.githubusercontent.com/SuperFlea2828/BASHScripts/master/.bashrc -O ~/.bashrc && . ~/.bashrc

EXPOSE 10000






