RHCE7.0学习笔记之Mariadb
http://www.cnblogs.com/whoisxiaoyan/p/5932614.html
Mariadb配置：

yum groupinstall mariadb mariadb-client

yum grouplist |grep maria

systemctl enable mariadb.service

systemctl restart mariadb.service

firewall-cmd --permanent --add-service=mysql

firewall-cmd --reload

firewall-cmd --permanent --list-all

mysql_secure_installation, 输入root密码，初始为空。

set root password->Remove anon user?yes->Disallow root login?yes->Remove test database?yes->Reload?yes

mysql -uroot -ptianyun; 创建数据库

show databases;

create database concats; show databases;

导入数据库：

mysql -uroot -ptianyun concats < /home/student/mariadb.dump

或者：

use concats; select database();

source /home/student/mariadb.dump;

show tables; 可以看到一张相应的表

授权用户访问， 可能要指定网段

help grant; 查看授权命令

grant select (limitation list) on concats.* to 'luigi@'%

flush privileges 刷新权限列表（系统关键字不分大小写，表名和库名分大小写）

mysql -uluigi -h 172.25.0.11 -ptianyun

use concats; select * from product;

单表查询：

desc product \G 或 desc product;  查看表结构

select * from product where id_category='2'

select count(*) from product where id...

select * from product where ... and ... 下划线_表示匹配一个字符，%表示多个

select * from product where name regexp '^T'; 正则表达式
