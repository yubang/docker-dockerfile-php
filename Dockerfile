#php环境

#版本1 2015-06-28
#一些小说明，现在安装的软件都使用yum方式安装，所以版本可能很低
#共享文件，容器内的/var/data目录需共享到主机
#/var/data/db mysql数据文件 
#/var/data/log 日记目录
#/var/data/etc/www.conf apache配置文件
#/var/data/etc/php.ini php配置文件
#root用户的密码默认为root

FROM centos:6

#yubang打包的镜像，为了开发php应用
MAINTAINER yubang cybzxc@163.com

#安装常用软件
RUN yum -y install vim
RUN yum -y install openssh-server
RUN yum -y install tar
RUN yum -y install wget
RUN yum -y install unzip

#安装apache php mysql
RUN yum -y install httpd
RUN yum -y install mysql mysql-server
RUN yum -y install php
RUN yum -y install php-mysql
RUN yum -y install php-xml php-gd
RUN yum -y install php-mbstring
RUN yum -y install epel-release
RUN yum -y install php-mcrypt

#修改mysql密码为root
RUN service mysqld start && mysqladmin -u root password root && service mysqld restart && service mysqld stop

RUN mkdir -v /var/script

#修改容器root密码为root
#echo '密码'| passwd --stdin 用户名
RUN echo 'root'| passwd --stdin root

#执行初始化脚本
ADD init.sh /var/script/init.sh
ADD my.cnf /var/script/my.cnf
RUN chmod -v +x /var/script/init.sh

#放置容器启动脚本
ADD start.sh /var/script/start.sh
RUN chmod -v +x /var/script/start.sh

#共享文件夹
VOLUME ["/var/data"]

#转发端口
EXPOSE 22 80

#容器启动执行脚本
ENTRYPOINT ["/var/script/start.sh"]
