#/bin/bash

service mysqld stop
service httpd stop

if [ ! -e "/var/data" ]
then
    mkdir -v /var/data
fi

#复制数据库文件
if [ ! -e "/var/data/db" ]
then
    cp -Rv /var/lib/mysql /var/data/db
    cp -vf /var/script/my.cnf /etc/my.cnf
fi

#创建几个需要的文件夹
if [ ! -e "/var/data/log" ]
then
    mkdir -v /var/data/log
fi

if [ ! -e "/var/data/etc" ]
then
    mkdir -v /var/data/etc
    echo 'PHPIniDir "/var/data/etc/php.ini"' > /var/data/etc/www.conf
    echo "Include /var/data/etc/www.conf" >> /etc/httpd/conf/httpd.conf
    cp -v /etc/php.ini /var/data/etc/php.ini
fi

chmod -Rv 777 /var/data

service mysqld start
service httpd start

