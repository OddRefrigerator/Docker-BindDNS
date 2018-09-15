#!/bin/bash
#: Title : Start bind9
#: Date : 2018-09-15
#: Author : "Stephen Ancliffe" <stephen.ancliffe@gmail.com>
#: Version : 1.0.1
#: Description : =
#: Options : 

named -4 -g -c /etc/bind/named.conf -u bind
