#!/bin/sh

WEBMIN_PORT=10000
WEBMIN_USERNAME=admin
WEBMIN_PASSWORD=webmin

set -e

curl -sL http://prdownloads.sourceforge.net/webadmin/webmin-1.850.tar.gz \
     -o webmin-1.850.tar.gz
tar zxf webmin-1.850.tar.gz
sudo tar zxf webmin-1.850.tar.gz -C /var/lib/
sudo mv /var/lib/webmin-1.850 /var/lib/webmin
rm -rf webmin-1.850.tar.gz
cd /var/lib/webmin
sudo mkdir -p /etc/rc.d/init.d/
cat <<EOF | sudo ./setup.sh
/etc/webmin
/var/log/webmin
/usr/bin/perl
${WEBMIN_PORT}
${WEBMIN_USERNAME}
${WEBMIN_PASSWORD}
${WEBMIN_PASSWORD}
y
EOF
cat <<EOF | sudo tee /etc/init.d/webmin
#!/sbin/openrc-run
WEBMIN=/etc/rc.d/init.d/webmin
start() { \${WEBMIN} start; }
stop() { \${WEBMIN} start; }
EOF
sudo chmod a+x /etc/init.d/webmin

sudo rc-update add webmin
sudo rc-service webmin start