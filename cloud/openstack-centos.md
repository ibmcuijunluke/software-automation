http://blog.csdn.net/xiegh2014/article/details/51526424
1、需要安装yum源
yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install -y centos-release-openstack-liberty
yum install -y python-openstackclient
yum install -y mariadb mariadb-server MySQL-python
yum install -y rabbitmq-server
yum install -y openstack-keystone httpd mod_wsgi memcached python-memcached
yum install -y openstack-glance python-glance python-glanceclient
yum install -y openstack-nova-api openstack-nova-cert openstack-nova-conductor openstack-nova-console openstack-nova-novncproxy openstack-nova-scheduler python-novaclient
yum install -y openstack-neutron openstack-neutron-ml2 openstack-neutron-linuxbridge python-neutronclient ebtables ipset
yum install -y openstack-dashboard
yum install -y vim  tree unzip lrzsz
计算机节点所需包
yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install -y centos-release-openstack-liberty
yum install -y python-openstackclient
yum install -y openstack-nova-compute sysfsutils
yum install -y openstack-neutron openstack-neutron-linuxbridge ebtables ipset
yum -y install vim  tree unzip lrzsz
2、关闭selinux
[root@control-node0 ~]# setenforce 0  
[root@control-node0 ~]# sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config

3、关闭防火墙
[root@control-node0 ~]# systemctl stop firewalld.service
[root@control-node0 ~]# systemctl disable firewalld.service

4、时间同步
[root@control-node0 ~]# yum install -y chrony
[root@control-node0 ~]# vi /etc/chrony.conf
打开注释
allow 192.168/16
修改为
allow 10.0.0.0/24

5、启动时间同步
[root@control-node0 ~]# systemctl enable chronyd.service
[root@control-node0 ~]# systemctl start chronyd.service

6、时区设置
[root@control-node0 ~]# timedatectl set-timezone Asia/Shanghai
[root@control-node0 ~]# date
Fri May 27 10:47:26 CST 2016
修改数据库配置文件
[root@control-node0 ~]# cp /usr/share/mysql/my-medium.cnf /etc/my.cnf
cp: overwrite ‘/etc/my.cnf’? y
[root@control-node0 ~]# vim /etc/my.cnf
将配置参数添加到mysqld下面
default-storage-engine = innodb
innodb_file_per_table
collation-server = utf8_general_ci
init-connect = 'SET NAMES utf8'
character-set-server = utf8


[mysqld]
default-storage-engine = innodb
innodb_file_per_table
collation-server = utf8_general_ci
init-connect = 'SET NAMES utf8'
character-set-server = utf8


设置开机mysql自动启动
[root@control-node0 ~]# systemctl enable mariadb.service
ln -s '/usr/lib/systemd/system/mariadb.service' '/etc/systemd/system/multi-user.target.wants/mariadb.service'
[root@control-node0 ~]# systemctl start mariadb.service
Mysql设置密码
[root@control-node0 ~]# mysql_secure_installation
/usr/bin/mysql_secure_installation: line 379: find_mysql_client: command not found


NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!


In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none): 回车
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] y
New password: --设置密码
Re-enter new password: --设置密码
Password updated successfully!
Reloading privilege tables..
 ... Success!

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!

测试是否能登陆
[root@control-node0 ~]# mysql -uroot -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 10
Server version: 5.5.47-MariaDB-log MariaDB Server


Copyright (c) 2000, 2015, Oracle, MariaDB Corporation Ab and others.


Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


MariaDB [(none)]>


创建数据库
#keystone数据库
mysql -u root -p -e "CREATE DATABASE keystone;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'keystone';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'keystone';"
#Glance数据库
mysql -u root -p -e "CREATE DATABASE glance;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY 'glance';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' IDENTIFIED BY 'glance';"
#Nova数据库
mysql -u root -p -e "CREATE DATABASE nova;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' IDENTIFIED BY 'nova';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY 'nova';"
#Neutron 数据库
mysql -u root -p -e "CREATE DATABASE neutron;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY 'neutron';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' IDENTIFIED BY 'neutron';"
#Cinder数据库
mysql -u root -p -e "CREATE DATABASE cinder;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' IDENTIFIED BY 'cinder';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' IDENTIFIED BY 'cinder';"


查看数据创建情况
[root@control-node0 ~]# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 27
Server version: 5.5.47-MariaDB-log MariaDB Server


Copyright (c) 2000, 2015, Oracle, MariaDB Corporation Ab and others.


Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| cinder             |
| glance             |
| keystone           |
| mysql              |
| neutron            |
| nova               |
| performance_schema |
+--------------------+
8 rows in set (0.00 sec)


rabbitmq消息服务器
rabbitmq服务开机自动启动
[root@control-node0 ~]# systemctl enable rabbitmq-server.service
ln -s '/usr/lib/systemd/system/rabbitmq-server.service' '/etc/systemd/system/multi-user.target.wants/rabbitmq-server.service'
[root@control-node0 ~]# systemctl start rabbitmq-server.service


查看端口：rabbitmq的端口是5672
[root@control-node0 ~]# netstat -ntlp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:25672           0.0.0.0:*               LISTEN      38345/beam          
tcp        0      0 0.0.0.0:3306            0.0.0.0:*               LISTEN      38154/mysqld        
tcp        0      0 0.0.0.0:4369            0.0.0.0:*               LISTEN      38360/epmd          
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      964/sshd            
tcp6       0      0 :::5672                 :::*                    LISTEN      38345/beam          
tcp6       0      0 :::4369                 :::*                    LISTEN      38360/epmd          
tcp6       0      0 :::22                   :::*                    LISTEN      964/sshd  


创建openstack的用户名和密码
[root@control-node0 ~]# rabbitmqctl add_user openstack openstack
Creating user "openstack" ...
...done.


用户授权
[root@control-node0 ~]# rabbitmqctl set_permissions openstack ".*" ".*" ".*"
Setting permissions for user "openstack" in vhost "/" ...
...done.


列出rabbitmq的插件
[root@control-node0 ~]# rabbitmq-plugins list
[ ] amqp_client                       3.3.5
[ ] cowboy                            0.5.0-rmq3.3.5-git4b93c2d
[ ] eldap                             3.3.5-gite309de4
[ ] mochiweb                          2.7.0-rmq3.3.5-git680dba8
[ ] rabbitmq_amqp1_0                  3.3.5
[ ] rabbitmq_auth_backend_ldap        3.3.5
[ ] rabbitmq_auth_mechanism_ssl       3.3.5
[ ] rabbitmq_consistent_hash_exchange 3.3.5
[ ] rabbitmq_federation               3.3.5
[ ] rabbitmq_federation_management    3.3.5
[ ] rabbitmq_management               3.3.5
[ ] rabbitmq_management_agent         3.3.5
[ ] rabbitmq_management_visualiser    3.3.5
[ ] rabbitmq_mqtt                     3.3.5
[ ] rabbitmq_shovel                   3.3.5
[ ] rabbitmq_shovel_management        3.3.5
[ ] rabbitmq_stomp                    3.3.5
[ ] rabbitmq_test                     3.3.5
[ ] rabbitmq_tracing                  3.3.5
[ ] rabbitmq_web_dispatch             3.3.5
[ ] rabbitmq_web_stomp                3.3.5
[ ] rabbitmq_web_stomp_examples       3.3.5
[ ] sockjs                            0.3.4-rmq3.3.5-git3132eb9
[ ] webmachine                        1.10.3-rmq3.3.5-gite9359c7


rabbitmq管理插件启动
[root@control-node0 ~]# rabbitmq-plugins enable rabbitmq_management
The following plugins have been enabled:
  mochiweb
  webmachine
  rabbitmq_web_dispatch
  amqp_client
  rabbitmq_management_agent
  rabbitmq_management
Plugin configuration has changed. Restart RabbitMQ for changes to take effect.


重新启动rabbitmq
[root@control-node0 ~]# systemctl restart rabbitmq-server.service




再次查看监听的端口：web管理端口:15672
[root@control-node0 ~]# netstat -lntup
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:25672           0.0.0.0:*               LISTEN      38649/beam          
tcp        0      0 0.0.0.0:3306            0.0.0.0:*               LISTEN      38154/mysqld        
tcp        0      0 0.0.0.0:4369            0.0.0.0:*               LISTEN      38666/epmd          
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      964/sshd            
tcp        0      0 0.0.0.0:15672           0.0.0.0:*               LISTEN      38649/beam          
tcp6       0      0 :::5672                 :::*                    LISTEN      38649/beam          
tcp6       0      0 :::4369                 :::*                    LISTEN      38666/epmd          
tcp6       0      0 :::22                   :::*                    LISTEN      964/sshd            
udp        0      0 127.0.0.1:323           0.0.0.0:*                           2094/chronyd        
udp6       0      0 ::1:323                 :::*                                2094/chronyd


打开http://10.0.0.80:15672  用户名 guest      密码 guest
登录进去之后：
Admin------->复制administrator------->点击openstack------>Update this user-------->
Tags:粘帖administrator--------->密码都设置为openstack-------->logout
然后在登陆：用户名 openstack  密码  openstack




Keystone 验证服务
[root@control-node0 ~]# openssl rand -hex 10
8097f01ca96d056655cf


[root@control-node0 ~]# grep -n '^[a-z]'  /etc/keystone/keystone.conf
12:admin_token = 8097f01ca96d056655cf
107:verbose = true
495:connection = mysql://keystone:keystone@10.0.0.80/keystone
1313:servers = 10.0.0.80:11211
1349:driver = sql
1911:provider = uuid
1916:driver = memcache


同步数据库：注意权限，所以要用su -s 切换到keystone用户下执行：
[root@control-node0 ~]# su -s /bin/sh -c "keystone-manage db_sync" keystone
No handlers could be found for logger "oslo_config.cfg"


验证数据是否创建成功
[root@control-node0 ~]# mysql -ukeystone -pkeystone
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 29
Server version: 5.5.47-MariaDB-log MariaDB Server


Copyright (c) 2000, 2015, Oracle, MariaDB Corporation Ab and others.


Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


MariaDB [(none)]> use keystone
Database changed
MariaDB [keystone]> show tables;
+------------------------+
| Tables_in_keystone     |
+------------------------+
| access_token           |
| assignment             |
| config_register        |
| consumer               |
| credential             |
| domain                 |
| endpoint               |
| endpoint_group         |
| federation_protocol    |
| group                  |
| id_mapping             |
| identity_provider      |
| idp_remote_ids         |
| mapping                |
| migrate_version        |
| policy                 |
| policy_association     |
| project                |
| project_endpoint       |
| project_endpoint_group |
| region                 |
| request_token          |
| revocation_event       |
| role                   |
| sensitive_config       |
| service                |
| service_provider       |
| token                  |
| trust                  |
| trust_role             |
| user                   |
| user_group_membership  |
| whitelisted_config     |
+------------------------+
33 rows in set (0.00 sec)




启动memcache服务
[root@control-node0 ~]# systemctl enable memcached
ln -s '/usr/lib/systemd/system/memcached.service' '/etc/systemd/system/multi-user.target.wants/memcached.service'
[root@control-node0 ~]# systemctl start memcached.service




新建keystone配置文件，并用apache来代理它：5000  正常的api来访问  35357  管理访问的端口
[root@control-node0 ~]# vim /etc/httpd/conf.d/wsgi-keystone.conf
Listen 5000
Listen 35357


<VirtualHost *:5000>
    WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
    WSGIProcessGroup keystone-public
    WSGIScriptAlias / /usr/bin/keystone-wsgi-public
    WSGIApplicationGroup %{GLOBAL}
    WSGIPassAuthorization On
    <IfVersion >= 2.4>
      ErrorLogFormat "%{cu}t %M"
    </IfVersion>
    ErrorLog /var/log/httpd/keystone-error.log
    CustomLog /var/log/httpd/keystone-access.log combined


    <Directory /usr/bin>
        <IfVersion >= 2.4>
            Require all granted
        </IfVersion>
        <IfVersion < 2.4>
            Order allow,deny
            Allow from all
        </IfVersion>
    </Directory>
</VirtualHost>


<VirtualHost *:35357>
    WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
    WSGIProcessGroup keystone-admin
    WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
    WSGIApplicationGroup %{GLOBAL}
    WSGIPassAuthorization On
    <IfVersion >= 2.4>
      ErrorLogFormat "%{cu}t %M"
    </IfVersion>
    ErrorLog /var/log/httpd/keystone-error.log
    CustomLog /var/log/httpd/keystone-access.log combined


    <Directory /usr/bin>
        <IfVersion >= 2.4>
            Require all granted
        </IfVersion>
        <IfVersion < 2.4>
            Order allow,deny
            Allow from all
        </IfVersion>
    </Directory>
</VirtualHost>


必须要配置httpd的ServerName,否则keystone服务不能起来
[root@control-node0 ~]# vi /etc/httpd/conf/httpd.conf
ServerName 10.0.0.80:80
[root@control-node0 ~]# grep -n '^ServerName' /etc/httpd/conf/httpd.conf      
95:ServerName 10.0.0.80:80


启动memcache与httpd服务
[root@control-node0 ~]# systemctl enable httpd
ln -s '/usr/lib/systemd/system/httpd.service' '/etc/systemd/system/multi-user.target.wants/httpd.service'
[root@control-node0 ~]# systemctl start httpd


查看端口
[root@control-node0 ~]# netstat -lntup|grep httpd
tcp6       0      0 :::5000                 :::*                    LISTEN      39324/httpd         
tcp6       0      0 :::80                   :::*                    LISTEN      39324/httpd         
tcp6       0      0 :::35357                :::*                    LISTEN      39324/httpd       


创建验证用户及地址版本信息
[root@control-node0 ~]# grep -n '^admin_token' /etc/keystone/keystone.conf
12:admin_token = 8097f01ca96d056655cf


[root@control-node0 ~]# export OS_TOKEN=8097f01ca96d056655cf
[root@control-node0 ~]# export OS_URL=http://10.0.0.80:35357/v3
[root@control-node0 ~]# export OS_IDENTITY_API_VERSION=3
[root@control-node0 ~]# env
XDG_SESSION_ID=9
HOSTNAME=control-node0.xiegh.com
TERM=xterm
SHELL=/bin/bash
HISTSIZE=1000
SSH_CLIENT=10.0.0.1 62126 22
SSH_TTY=/dev/pts/1
USER=root
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:
MAIL=/var/spool/mail/root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
OS_IDENTITY_API_VERSION=3
PWD=/root
LANG=en_US.UTF-8
HISTCONTROL=ignoredups
OS_TOKEN=8097f01ca96d056655cf
SHLVL=1
HOME=/root
LOGNAME=root
SSH_CONNECTION=10.0.0.1 62126 10.0.0.80 22
LESSOPEN=||/usr/bin/lesspipe.sh %s
OS_URL=http://10.0.0.80:35357/v3
XDG_RUNTIME_DIR=/run/user/0
_=/usr/bin/env


创建租户用户
[root@control-node0 ~]# openstack project create --domain default   --description "Admin Project" admin
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | Admin Project                    |
| domain_id   | default                          |
| enabled     | True                             |
| id          | b5a578cfdb4848dba2b91dd38d1e2b93 |
| is_domain   | False                            |
| name        | admin                            |
| parent_id   | None                             |
+-------------+----------------------------------+
创建admin的用户
[root@control-node0 ~]# openstack user create --domain default --password-prompt admin
User Password:admin
Repeat User Password:admin
+-----------+----------------------------------+
| Field     | Value                            |
+-----------+----------------------------------+
| domain_id | default                          |
| enabled   | True                             |
| id        | ad4f6c3d88a047d6802a05735a03ba8f |
| name      | admin                            |
+-----------+----------------------------------+
创建admin的角色
[root@control-node0 ~]# openstack role create admin
+-------+----------------------------------+
| Field | Value                            |
+-------+----------------------------------+
| id    | 0b546d54ed7f467fa90f18bb899452d3 |
| name  | admin                            |
+-------+----------------------------------+
把admin用户加入到admin项目，并赋予admin的角色
[root@control-node0 ~]# openstack role add --project admin --user admin admin


创建普通用户密码及角色
[root@control-node0 ~]# openstack project create --domain default --description "Demo Project" demo
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | Demo Project                     |
| domain_id   | default                          |
| enabled     | True                             |
| id          | 5f4aaeb328f049ddbfe2717ded103c67 |
| is_domain   | False                            |
| name        | demo                             |
| parent_id   | None                             |
+-------------+----------------------------------+
[root@control-node0 ~]# openstack user create --domain default --password=demo demo
+-----------+----------------------------------+
| Field     | Value                            |
+-----------+----------------------------------+
| domain_id | default                          |
| enabled   | True                             |
| id        | 46dc3686bc0a4ea6b8d09505603ccecc |
| name      | demo                             |
+-----------+----------------------------------+
[root@control-node0 ~]# openstack role create user
+-------+----------------------------------+
| Field | Value                            |
+-------+----------------------------------+
| id    | 314a22500bf042ba9a970701e2c39998 |
| name  | user                             |
+-------+----------------------------------+
[root@control-node0 ~]# openstack role add --project demo --user demo user


创建一个Service的项目
[root@control-node0 ~]# openstack project create --domain default --description "Service Project" service
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | Service Project                  |
| domain_id   | default                          |
| enabled     | True                             |
| id          | de068df7bbad42379c0c6050fa306fbb |
| is_domain   | False                            |
| name        | service                          |
| parent_id   | None                             |
+-------------+----------------------------------+


查看创建的用户及角色
[root@control-node0 ~]# openstack user list
+----------------------------------+-------+
| ID                               | Name  |
+----------------------------------+-------+
| 46dc3686bc0a4ea6b8d09505603ccecc | demo  |
| ad4f6c3d88a047d6802a05735a03ba8f | admin |
+----------------------------------+-------+
[root@control-node0 ~]#  openstack role list
+----------------------------------+-------+
| ID                               | Name  |
+----------------------------------+-------+
| 0b546d54ed7f467fa90f18bb899452d3 | admin |
| 314a22500bf042ba9a970701e2c39998 | user  |
+----------------------------------+-------+
[root@control-node0 ~]# openstack project list
+----------------------------------+---------+
| ID                               | Name    |
+----------------------------------+---------+
| 5f4aaeb328f049ddbfe2717ded103c67 | demo    |
| b5a578cfdb4848dba2b91dd38d1e2b93 | admin   |
| de068df7bbad42379c0c6050fa306fbb | service |
+----------------------------------+---------+


keystone本身也需要注册
[root@control-node0 ~]# openstack service create --name keystone --description "OpenStack Identity" identity
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | OpenStack Identity               |
| enabled     | True                             |
| id          | d632e3036b974943978631b9cabcafe0 |
| name        | keystone                         |
| type        | identity                         |
+-------------+----------------------------------+


公共的api接口
[root@control-node0 ~]# openstack endpoint create --region RegionOne identity public http://10.0.0.80:5000/v2.0
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | 1a8eb7b97ff64c56886942a38054b9bb |
| interface    | public                           |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | d632e3036b974943978631b9cabcafe0 |
| service_name | keystone                         |
| service_type | identity                         |
| url          | http://10.0.0.80:5000/v2.0       |
+--------------+----------------------------------+


私有的api接口
[root@control-node0 ~]# openstack endpoint create --region RegionOne identity internal http://10.0.0.80:5000/v2.0
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | 4caf182c26dd457ba86d9974dfb00c1b |
| interface    | internal                         |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | d632e3036b974943978631b9cabcafe0 |
| service_name | keystone                         |
| service_type | identity                         |
| url          | http://10.0.0.80:5000/v2.0       |
+--------------+----------------------------------+
管理的api接口
[root@control-node0 ~]# openstack endpoint create --region RegionOne identity admin http://10.0.0.80:35357/v2.0
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | 34c8185306c340a0bb4efbfc9da21003 |
| interface    | admin                            |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | d632e3036b974943978631b9cabcafe0 |
| service_name | keystone                         |
| service_type | identity                         |
| url          | http://10.0.0.80:35357/v2.0      |
+--------------+----------------------------------+
查看api接口
[root@control-node0 ~]# openstack endpoint list
+----------------------------------+-----------+--------------+--------------+---------+-----------+-----------------------------+
| ID                               | Region    | Service Name | Service Type | Enabled | Interface | URL                         |
+----------------------------------+-----------+--------------+--------------+---------+-----------+-----------------------------+
| 1a8eb7b97ff64c56886942a38054b9bb | RegionOne | keystone     | identity     | True    | public    | http://10.0.0.80:5000/v2.0  |
| 34c8185306c340a0bb4efbfc9da21003 | RegionOne | keystone     | identity     | True    | admin     | http://10.0.0.80:35357/v2.0 |
| 4caf182c26dd457ba86d9974dfb00c1b | RegionOne | keystone     | identity     | True    | internal  | http://10.0.0.80:5000/v2.0  |
+----------------------------------+-----------+--------------+--------------+---------+-----------+-----------------------------+




使用用户名密码的方式登录：必须要先取消环境变量
[root@control-node0 ~]# unset OS_TOKEN
[root@control-node0 ~]# unset OS_URL
[root@control-node0 ~]# openstack --os-auth-url http://10.0.0.80:35357/v3 --os-project-domain-id default --os-user-domain-id default --os-project-name admin --os-username admin --os-auth-type password token issue
Password:
+------------+----------------------------------+
| Field      | Value                            |
+------------+----------------------------------+
| expires    | 2016-05-27T05:25:30.193235Z      |
| id         | 4e8c0c1e0f20481d959c977db7f689b6 |
| project_id | b5a578cfdb4848dba2b91dd38d1e2b93 |
| user_id    | ad4f6c3d88a047d6802a05735a03ba8f |
+------------+----------------------------------+


便快捷的使用keystone,我们需要设置两个环境变量：


[root@control-node0 ~]# cat admin-openrc.sh
export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default
export OS_PROJECT_NAME=admin
export OS_TENANT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_AUTH_URL=http://10.0.0.80:35357/v3
export OS_IDENTITY_API_VERSION=3
[root@control-node0 ~]# cat demo-openrc.sh
export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default
export OS_PROJECT_NAME=demo
export OS_TENANT_NAME=demo
export OS_USERNAME=demo
export OS_PASSWORD=demo
export OS_AUTH_URL=http://10.0.0.80:5000/v3
export OS_IDENTITY_API_VERSION=3
添加执行权限
[root@control-node0 ~]# chmod +x admin-openrc.sh demo-openrc.sh


测试获取TOKEN
[root@control-node0 ~]# source admin-openrc.sh
[root@control-node0 ~]# openstack token issue
+------------+----------------------------------+
| Field      | Value                            |
+------------+----------------------------------+
| expires    | 2016-05-27T05:30:03.600977Z      |
| id         | 409443b07f5948f2a437443090927621 |
| project_id | b5a578cfdb4848dba2b91dd38d1e2b93 |
| user_id    | ad4f6c3d88a047d6802a05735a03ba8f |
+------------+----------------------------------+


Glance部署


修改配置文件添加数据库连接glance-api.conf与glance-registry.conf
[root@control-node0 ~]# vim /etc/glance/glance-api.conf
[root@control-node0 ~]# vim /etc/glance/glance-registry.conf
[root@control-node0 ~]# grep -n '^connection' /etc/glance/glance-api.conf
538:connection=mysql://glance:glance@10.0.0.80/glance
[root@control-node0 ~]# grep -n '^connection' /etc/glance/glance-registry.conf
363:connection=mysql://glance:glance@10.0.0.80/glance


同步数据库
[root@control-node0 ~]# su -s /bin/sh -c "glance-manage db_sync" glance
No handlers could be found for logger "oslo_config.cfg"


查看数据库同步是否成功
[root@control-node0 ~]#  mysql -uglance -pglance -h 10.0.0.80
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 36
Server version: 5.5.47-MariaDB-log MariaDB Server


Copyright (c) 2000, 2015, Oracle, MariaDB Corporation Ab and others.


Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
MariaDB [(none)]> use glance;
Database changed
MariaDB [glance]> show tables
    -> ;
+----------------------------------+
| Tables_in_glance                 |
+----------------------------------+
| artifact_blob_locations          |
| artifact_blobs                   |
| artifact_dependencies            |
| artifact_properties              |
| artifact_tags                    |
| artifacts                        |
| image_locations                  |
| image_members                    |
| image_properties                 |
| image_tags                       |
| images                           |
| metadef_namespace_resource_types |
| metadef_namespaces               |
| metadef_objects                  |
| metadef_properties               |
| metadef_resource_types           |
| metadef_tags                     |
| migrate_version                  |
| task_info                        |
| tasks                            |
+----------------------------------+
20 rows in set (0.00 sec)


创建glance用户
[root@control-node0 ~]# source admin-openrc.sh
[root@control-node0 ~]# openstack user create --domain default --password=glance glance
+-----------+----------------------------------+
| Field     | Value                            |
+-----------+----------------------------------+
| domain_id | default                          |
| enabled   | True                             |
| id        | 9009c0e0431646d193744d445411a0ab |
| name      | glance                           |
+-----------+----------------------------------+


将此用户加入到项目里面并给它赋予admin的权限
[root@control-node0 ~]# openstack role add --project service --user glance admin


配置keystone与glance-api.conf的链接
[root@control-node0 ~]# vim  /etc/glance/glance-api.conf
[root@control-node0 ~]# grep -n ^[a-z]  /etc/glance/glance-api.conf
363:verbose=True
491:notification_driver = noop
538:connection=mysql://glance:glance@10.0.0.80/glance
642:default_store=file
701:filesystem_store_datadir=/var/lib/glance/images/
974:auth_uri = http://10.0.0.80:5000
975:auth_url = http://10.0.0.80:35357
976:auth_plugin = password
977:project_domain_id = default
978:user_domain_id = default
979:project_name = service
980:username = glance
981:password = glance
1484:flavor= keystone


配置keystone与glance-registry.conf的链接
[root@control-node0 ~]# grep -n '^[a-z]' /etc/glance/glance-registry.conf
363:connection=mysql://glance:glance@10.0.0.80/glance
767:auth_uri = http://10.0.0.80:5000
768:auth_url = http://10.0.0.80:35357
769:auth_plugin = password
770:project_domain_id = default
771:user_domain_id = default
772:project_name = service
773:username = glance
774:password = glance
1256:flavor=keystone


启动glance服务并设置开机启动
[root@control-node0 ~]# systemctl enable openstack-glance-api
ln -s '/usr/lib/systemd/system/openstack-glance-api.service' '/etc/systemd/system/multi-user.target.wants/openstack-glance-api.service'
[root@control-node0 ~]# systemctl enable openstack-glance-registry
ln -s '/usr/lib/systemd/system/openstack-glance-registry.service' '/etc/systemd/system/multi-user.target.wants/openstack-glance-registry.service'


[root@control-node0 ~]# systemctl start openstack-glance-api
[root@control-node0 ~]# systemctl start openstack-glance-registry


监听端口: registry:9191     api:9292
[root@control-node0 ~]# netstat -antup
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:9191            0.0.0.0:*               LISTEN      40682/python2       
tcp        0      0 0.0.0.0:25672           0.0.0.0:*               LISTEN      38649/beam          
tcp        0      0 0.0.0.0:3306            0.0.0.0:*               LISTEN      38154/mysqld        
tcp        0      0 0.0.0.0:11211           0.0.0.0:*               LISTEN      39211/memcached     
tcp        0      0 0.0.0.0:9292            0.0.0.0:*               LISTEN      40668/python2       
tcp        0      0 0.0.0.0:4369            0.0.0.0:*               LISTEN      38666/epmd          
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      964/sshd            
tcp        0      0 0.0.0.0:15672           0.0.0.0:*               LISTEN      38649/beam          
tcp        0      0 10.0.0.80:46092         10.0.0.80:3306          ESTABLISHED 39334/(wsgi:keyston
tcp        0      0 10.0.0.80:11211         10.0.0.80:34304         ESTABLISHED 39211/memcached     
tcp        0      0 10.0.0.80:46099         10.0.0.80:3306          ESTABLISHED 39336/(wsgi:keyston
tcp        0      0 10.0.0.80:11211         10.0.0.80:34302         ESTABLISHED 39211/memcached     
tcp        0      0 10.0.0.80:34296         10.0.0.80:11211         ESTABLISHED 39335/(wsgi:keyston
tcp        0      0 10.0.0.80:34302         10.0.0.80:11211         ESTABLISHED 39337/(wsgi:keyston
tcp        0      0 127.0.0.1:49729         127.0.0.1:4369          ESTABLISHED 38649/beam          
tcp        0      0 10.0.0.80:34305         10.0.0.80:11211         ESTABLISHED 39334/(wsgi:keyston
tcp        0      0 10.0.0.80:11211         10.0.0.80:34296         ESTABLISHED 39211/memcached     
tcp        0      0 10.0.0.80:22            10.0.0.1:62217          ESTABLISHED 38956/sshd: root@no
tcp        0      0 10.0.0.80:15672         10.0.0.1:62179          ESTABLISHED 38649/beam          
tcp        0      0 10.0.0.80:3306          10.0.0.80:46095         ESTABLISHED 38154/mysqld        
tcp        0      0 10.0.0.80:11211         10.0.0.80:34298         ESTABLISHED 39211/memcached     
tcp        0      0 10.0.0.80:3306          10.0.0.80:46097         ESTABLISHED 38154/mysqld        
tcp        0      0 10.0.0.80:3306          10.0.0.80:46093         ESTABLISHED 38154/mysqld        
tcp        0      0 10.0.0.80:22            10.0.0.1:61458          ESTABLISHED 2036/sshd: root@pts
tcp        0      0 10.0.0.80:34298         10.0.0.80:11211         ESTABLISHED 39336/(wsgi:keyston
tcp        0      0 127.0.0.1:4369          127.0.0.1:49729         ESTABLISHED 38666/epmd          
tcp        0      0 10.0.0.80:46095         10.0.0.80:3306          ESTABLISHED 39333/(wsgi:keyston
tcp        0      0 10.0.0.80:46097         10.0.0.80:3306          ESTABLISHED 39335/(wsgi:keyston
tcp        0      0 10.0.0.80:34304         10.0.0.80:11211         ESTABLISHED 39333/(wsgi:keyston
tcp        0      0 10.0.0.80:3306          10.0.0.80:46099         ESTABLISHED 38154/mysqld        
tcp        0      0 10.0.0.80:11211         10.0.0.80:34305         ESTABLISHED 39211/memcached     
tcp        0      0 10.0.0.80:46093         10.0.0.80:3306          ESTABLISHED 39337/(wsgi:keyston
tcp        0      0 10.0.0.80:3306          10.0.0.80:46092         ESTABLISHED 38154/mysqld        
tcp        0     52 10.0.0.80:22            10.0.0.1:62126          ESTABLISHED 38299/sshd: root@pt
tcp6       0      0 :::5000                 :::*                    LISTEN      39324/httpd         
tcp6       0      0 :::5672                 :::*                    LISTEN      38649/beam          
tcp6       0      0 :::11211                :::*                    LISTEN      39211/memcached     
tcp6       0      0 :::80                   :::*                    LISTEN      39324/httpd         
tcp6       0      0 :::4369                 :::*                    LISTEN      38666/epmd          
tcp6       0      0 :::22                   :::*                    LISTEN      964/sshd            
tcp6       0      0 :::35357                :::*                    LISTEN      39324/httpd         
udp        0      0 127.0.0.1:323           0.0.0.0:*                           2094/chronyd        
udp        0      0 0.0.0.0:11211           0.0.0.0:*                           39211/memcached     
udp6       0      0 ::1:323                 :::*                                2094/chronyd        
udp6       0      0 :::11211                :::*                                39211/memcached     


glance服务创建
[root@control-node0 ~]# source admin-openrc.sh
[root@control-node0 ~]# openstack service create --name glance --description "OpenStack Image service" image
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | OpenStack Image service          |
| enabled     | True                             |
| id          | 5ab719816a7f4294a7f843950fcd2e59 |
| name        | glance                           |
| type        | image                            |
+-------------+----------------------------------+
openstack endpoint create --region RegionOne   image public http://10.0.0.80:9292
openstack endpoint create --region RegionOne   image internal http://10.0.0.80:9292
openstack endpoint create --region RegionOne   image admin http://10.0.0.80:9292


[root@control-node0 ~]# openstack endpoint create --region RegionOne   image public http://10.0.0.80:9292
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | a181ddd3ee8b4d72be1a0fda87b542ef |
| interface    | public                           |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | 5ab719816a7f4294a7f843950fcd2e59 |
| service_name | glance                           |
| service_type | image                            |
| url          | http://10.0.0.80:9292            |
+--------------+----------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne   image internal http://10.0.0.80:9292
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | 4df72061901c40efa3905e95674fc5bc |
| interface    | internal                         |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | 5ab719816a7f4294a7f843950fcd2e59 |
| service_name | glance                           |
| service_type | image                            |
| url          | http://10.0.0.80:9292            |
+--------------+----------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne   image admin http://10.0.0.80:9292
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | f755b7c22ab04ea3857840086b7c7754 |
| interface    | admin                            |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | 5ab719816a7f4294a7f843950fcd2e59 |
| service_name | glance                           |
| service_type | image                            |
| url          | http://10.0.0.80:9292            |
+--------------+----------------------------------+


环境变量添加OS_IMAGE_API_VERSION
[root@control-node0 ~]# echo "export OS_IMAGE_API_VERSION=2" | tee -a admin-openrc.sh demo-openrc.sh
export OS_IMAGE_API_VERSION=2


[root@control-node0 ~]# cat admin-openrc.sh
export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default
export OS_PROJECT_NAME=admin
export OS_TENANT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_AUTH_URL=http://10.0.0.80:35357/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
[root@control-node0 ~]# cat demo-openrc.sh
export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default
export OS_PROJECT_NAME=demo
export OS_TENANT_NAME=demo
export OS_USERNAME=demo
export OS_PASSWORD=demo
export OS_AUTH_URL=http://10.0.0.80:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2


[root@control-node0 ~]# glance image-list
+----+------+
| ID | Name |
+----+------+
+----+------+
如果执行glance image-list命令出现以上画面则表示glance安装成功了


上传镜像
[root@control-node0 ~]# glance image-create --name "cirros" --file cirros-0.3.4-x86_64-disk.img --disk-format qcow2 --container-format bare  --visibility public --progress
[=============================>] 100%
+------------------+--------------------------------------+
| Property         | Value                                |
+------------------+--------------------------------------+
| checksum         | ee1eca47dc88f4879d8a229cc70a07c6     |
| container_format | bare                                 |
| created_at       | 2016-05-27T05:09:36Z                 |
| disk_format      | qcow2                                |
| id               | 07245ea1-5f76-453d-a320-f1b08433a10a |
| min_disk         | 0                                    |
| min_ram          | 0                                    |
| name             | cirros                               |
| owner            | b5a578cfdb4848dba2b91dd38d1e2b93     |
| protected        | False                                |
| size             | 13287936                             |
| status           | active                               |
| tags             | []                                   |
| updated_at       | 2016-05-27T05:09:36Z                 |
| virtual_size     | None                                 |
| visibility       | public                               |
+------------------+--------------------------------------+


查看镜像
[root@control-node0 ~]# glance image-list
+--------------------------------------+--------+
| ID                                   | Name   |
+--------------------------------------+--------+
| 07245ea1-5f76-453d-a320-f1b08433a10a | cirros |
+--------------------------------------+--------+




Nova控制节点(openstack虚拟机必备组件：keystone,glance,nova,neutron)
配置nova.conf文件


1）、配置nova连接及数据表的创建
[root@control-node0 ~]# grep -n ^[a-z] /etc/nova/nova.conf
1740:connection=mysql://nova:nova@10.0.0.80/nova


同步数据库
[root@control-node0 ~]# su -s /bin/sh -c "nova-manage db sync" nova


检查数据库
[root@control-node0 ~]# mysql -unova -pnova -h 10.0.0.80
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 43
Server version: 5.5.47-MariaDB-log MariaDB Server


Copyright (c) 2000, 2015, Oracle, MariaDB Corporation Ab and others.


Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


MariaDB [(none)]> use nova
Database changed
MariaDB [nova]> show tables;
+--------------------------------------------+
| Tables_in_nova                             |
+--------------------------------------------+
| agent_builds                               |
| aggregate_hosts                            |
| aggregate_metadata                         |
| aggregates                                 |
| block_device_mapping                       |
| bw_usage_cache                             |
| cells                                      |
| certificates                               |
| compute_nodes                              |
| console_pools                              |
| consoles                                   |
| dns_domains                                |
| fixed_ips                                  |
| floating_ips                               |
| instance_actions                           |
| instance_actions_events                    |
| instance_extra                             |
| instance_faults                            |
| instance_group_member                      |
| instance_group_policy                      |
| instance_groups                            |
| instance_id_mappings                       |
| instance_info_caches                       |
| instance_metadata                          |
| instance_system_metadata                   |
| instance_type_extra_specs                  |
| instance_type_projects                     |
| instance_types                             |
| instances                                  |
| key_pairs                                  |
| migrate_version                            |
| migrations                                 |
| networks                                   |
| pci_devices                                |
| project_user_quotas                        |
| provider_fw_rules                          |
| quota_classes                              |
| quota_usages                               |
| quotas                                     |
| reservations                               |
| s3_images                                  |
| security_group_default_rules               |
| security_group_instance_association        |
| security_group_rules                       |
| security_groups                            |
| services                                   |
| shadow_agent_builds                        |
| shadow_aggregate_hosts                     |
| shadow_aggregate_metadata                  |
| shadow_aggregates                          |
| shadow_block_device_mapping                |
| shadow_bw_usage_cache                      |
| shadow_cells                               |
| shadow_certificates                        |
| shadow_compute_nodes                       |
| shadow_console_pools                       |
| shadow_consoles                            |
| shadow_dns_domains                         |
| shadow_fixed_ips                           |
| shadow_floating_ips                        |
| shadow_instance_actions                    |
| shadow_instance_actions_events             |
| shadow_instance_extra                      |
| shadow_instance_faults                     |
| shadow_instance_group_member               |
| shadow_instance_group_policy               |
| shadow_instance_groups                     |
| shadow_instance_id_mappings                |
| shadow_instance_info_caches                |
| shadow_instance_metadata                   |
| shadow_instance_system_metadata            |
| shadow_instance_type_extra_specs           |
| shadow_instance_type_projects              |
| shadow_instance_types                      |
| shadow_instances                           |
| shadow_key_pairs                           |
| shadow_migrate_version                     |
| shadow_migrations                          |
| shadow_networks                            |
| shadow_pci_devices                         |
| shadow_project_user_quotas                 |
| shadow_provider_fw_rules                   |
| shadow_quota_classes                       |
| shadow_quota_usages                        |
| shadow_quotas                              |
| shadow_reservations                        |
| shadow_s3_images                           |
| shadow_security_group_default_rules        |
| shadow_security_group_instance_association |
| shadow_security_group_rules                |
| shadow_security_groups                     |
| shadow_services                            |
| shadow_snapshot_id_mappings                |
| shadow_snapshots                           |
| shadow_task_log                            |
| shadow_virtual_interfaces                  |
| shadow_volume_id_mappings                  |
| shadow_volume_usage_cache                  |
| snapshot_id_mappings                       |
| snapshots                                  |
| tags                                       |
| task_log                                   |
| virtual_interfaces                         |
| volume_id_mappings                         |
| volume_usage_cache                         |
+--------------------------------------------+
105 rows in set (0.00 sec)


2)、Keystone配置


[root@control-node0 ~]# vim /etc/nova/nova.conf
[root@control-node0 ~]# grep -n ^[a-z] /etc/nova/nova.conf
1420:rpc_backend=rabbit
1740:connection=mysql://nova:nova@10.0.0.80/nova
2922:rabbit_host=10.0.0.80
2926:rabbit_port=5672
2938:rabbit_userid=openstack
2942:rabbit_password=openstack
[root@control-node0 ~]# source admin-openrc.sh


[root@control-node0 ~]# openstack user create --domain default --password=nova nova
+-----------+----------------------------------+
| Field     | Value                            |
+-----------+----------------------------------+
| domain_id | default                          |
| enabled   | True                             |
| id        | 6b4986f51d7749fd8dc9668d92e21e01 |
| name      | nova                             |
+-----------+----------------------------------+
[root@control-node0 ~]# openstack role add --project service --user nova admin


[root@control-node0 nova]# grep -n ^[a-z] nova.conf
61:rpc_backend=rabbit
124:my_ip=10.0.0.80
268:enabled_apis=osapi_compute,metadata
425:auth_strategy=keystone
1053:network_api_class=nova.network.neutronv2.api.API
1171:linuxnet_interface_driver=nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
1331:security_group_api=neutron
1760:firewall_driver = nova.virt.firewall.NoopFirewallDriver
1828:vncserver_listen=$my_ip
1832:vncserver_proxyclient_address=$my_ip
2213:connection=mysql://nova:nova@10.0.0.80/nova
2334:host=$my_ip
2542:auth_uri = http://10.0.0.80:5000
2543:auth_url = http://10.0.0.80:35357
2544:auth_plugin = password
2545:project_domain_id = default
2546:user_domain_id = default
2547:project_name = service
2548:username = nova
2549:password = nova
3033:url = http://10.0.0.80:9696
3034:auth_url = http://10.0.0.80:35357
3035:auth_plugin = password
3036:project_domain_id = default
3037:user_domain_id = default
3038:region_name = RegionOne
3039:project_name = service
3040:username = neutron
3041:password = neutron
3049:service_metadata_proxy=true
3053:metadata_proxy_shared_secret=neutron
3804:lock_path=/var/lib/nova/tmp
3967:rabbit_host=10.0.0.80
3971:rabbit_port=5672
3983:rabbit_userid=openstack
3987:rabbit_password=openstack
设置开机自启动
systemctl enable openstack-nova-api.service \
openstack-nova-cert.service openstack-nova-consoleauth.service \
openstack-nova-scheduler.service openstack-nova-conductor.service \
openstack-nova-novncproxy.service


启动全部服务
[root@linux-node1 ~]# systemctl start openstack-nova-api.service \
openstack-nova-cert.service openstack-nova-consoleauth.service \
openstack-nova-scheduler.service openstack-nova-conductor.service \
openstack-nova-novncproxy.service


注册服务


openstack service create --name nova --description "OpenStack Compute" compute


openstack endpoint create --region RegionOne compute public http://10.0.0.80:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute internal http://10.0.0.80:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute admin http://10.0.0.80:8774/v2/%\(tenant_id\)s


[root@control-node0 ~]# source admin-openrc.sh
[root@control-node0 ~]# openstack service create --name nova --description "OpenStack Compute" compute
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | OpenStack Compute                |
| enabled     | True                             |
| id          | 47c979dc1312436fb912b8e8b842f293 |
| name        | nova                             |
| type        | compute                          |
+-------------+----------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne compute public http://10.0.0.80:8774/v2/%\(tenant_id\)s
+--------------+----------------------------------------+
| Field        | Value                                  |
+--------------+----------------------------------------+
| enabled      | True                                   |
| id           | b42b8696b4e84d0581228f8fef746ce2       |
| interface    | public                                 |
| region       | RegionOne                              |
| region_id    | RegionOne                              |
| service_id   | 47c979dc1312436fb912b8e8b842f293       |
| service_name | nova                                   |
| service_type | compute                                |
| url          | http://10.0.0.80:8774/v2/%(tenant_id)s |
+--------------+----------------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne compute internal http://10.0.0.80:8774/v2/%\(tenant_id\)s
+--------------+----------------------------------------+
| Field        | Value                                  |
+--------------+----------------------------------------+
| enabled      | True                                   |
| id           | b54df18a4c23471399858df476a98d5f       |
| interface    | internal                               |
| region       | RegionOne                              |
| region_id    | RegionOne                              |
| service_id   | 47c979dc1312436fb912b8e8b842f293       |
| service_name | nova                                   |
| service_type | compute                                |
| url          | http://10.0.0.80:8774/v2/%(tenant_id)s |
+--------------+----------------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne compute admin http://10.0.0.80:8774/v2/%\(tenant_id\)s
+--------------+----------------------------------------+
| Field        | Value                                  |
+--------------+----------------------------------------+
| enabled      | True                                   |
| id           | 71daf94628384f1e8315060f86542696       |
| interface    | admin                                  |
| region       | RegionOne                              |
| region_id    | RegionOne                              |
| service_id   | 47c979dc1312436fb912b8e8b842f293       |
| service_name | nova                                   |
| service_type | compute                                |
| url          | http://10.0.0.80:8774/v2/%(tenant_id)s |
+--------------+----------------------------------------+
验证是否成功：
[root@control-node0 ~]# openstack host list
+-------------------------+-------------+----------+
| Host Name               | Service     | Zone     |
+-------------------------+-------------+----------+
| control-node0.xiegh.com | conductor   | internal |
| control-node0.xiegh.com | consoleauth | internal |
| control-node0.xiegh.com | scheduler   | internal |
| control-node0.xiegh.com | cert        | internal |
+-------------------------+-------------+----------+
如果出现此四个服务则代表nova创建成功了
-------------------------------------------------------------------------------------------------------------------
Nova计算节点
nova-compute一般运行在计算节点上，通过message queue接收并管理VM的生命周期
nova-compute通过libvirt管理KVM,通过XenAPI管理Xen


[root@compute-node1 ~]# grep -n '^[a-z]' /etc/nova/nova.conf
61:rpc_backend=rabbit
124:my_ip=10.0.0.81
268:enabled_apis=osapi_compute,metadata
425:auth_strategy=keystone
1053:network_api_class=nova.network.neutronv2.api.API
1171:linuxnet_interface_driver=nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
1331:security_group_api=neutron
1760:firewall_driver = nova.virt.firewall.NoopFirewallDriver
1820:novncproxy_base_url=http://10.0.0.80:6080/vnc_auto.html
1828:vncserver_listen=0.0.0.0
1832:vncserver_proxyclient_address=10.0.0.81
1835:vnc_enabled=true
1838:vnc_keymap=en-us
2213:connection=mysql://nova:nova@10.0.0.80/nova
2334:host=10.0.0.80
2542:auth_uri = http://10.0.0.80:5000
2543:auth_url = http://10.0.0.80:35357
2544:auth_plugin = password
2545:project_domain_id = default
2546:user_domain_id = default
2547:project_name = service
2548:username = nova
2549:password = nova
2727:virt_type=kvm
3033:url = http://10.0.0.80:9696
3034:auth_url = http://10.0.0.80:35357
3035:auth_plugin = password
3036:project_domain_id = default
3037:user_domain_id = default
3038:region_name = RegionOne
3039:project_name = service
3040:username = neutron
3041:password = neutron
3804:lock_path=/var/lib/nova/tmp
3967:rabbit_host=10.0.0.80
3971:rabbit_port=5672
3983:rabbit_userid=openstack
3987:rabbit_password=openstack
[root@compute-node1 ~]#  systemctl enable libvirtd openstack-nova-compute
Created symlink from /etc/systemd/system/multi-user.target.wants/openstack-nova-compute.service to /usr/lib/systemd/system/openstack-nova-compute.service
[root@compute-node1 ~]# systemctl start libvirtd openstack-nova-compute




在控制节点上面查看注册状态
[root@control-node0 ~]# openstack host list
+-------------------------+-------------+----------+
| Host Name               | Service     | Zone     |
+-------------------------+-------------+----------+
| control-node0.xiegh.com | conductor   | internal |
| control-node0.xiegh.com | consoleauth | internal |
| control-node0.xiegh.com | scheduler   | internal |
| control-node0.xiegh.com | cert        | internal |
| compute-node1.xiegh.com | compute     | nova     |
+-------------------------+-------------+----------+
计算节点上nova安装成功并注册成功


镜像出于活动的状态
[root@control-node0 ~]#  nova image-list
+--------------------------------------+--------+--------+--------+
| ID                                   | Name   | Status | Server |
+--------------------------------------+--------+--------+--------+
| 07245ea1-5f76-453d-a320-f1b08433a10a | cirros | ACTIVE |        |
+--------------------------------------+--------+--------+--------+


验证nova与keystone的连接，如下说明成功
[root@control-node0 ~]# nova endpoints
WARNING: keystone has no endpoint in ! Available endpoints for this service:
+-----------+----------------------------------+
| keystone  | Value                            |
+-----------+----------------------------------+
| id        | 1a8eb7b97ff64c56886942a38054b9bb |
| interface | public                           |
| region    | RegionOne                        |
| region_id | RegionOne                        |
| url       | http://10.0.0.80:5000/v2.0       |
+-----------+----------------------------------+
+-----------+----------------------------------+
| keystone  | Value                            |
+-----------+----------------------------------+
| id        | 34c8185306c340a0bb4efbfc9da21003 |
| interface | admin                            |
| region    | RegionOne                        |
| region_id | RegionOne                        |
| url       | http://10.0.0.80:35357/v2.0      |
+-----------+----------------------------------+
+-----------+----------------------------------+
| keystone  | Value                            |
+-----------+----------------------------------+
| id        | 4caf182c26dd457ba86d9974dfb00c1b |
| interface | internal                         |
| region    | RegionOne                        |
| region_id | RegionOne                        |
| url       | http://10.0.0.80:5000/v2.0       |
+-----------+----------------------------------+
WARNING: glance has no endpoint in ! Available endpoints for this service:
+-----------+----------------------------------+
| glance    | Value                            |
+-----------+----------------------------------+
| id        | 4df72061901c40efa3905e95674fc5bc |
| interface | internal                         |
| region    | RegionOne                        |
| region_id | RegionOne                        |
| url       | http://10.0.0.80:9292            |
+-----------+----------------------------------+
+-----------+----------------------------------+
| glance    | Value                            |
+-----------+----------------------------------+
| id        | a181ddd3ee8b4d72be1a0fda87b542ef |
| interface | public                           |
| region    | RegionOne                        |
| region_id | RegionOne                        |
| url       | http://10.0.0.80:9292            |
+-----------+----------------------------------+
+-----------+----------------------------------+
| glance    | Value                            |
+-----------+----------------------------------+
| id        | f755b7c22ab04ea3857840086b7c7754 |
| interface | admin                            |
| region    | RegionOne                        |
| region_id | RegionOne                        |
| url       | http://10.0.0.80:9292            |
+-----------+----------------------------------+
WARNING: nova has no endpoint in ! Available endpoints for this service:
+-----------+-----------------------------------------------------------+
| nova      | Value                                                     |
+-----------+-----------------------------------------------------------+
| id        | 71daf94628384f1e8315060f86542696                          |
| interface | admin                                                     |
| region    | RegionOne                                                 |
| region_id | RegionOne                                                 |
| url       | http://10.0.0.80:8774/v2/b5a578cfdb4848dba2b91dd38d1e2b93 |
+-----------+-----------------------------------------------------------+
+-----------+-----------------------------------------------------------+
| nova      | Value                                                     |
+-----------+-----------------------------------------------------------+
| id        | b42b8696b4e84d0581228f8fef746ce2                          |
| interface | public                                                    |
| region    | RegionOne                                                 |
| region_id | RegionOne                                                 |
| url       | http://10.0.0.80:8774/v2/b5a578cfdb4848dba2b91dd38d1e2b93 |
+-----------+-----------------------------------------------------------+
+-----------+-----------------------------------------------------------+
| nova      | Value                                                     |
+-----------+-----------------------------------------------------------+
| id        | b54df18a4c23471399858df476a98d5f                          |
| interface | internal                                                  |
| region    | RegionOne                                                 |
| region_id | RegionOne                                                 |
| url       | http://10.0.0.80:8774/v2/b5a578cfdb4848dba2b91dd38d1e2b93 |
+-----------+-----------------------------------------------------------+




Neutron部署
注册网络服务：
source admin-openrc.sh
openstack service create --name neutron --description "OpenStack Networking" network
openstack endpoint create --region RegionOne network public http://10.0.0.80:9696
openstack endpoint create --region RegionOne network internal http://10.0.0.80:9696
openstack endpoint create --region RegionOne network admin http://10.0.0.80:9696


[root@control-node0 ~]# openstack service create --name neutron --description "OpenStack Networking" network
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | OpenStack Networking             |
| enabled     | True                             |
| id          | eb5f03d85c774f48940654811a22b581 |
| name        | neutron                          |
| type        | network                          |
+-------------+----------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne network public http://10.0.0.80:9696
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | f782d738018a4dc5b80931f67f31d974 |
| interface    | public                           |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | eb5f03d85c774f48940654811a22b581 |
| service_name | neutron                          |
| service_type | network                          |
| url          | http://10.0.0.80:9696            |
+--------------+----------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne network internal http://10.0.0.80:9696
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | 21565236fb1b4bc8b0c37c040369d7d4 |
| interface    | internal                         |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | eb5f03d85c774f48940654811a22b581 |
| service_name | neutron                          |
| service_type | network                          |
| url          | http://10.0.0.80:9696            |
+--------------+----------------------------------+
[root@control-node0 ~]# openstack endpoint create --region RegionOne network admin http://10.0.0.80:9696
+--------------+----------------------------------+
| Field        | Value                            |
+--------------+----------------------------------+
| enabled      | True                             |
| id           | f2c83846242d4443a7cd3f205cf3bb56 |
| interface    | admin                            |
| region       | RegionOne                        |
| region_id    | RegionOne                        |
| service_id   | eb5f03d85c774f48940654811a22b581 |
| service_name | neutron                          |
| service_type | network                          |
| url          | http://10.0.0.80:9696            |
+--------------+----------------------------------+


[root@control-node0 ~]#grep -n '^[a-z]' /etc/neutron/neutron.conf
20:state_path = /var/lib/neutron
60:core_plugin = ml2
77:service_plugins = router
92:auth_strategy = keystone
360:notify_nova_on_port_status_changes = True
364:notify_nova_on_port_data_changes = True
367:nova_url = http://10.0.0.80:8774/v2
573:rpc_backend=rabbit
717:auth_uri = http://10.0.0.80:5000
718:auth_url = http://10.0.0.80:35357
719:auth_plugin = password
720:project_domain_id = default
721:user_domain_id = default
722:project_name = service
723:username = neutron
724:password = neutron
737:connection = mysql://neutron:neutron@10.0.0.80:3306/neutron
780:auth_url = http://10.0.0.80:35357
781:auth_plugin = password
782:project_domain_id = default
783:user_domain_id = default
784:region_name = RegionOne
785:project_name = service
786:username = nova
787:password = nova
818:lock_path = $state_path/lock
998:rabbit_host = 10.0.0.80
1002:rabbit_port = 5672
1014:rabbit_userid = openstack
1018:rabbit_password = openstack


[root@control-node0 ~]# grep -n '^[a-z]' /etc/neutron/plugins/ml2/ml2_conf.ini
5:type_drivers = flat,vlan,gre,vxlan,geneve
12:tenant_network_types = vlan,gre,vxlan,geneve
18:mechanism_drivers = openvswitch,linuxbridge
27:extension_drivers = port_security
67:flat_networks = physnet1
120:enable_ipset = True


[root@control-node0 ~]# grep -n '^[a-z]' /etc/neutron/plugins/ml2/linuxbridge_agent.ini
9:physical_interface_mappings = physnet1:eth0
16:enable_vxlan = false
51:prevent_arp_spoofing = True
57:firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver
61:enable_security_group = True


[root@control-node0 ~]# grep -n '^[a-z]' /etc/neutron/dhcp_agent.ini
27:interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver
31:dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
52:enable_isolated_metadata = true


[root@control-node0 ~]# grep -n '^[a-z]' /etc/neutron/metadata_agent.ini
4:auth_uri = http://10.0.0.80:5000
5:auth_url = http://10.0.0.80:35357
6:auth_region = RegionOne
7:auth_plugin = password
8:project_domain_id = default
9:user_domain_id = default
10:project_name = service
11:username = neutron
12:password = neutron
29:nova_metadata_ip = 10.0.0.80
52:metadata_proxy_shared_secret = neutron


[root@control-node0 ~]# grep -n '^[a-z]' /etc/nova/nova.conf
61:rpc_backend=rabbit
124:my_ip=10.0.0.80
268:enabled_apis=osapi_compute,metadata
425:auth_strategy=keystone
1053:network_api_class=nova.network.neutronv2.api.API
1171:linuxnet_interface_driver=nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
1331:security_group_api=neutron
1760:firewall_driver = nova.virt.firewall.NoopFirewallDriver
1828:vncserver_listen=$my_ip
1832:vncserver_proxyclient_address=$my_ip
2213:connection=mysql://nova:nova@10.0.0.80/nova
2334:host=$my_ip
2542:auth_uri = http://10.0.0.80:5000
2543:auth_url = http://10.0.0.80:35357
2544:auth_plugin = password
2545:project_domain_id = default
2546:user_domain_id = default
2547:project_name = service
2548:username = nova
2549:password = nova
3033:url = http://10.0.0.80:9696
3034:auth_url = http://10.0.0.80:35357
3035:auth_plugin = password
3036:project_domain_id = default
3037:user_domain_id = default
3038:region_name = RegionOne
3039:project_name = service
3040:username = neutron
3041:password = neutron
3049:service_metadata_proxy=true
3053:metadata_proxy_shared_secret=neutron
3804:lock_path=/var/lib/nova/tmp
3967:rabbit_host=10.0.0.80
3971:rabbit_port=5672
3983:rabbit_userid=openstack
3987:rabbit_password=openstack


[root@control-node0 ~]# ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
[root@control-node0 ~]# openstack user create --domain default --password=neutron neutron
+-----------+----------------------------------+
| Field     | Value                            |
+-----------+----------------------------------+
| domain_id | default                          |
| enabled   | True                             |
| id        | 85c411a092354b29b58c7505a8905824 |
| name      | neutron                          |
+-----------+----------------------------------+
[root@control-node0 ~]# openstack role add --project service --user neutron admin


更新数据库
su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
--config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron


[root@control-node0 ~]# su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
> --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
  Running upgrade for neutron ...
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade  -> juno, juno_initial
INFO  [alembic.runtime.migration] Running upgrade juno -> 44621190bc02, add_uniqueconstraint_ipavailability_ranges
INFO  [alembic.runtime.migration] Running upgrade 44621190bc02 -> 1f71e54a85e7, ml2_network_segments models change for multi-segment network.
INFO  [alembic.runtime.migration] Running upgrade 1f71e54a85e7 -> 408cfbf6923c, remove ryu plugin
INFO  [alembic.runtime.migration] Running upgrade 408cfbf6923c -> 28c0ffb8ebbd, remove mlnx plugin
INFO  [alembic.runtime.migration] Running upgrade 28c0ffb8ebbd -> 57086602ca0a, scrap_nsx_adv_svcs_models
INFO  [alembic.runtime.migration] Running upgrade 57086602ca0a -> 38495dc99731, ml2_tunnel_endpoints_table
INFO  [alembic.runtime.migration] Running upgrade 38495dc99731 -> 4dbe243cd84d, nsxv
INFO  [alembic.runtime.migration] Running upgrade 4dbe243cd84d -> 41662e32bce2, L3 DVR SNAT mapping
INFO  [alembic.runtime.migration] Running upgrade 41662e32bce2 -> 2a1ee2fb59e0, Add mac_address unique constraint
INFO  [alembic.runtime.migration] Running upgrade 2a1ee2fb59e0 -> 26b54cf9024d, Add index on allocated
INFO  [alembic.runtime.migration] Running upgrade 26b54cf9024d -> 14be42f3d0a5, Add default security group table
INFO  [alembic.runtime.migration] Running upgrade 14be42f3d0a5 -> 16cdf118d31d, extra_dhcp_options IPv6 support
INFO  [alembic.runtime.migration] Running upgrade 16cdf118d31d -> 43763a9618fd, add mtu attributes to network
INFO  [alembic.runtime.migration] Running upgrade 43763a9618fd -> bebba223288, Add vlan transparent property to network
INFO  [alembic.runtime.migration] Running upgrade bebba223288 -> 4119216b7365, Add index on tenant_id column
INFO  [alembic.runtime.migration] Running upgrade 4119216b7365 -> 2d2a8a565438, ML2 hierarchical binding
INFO  [alembic.runtime.migration] Running upgrade 2d2a8a565438 -> 2b801560a332, Remove Hyper-V Neutron Plugin
INFO  [alembic.runtime.migration] Running upgrade 2b801560a332 -> 57dd745253a6, nuage_kilo_migrate
INFO  [alembic.runtime.migration] Running upgrade 57dd745253a6 -> f15b1fb526dd, Cascade Floating IP Floating Port deletion
INFO  [alembic.runtime.migration] Running upgrade f15b1fb526dd -> 341ee8a4ccb5, sync with cisco repo
INFO  [alembic.runtime.migration] Running upgrade 341ee8a4ccb5 -> 35a0f3365720, add port-security in ml2
INFO  [alembic.runtime.migration] Running upgrade 35a0f3365720 -> 1955efc66455, weight_scheduler
INFO  [alembic.runtime.migration] Running upgrade 1955efc66455 -> 51c54792158e, Initial operations for subnetpools
INFO  [alembic.runtime.migration] Running upgrade 51c54792158e -> 589f9237ca0e, Cisco N1kv ML2 driver tables
INFO  [alembic.runtime.migration] Running upgrade 589f9237ca0e -> 20b99fd19d4f, Cisco UCS Manager Mechanism Driver
INFO  [alembic.runtime.migration] Running upgrade 20b99fd19d4f -> 034883111f, Remove allow_overlap from subnetpools
INFO  [alembic.runtime.migration] Running upgrade 034883111f -> 268fb5e99aa2, Initial operations in support of subnet allocation from a pool
INFO  [alembic.runtime.migration] Running upgrade 268fb5e99aa2 -> 28a09af858a8, Initial operations to support basic quotas on prefix space in a subnet pool
INFO  [alembic.runtime.migration] Running upgrade 28a09af858a8 -> 20c469a5f920, add index for port
INFO  [alembic.runtime.migration] Running upgrade 20c469a5f920 -> kilo, kilo
INFO  [alembic.runtime.migration] Running upgrade kilo -> 354db87e3225, nsxv_vdr_metadata.py
INFO  [alembic.runtime.migration] Running upgrade 354db87e3225 -> 599c6a226151, neutrodb_ipam
INFO  [alembic.runtime.migration] Running upgrade 599c6a226151 -> 52c5312f6baf, Initial operations in support of address scopes
INFO  [alembic.runtime.migration] Running upgrade 52c5312f6baf -> 313373c0ffee, Flavor framework
INFO  [alembic.runtime.migration] Running upgrade 313373c0ffee -> 8675309a5c4f, network_rbac
INFO  [alembic.runtime.migration] Running upgrade kilo -> 30018084ec99, Initial no-op Liberty contract rule.
INFO  [alembic.runtime.migration] Running upgrade 30018084ec99, 8675309a5c4f -> 4ffceebfada, network_rbac
INFO  [alembic.runtime.migration] Running upgrade 4ffceebfada -> 5498d17be016, Drop legacy OVS and LB plugin tables
INFO  [alembic.runtime.migration] Running upgrade 5498d17be016 -> 2a16083502f3, Metaplugin removal
INFO  [alembic.runtime.migration] Running upgrade 2a16083502f3 -> 2e5352a0ad4d, Add missing foreign keys
INFO  [alembic.runtime.migration] Running upgrade 2e5352a0ad4d -> 11926bcfe72d, add geneve ml2 type driver
INFO  [alembic.runtime.migration] Running upgrade 11926bcfe72d -> 4af11ca47297, Drop cisco monolithic tables
INFO  [alembic.runtime.migration] Running upgrade 8675309a5c4f -> 45f955889773, quota_usage
INFO  [alembic.runtime.migration] Running upgrade 45f955889773 -> 26c371498592, subnetpool hash
INFO  [alembic.runtime.migration] Running upgrade 26c371498592 -> 1c844d1677f7, add order to dnsnameservers
INFO  [alembic.runtime.migration] Running upgrade 1c844d1677f7 -> 1b4c6e320f79, address scope support in subnetpool
INFO  [alembic.runtime.migration] Running upgrade 1b4c6e320f79 -> 48153cb5f051, qos db changes
INFO  [alembic.runtime.migration] Running upgrade 48153cb5f051 -> 9859ac9c136, quota_reservations
INFO  [alembic.runtime.migration] Running upgrade 9859ac9c136 -> 34af2b5c5a59, Add dns_name to Port
  OK


重新驱动下服务：
[root@control-node0 ~]# systemctl restart openstack-nova-api


开机自动加载neutron及启动neutron服务
systemctl enable neutron-server.service \
neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
neutron-metadata-agent.service


systemctl restart neutron-server.service \
neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
neutron-metadata-agent.service


执行结果：
[root@control-node0 ~]# systemctl restart openstack-nova-api
[root@control-node0 ~]# systemctl enable neutron-server.service \
> neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
> neutron-metadata-agent.service
ln -s '/usr/lib/systemd/system/neutron-server.service' '/etc/systemd/system/multi-user.target.wants/neutron-server.service'
ln -s '/usr/lib/systemd/system/neutron-linuxbridge-agent.service' '/etc/systemd/system/multi-user.target.wants/neutron-linuxbridge-agent.service'
ln -s '/usr/lib/systemd/system/neutron-dhcp-agent.service' '/etc/systemd/system/multi-user.target.wants/neutron-dhcp-agent.service'
ln -s '/usr/lib/systemd/system/neutron-metadata-agent.service' '/etc/systemd/system/multi-user.target.wants/neutron-metadata-agent.service'
[root@control-node0 ~]# systemctl restart neutron-server.service \
> neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
> neutron-metadata-agent.service




查看网卡的配置
[root@control-node0 ~]# source admin-openrc.sh
[root@control-node0 ~]# neutron agent-list
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+
| id                                   | agent_type         | host                    | alive | admin_state_up | binary                    |
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+
| 4de08ae7-5699-47ea-986b-7c855d7eb7bd | Linux bridge agent | control-node0.xiegh.com | :-)   | True           | neutron-linuxbridge-agent |
| adf5abfc-2a74-4baa-b4cd-da7f7f05a378 | Metadata agent     | control-node0.xiegh.com | :-)   | True           | neutron-metadata-agent    |
| c1562203-c8ff-4189-a59b-bcf480ca70c1 | DHCP agent         | control-node0.xiegh.com | :-)   | True           | neutron-dhcp-agent        |
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+


将控制节点的配置文件neutron.conf 拷贝到计算节点的目录/etc/neutron/
[root@control-node0 ~]# scp -r /etc/neutron/neutron.conf 10.0.0.81:/etc/neutron/
[root@control-node0 ~]# scp -r /etc/neutron/plugins/ml2/linuxbridge_agent.ini 10.0.0.81:/etc/neutron/plugins/ml2/
[root@control-node0 ~]# scp -r /etc/neutron/plugins/ml2/ml2_conf.ini 10.0.0.81:/etc/neutron/plugins/ml2/


在已经拷贝了，这里就不拷贝了nova.conf




[root@compute-node1 ~]# grep -n '^[a-z]'  /etc/neutron/neutron.conf
20:state_path = /var/lib/neutron
60:core_plugin = ml2
77:service_plugins = router
92:auth_strategy = keystone
360:notify_nova_on_port_status_changes = True
364:notify_nova_on_port_data_changes = True
367:nova_url = http://10.0.0.80:8774/v2
573:rpc_backend=rabbit
717:auth_uri = http://10.0.0.80:5000
718:auth_url = http://10.0.0.80:35357
719:auth_plugin = password
720:project_domain_id = default
721:user_domain_id = default
722:project_name = service
723:username = neutron
724:password = neutron
737:connection = mysql://neutron:neutron@10.0.0.80:3306/neutron
780:auth_url = http://10.0.0.80:35357
781:auth_plugin = password
782:project_domain_id = default
783:user_domain_id = default
784:region_name = RegionOne
785:project_name = service
786:username = nova
787:password = nova
818:lock_path = $state_path/lock
998:rabbit_host = 10.0.0.80
1002:rabbit_port = 5672
1014:rabbit_userid = openstack
1018:rabbit_password = openstack


[root@compute-node1 ~]# grep -n '^[a-z]'  /etc/neutron/plugins/ml2/linuxbridge_agent.ini
9:physical_interface_mappings = physnet1:eth0
16:enable_vxlan = false
51:prevent_arp_spoofing = True
57:firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver
61:enable_security_group = True


[root@compute-node1 ~]# grep -n '^[a-z]'  /etc/neutron/plugins/ml2/ml2_conf.ini
5:type_drivers = flat,vlan,gre,vxlan,geneve
12:tenant_network_types = vlan,gre,vxlan,geneve
18:mechanism_drivers = openvswitch,linuxbridge
27:extension_drivers = port_security
67:flat_networks = physnet1
120:enable_ipset = True


[root@compute-node1 ~]# grep -n '^[a-z]'  /etc/nova/nova.conf
61:rpc_backend=rabbit
124:my_ip=10.0.0.81
268:enabled_apis=osapi_compute,metadata
425:auth_strategy=keystone
1053:network_api_class=nova.network.neutronv2.api.API
1171:linuxnet_interface_driver=nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
1331:security_group_api=neutron
1760:firewall_driver = nova.virt.firewall.NoopFirewallDriver
1820:novncproxy_base_url=http://10.0.0.80:6080/vnc_auto.html
1828:vncserver_listen=0.0.0.0
1832:vncserver_proxyclient_address=10.0.0.81
1835:vnc_enabled=true
1838:vnc_keymap=en-us
2213:connection=mysql://nova:nova@10.0.0.80/nova
2334:host=10.0.0.80
2542:auth_uri = http://10.0.0.80:5000
2543:auth_url = http://10.0.0.80:35357
2544:auth_plugin = password
2545:project_domain_id = default
2546:user_domain_id = default
2547:project_name = service
2548:username = nova
2549:password = nova
2727:virt_type=kvm
3033:url = http://10.0.0.80:9696
3034:auth_url = http://10.0.0.80:35357
3035:auth_plugin = password
3036:project_domain_id = default
3037:user_domain_id = default
3038:region_name = RegionOne
3039:project_name = service
3040:username = neutron
3041:password = neutron
3804:lock_path=/var/lib/nova/tmp
3967:rabbit_host=10.0.0.80
3971:rabbit_port=5672
3983:rabbit_userid=openstack
3987:rabbit_password=openstack


[root@compute-node1 ~]# systemctl restart openstack-nova-compute
[root@compute-node1 ~]# ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
[root@compute-node1 ~]# systemctl enable neutron-linuxbridge-agent.service
Created symlink from /etc/systemd/system/multi-user.target.wants/neutron-linuxbridge-agent.service to /usr/lib/systemd/system/neutron-linuxbridge-agent.service.
[root@compute-node1 ~]# systemctl restart neutron-linuxbridge-agent.service


故障：
在控制不能发现计算节点neutron-linuxbridge-agent
重启计算计算节点恢复正常


[root@control-node0 ~]#  neutron agent-list
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+
| id                                   | agent_type         | host                    | alive | admin_state_up | binary                    |
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+
| 4de08ae7-5699-47ea-986b-7c855d7eb7bd | Linux bridge agent | control-node0.xiegh.com | :-)   | True           | neutron-linuxbridge-agent |
| adf5abfc-2a74-4baa-b4cd-da7f7f05a378 | Metadata agent     | control-node0.xiegh.com | :-)   | True           | neutron-metadata-agent    |
| c1562203-c8ff-4189-a59b-bcf480ca70c1 | DHCP agent         | control-node0.xiegh.com | :-)   | True           | neutron-dhcp-agent        |
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+


在控制节点查看：
[root@control-node0 ~]# neutron agent-list
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+
| id                                   | agent_type         | host                    | alive | admin_state_up | binary                    |
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+
| 4de08ae7-5699-47ea-986b-7c855d7eb7bd | Linux bridge agent | control-node0.xiegh.com | :-)   | True           | neutron-linuxbridge-agent |
| a7b2c76e-2c9e-42a3-89ac-725716a0c370 | Linux bridge agent | compute-node1.xiegh.com | :-)   | True           | neutron-linuxbridge-agent |
| adf5abfc-2a74-4baa-b4cd-da7f7f05a378 | Metadata agent     | control-node0.xiegh.com | :-)   | True           | neutron-metadata-agent    |
| c1562203-c8ff-4189-a59b-bcf480ca70c1 | DHCP agent         | control-node0.xiegh.com | :-)   | True           | neutron-dhcp-agent        |
+--------------------------------------+--------------------+-------------------------+-------+----------------+---------------------------+
代表计算节点的Linux bridge agent已成功连接到控制节点。


创建一个网络：
neutron net-create flat --shared --provider:physical_network physnet1 --provider:network_type flat


[root@control-node0 ~]# neutron net-create flat --shared --provider:physical_network physnet1 --provider:network_type flat
Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| id                        | 516b5a4d-7fa5-43ae-8328-965c5e0e21d7 |
| mtu                       | 0                                    |
| name                      | flat                                 |
| port_security_enabled     | True                                 |
| provider:network_type     | flat                                 |
| provider:physical_network | physnet1                             |
| provider:segmentation_id  |                                      |
| router:external           | False                                |
| shared                    | True                                 |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tenant_id                 | b5a578cfdb4848dba2b91dd38d1e2b93     |
+---------------------------+--------------------------------------+




创建一个子网
neutron subnet-create flat 10.0.0.0/24 --name flat-subnet --allocation-pool start=10.0.0.100,end=10.0.0.200 --dns-nameserver 10.0.0.2 --gateway 10.0.0.2


[root@control-node0 ~]# neutron subnet-create flat 10.0.0.0/24 --name flat-subnet --allocation-pool start=10.0.0.100,end=10.0.0.200 --dns-nameserver 10.0.0.2 --gateway 10.0.0.2
Created a new subnet:
+-------------------+----------------------------------------------+
| Field             | Value                                        |
+-------------------+----------------------------------------------+
| allocation_pools  | {"start": "10.0.0.100", "end": "10.0.0.200"} |
| cidr              | 10.0.0.0/24                                  |
| dns_nameservers   | 10.0.0.2                                     |
| enable_dhcp       | True                                         |
| gateway_ip        | 10.0.0.2                                     |
| host_routes       |                                              |
| id                | 64ba9f36-3e3e-4988-a863-876759ad43c3         |
| ip_version        | 4                                            |
| ipv6_address_mode |                                              |
| ipv6_ra_mode      |                                              |
| name              | flat-subnet                                  |
| network_id        | 516b5a4d-7fa5-43ae-8328-965c5e0e21d7         |
| subnetpool_id     |                                              |
| tenant_id         | b5a578cfdb4848dba2b91dd38d1e2b93             |
+-------------------+----------------------------------------------+




查看网络和子网
[root@control-node0 ~]# neutron subnet-list
+--------------------------------------+-------------+-------------+----------------------------------------------+
| id                                   | name        | cidr        | allocation_pools                             |
+--------------------------------------+-------------+-------------+----------------------------------------------+
| 64ba9f36-3e3e-4988-a863-876759ad43c3 | flat-subnet | 10.0.0.0/24 | {"start": "10.0.0.100", "end": "10.0.0.200"} |
+--------------------------------------+-------------+-------------+----------------------------------------------+




[root@control-node0 ~]#  source demo-openrc.sh
[root@control-node0 ~]# ssh-keygen -q -N ""
Enter file in which to save the key (/root/.ssh/id_rsa):
[root@control-node0 ~]# ls .ssh/
id_rsa  id_rsa.pub  known_hosts
[root@control-node0 ~]# nova keypair-add --pub-key .ssh/id_rsa.pub mykey
[root@control-node0 ~]# nova keypair-list
+-------+-------------------------------------------------+
| Name  | Fingerprint                                     |
+-------+-------------------------------------------------+
| mykey | ce:ad:3c:51:2a:db:dc:4c:d1:a5:22:e6:20:53:cf:65 |
+-------+-------------------------------------------------+
[root@control-node0 ~]# nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
+-------------+-----------+---------+-----------+--------------+
| IP Protocol | From Port | To Port | IP Range  | Source Group |
+-------------+-----------+---------+-----------+--------------+
| icmp        | -1        | -1      | 0.0.0.0/0 |              |
+-------------+-----------+---------+-----------+--------------+
[root@control-node0 ~]# nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
+-------------+-----------+---------+-----------+--------------+
| IP Protocol | From Port | To Port | IP Range  | Source Group |
+-------------+-----------+---------+-----------+--------------+
| tcp         | 22        | 22      | 0.0.0.0/0 |              |
+-------------+-----------+---------+-----------+--------------+
[root@control-node0 ~]# nova flavor-list
+----+-----------+-----------+------+-----------+------+-------+-------------+-----------+
| ID | Name      | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
+----+-----------+-----------+------+-----------+------+-------+-------------+-----------+
| 1  | m1.tiny   | 512       | 1    | 0         |      | 1     | 1.0         | True      |
| 2  | m1.small  | 2048      | 20   | 0         |      | 1     | 1.0         | True      |
| 3  | m1.medium | 4096      | 40   | 0         |      | 2     | 1.0         | True      |
| 4  | m1.large  | 8192      | 80   | 0         |      | 4     | 1.0         | True      |
| 5  | m1.xlarge | 16384     | 160  | 0         |      | 8     | 1.0         | True      |
+----+-----------+-----------+------+-----------+------+-------+-------------+-----------+
[root@control-node0 ~]# nova image-list
+--------------------------------------+--------+--------+--------+
| ID                                   | Name   | Status | Server |
+--------------------------------------+--------+--------+--------+
| 07245ea1-5f76-453d-a320-f1b08433a10a | cirros | ACTIVE |        |
+--------------------------------------+--------+--------+--------+
[root@control-node0 ~]# neutron net-list
+--------------------------------------+------+--------------------------------------------------+
| id                                   | name | subnets                                          |
+--------------------------------------+------+--------------------------------------------------+
| 516b5a4d-7fa5-43ae-8328-965c5e0e21d7 | flat | 64ba9f36-3e3e-4988-a863-876759ad43c3 10.0.0.0/24 |
+--------------------------------------+------+--------------------------------------------------+
[root@control-node0 ~]# nova secgroup-list
+--------------------------------------+---------+------------------------+
| Id                                   | Name    | Description            |
+--------------------------------------+---------+------------------------+
| ba83d14c-2516-427b-8e88-89a49270b8d7 | default | Default security group |
+--------------------------------------+---------+------------------------+




nova boot --flavor m1.tiny --image cirros --nic net-id=516b5a4d-7fa5-43ae-8328-965c5e0e21d7 --security-group default --key-name mykey hehe-instance
