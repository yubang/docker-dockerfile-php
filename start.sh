#!/bin/bash

/var/script/init.sh
service sshd start
setenforce 0

chmod -Rv 777 /var/data

while true ; do
     sleep 100
done
