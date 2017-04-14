http://smallasa.com/2017/02/01/node-env/
http://cloudate.net/
http://www.ttlsa.com/

1. 基础操作
[root@localhost ~]# yum -y install epel-release
[root@localhost ~]# yum -y install gcc gcc-c++ make cmake bison libtool autoconf automake zip unzip bzip2 zlib zlib-devel openssl openssl-devel pcre pcre-devel bison-devel ncurses-devel tcl tcl-devel perl-Digest-SHA1 GeoIP GeoIP-devel gperftools gperftools-devel libatomic_ops-devel gtest gtest-devel glibc-devel unixODBC-devel fop libperl libpython readline readline-devel
[root@localhost ~]# yum -y install git lftp ntpdate vim wget telnet dstat tree lrzsz net-tools nmap-ncat

[root@localhost ~]# setenforce 0
[root@localhost ~]# sed -i s/'SELINUX=enforcing'/'SELINUX=disabled'/g /etc/selinux/config

[root@localhost ~]# systemctl stop firewalld.service
[root@localhost ~]# systemctl disable firewalld.service

[root@localhost ~]# echo "* - nofile 65536" | tee -a /etc/security/limits.conf
[root@localhost ~]# echo "* - nproc  65536" | tee -a /etc/security/limits.conf
[root@localhost ~]# sed -i /4096/d /etc/security/limits.d/20-nproc.conf

[root@localhost ~]# systemctl stop ntpd
[root@localhost ~]# systemctl disable ntpd
[root@localhost ~]# echo '1 1 * * *     /usr/sbin/ntpdate -s cn.pool.ntp.org' | tee /var/spool/cron/root

[root@localhost ~]# useradd wisdom
[root@localhost ~]# echo '1)]LZ?n-,yw3}Gi' | passwd --stdin wisdom

[root@localhost ~]# mkdir -p /mnt/{app,data,log,web,ops/app}

2. nginx install
[root@localhost app]# useradd -s /sbin/nologin nginx

[root@localhost app]# tar xzf nginx-1.10.2.tar.gz
[root@localhost app]# cd nginx-1.10.2
/mnt/app/nginx/sbin/nginx -c /mnt/app/nginx/conf/nginx.conf -t
 /mnt/app/nginx/sbin/nginx -c /mnt/app/nginx/conf/nginx.conf -s reload
./configure  --prefix=/mnt/app/nginx  --user=nginx  --group=nginx  --with-select_module  --with-poll_module  --with-threads  --with-file-aio  --with-http_ssl_module  --with-http_stub_status_module  --with-http_v2_module  --with-http_realip_module  --with-http_addition_module  --with-http_geoip_module  --with-http_gunzip_module  --with-http_gzip_static_module  --with-http_auth_request_module  --with-http_degradation_module --with-google_perftools_module  --with-pcre  --with-libatomic

[root@localhost nginx-1.10.2]# ./configure \
\> --prefix=/mnt/app/nginx \
\> --user=nginx \
\> --group=nginx \
\> --with-select_module \
\> --with-poll_module \
\> --with-threads \
\> --with-file-aio \
\> --with-http_ssl_module \
\> --with-http_stub_status_module \
\> --with-http_v2_module \
\> --with-http_realip_module \
\> --with-http_addition_module \
\> --with-http_geoip_module \
\> --with-http_gunzip_module \
\> --with-http_gzip_static_module \
\> --with-http_auth_request_module \
\> --with-http_degradation_module \
\> --with-google_perftools_module \
\> --with-pcre \
\> --with-libatomic
[root@localhost nginx-1.10.2]# make
[root@localhost nginx-1.10.2]# make install

[root@localhost app]# mkdir -p /mnt/log/nginx
[root@localhost app]# chown -R nginx.nginx /mnt/log/nginx

3. node install
[root@localhost app]# tar xzf node-v6.9.1-linux-x64.tar.gz
[root@localhost app]# mv node-v6.9.1-linux-x64 /mnt/app/node

[root@localhost app]# echo 'export NODE_HOME=/mnt/app/node' | tee /etc/profile.d/node.sh
[root@localhost app]# echo 'export NODE_PATH=${NODE_HOME}/lib/node_modules' | tee -a /etc/profile.d/node.sh
[root@localhost app]# echo 'export PATH=${NODE_HOME}/bin:${PATH}' | tee -a /etc/profile.d/node.sh
[root@localhost app]# source /etc/profile

[root@localhost app]# npm config set registry https://registry.npm.taobao.org
[root@localhost app]# npm config get registry
[root@localhost app]# chown -R root.root /mnt/app/node

[root@localhost app]# unzip cw-hms-web.zip
[root@localhost app]# mv cw-hms-web /mnt/app/hms
[root@localhost app]# cd /mnt/app/hms/
[root@localhost hms]# npm install
[root@localhost hms]# npm build
[root@localhost hms]# npm run server &

4. java install
[root@localhost app]# tar xzf jdk-8u73-linux-x64.tar.gz
[root@localhost app]# mv jdk1.8.0_73 /mnt/app/java
[root@localhost app]# chown -R root.root /mnt/app/java

[root@localhost app]# echo 'export JAVA_HOME=/mnt/app/java' | tee /etc/profile.d/java.sh
[root@localhost app]# echo 'export JRE_HOME=${JAVA_HOME}/jre' | tee -a /etc/profile.d/java.sh
[root@localhost app]# echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' | tee -a /etc/profile.d/java.sh
[root@localhost app]# echo 'export PATH=${JAVA_HOME}/bin:$PATH' | tee -a /etc/profile.d/java.sh
[root@localhost app]# source  /etc/profile


5. redis install
[root@localhost app]# tar xzf redis-3.2.8.tar.gz
[root@localhost app]# cd redis-3.2.8
[root@localhost redis-3.2.8]# make MALLOC=libc PREFIX=/mnt/app/redis install

[root@localhost redis-3.2.8]# echo 'export REDIS_HOME=/mnt/app/redis' | tee /etc/profile.d/redis.sh
[root@localhost redis-3.2.8]# echo 'export REDIS_BIN=$REDIS_HOME/bin' | tee -a /etc/profile.d/redis.sh
[root@localhost redis-3.2.8]# echo 'export PATH=$REDIS_BIN:$PATH' | tee -a /etc/profile.d/redis.sh
[root@localhost redis-3.2.8]# source /etc/profile

[root@localhost redis-3.2.8]# mkdir -p /mnt/app/redis/conf/6379
[root@localhost redis-3.2.8]# cp redis.conf /mnt/app/redis/conf/6379/

redis-cluster(一共2台物理机,分别在两台机器上创建三个redis节点):
[root@localhost redis-3.2.8]# mkdir -p /mnt/{data,log}/redis/{6379,6380,6381}
[root@localhost redis-3.2.8]# chown -R wisdom.wisdom /mnt/{data,log}/redis/{6379,6380,6381}

[root@localhost redis-3.2.8]# vim /mnt/app/redis/conf/6379/redis.conf
port 6379
cluster-enabled yes
cluster-config-file /mnt/data/redis/6379/nodes.conf
cluster-node-timeout 5000
appendonly yes
protected-mode no
dir /mnt/data/redis/6379
unixsocket /mnt/data/redis/6379/redis.sock
pidfile /mnt/data/redis/6379/redis.pid
logfile /mnt/log/redis/6379/redis.log

[root@localhost redis-3.2.8]# vim /mnt/app/redis/conf/6379/redis.conf
port 6380
cluster-enabled yes
cluster-config-file /mnt/data/redis/6380/nodes.conf
cluster-node-timeout 5000
appendonly yes
protected-mode no
dir /mnt/data/redis/6380
unixsocket /mnt/data/redis/6380/redis.sock
pidfile /mnt/data/redis/6380/redis.pid
logfile /mnt/log/redis/6380/redis.log

[root@localhost redis-3.2.8]# vim /mnt/app/redis/conf/6379/redis.conf
port 6381
cluster-enabled yes
cluster-config-file /mnt/data/redis/6381/nodes.conf
cluster-node-timeout 5000
appendonly yes
protected-mode no
dir /mnt/data/redis/6381
unixsocket /mnt/data/redis/6381/redis.sock
pidfile /mnt/data/redis/6381/redis.pid
logfile /mnt/log/redis/6381/redis.log

[root@localhost redis-3.2.8]# chown -R wisdom.wisdom /mnt/app/redis/conf

[root@localhost redis-3.2.8]# su - wisdom
[wisdom@localhost ~]$ /mnt/app/redis/bin/redis-server /mnt/app/redis/conf/6379/redis.conf &
[wisdom@localhost ~]$ /mnt/app/redis/bin/redis-server /mnt/app/redis/conf/6380/redis.conf &
[wisdom@localhost ~]$ /mnt/app/redis/bin/redis-server /mnt/app/redis/conf/6381/redis.conf &


[root@localhost ~]# yum -y install ruby rubygem-redis
[root@localhost ~]# cd /mnt/ops/app/redis-3.2.8/src/
[root@localhost src]# ruby redis-trib.rb create --replicas 1 192.168.18.226:6379 192.168.18.227:6381 192.168.18.226:6380 192.168.18.227:6379 192.168.18.226:6381 192.168.18.227:6380  

[root@localhost src]# ./redis-trib.rb check 127.0.0.1:6379
>>> Performing Cluster Check (using node 127.0.0.1:6379)
M: 0112e23e6a610f0b0b02693408d5fd2fde827bbc 127.0.0.1:6379
   slots:0-5460 (5461 slots) master
   1 additional replica(s)
S: 53466a022a3a92491ff6990f8117c1878888345b 192.168.18.226:6381
   slots: (0 slots) slave
   replicates 7668008d1593f639365390e9d7e0576a0ad739b1
M: 1ab69ef9565fe858858c5b2192248c6386ff5427 192.168.18.226:6380
   slots:10923-16383 (5461 slots) master
   1 additional replica(s)
S: e927b906a04e1e6d71b527893eca3153e6426f6d 192.168.18.227:6379
   slots: (0 slots) slave
   replicates 0112e23e6a610f0b0b02693408d5fd2fde827bbc
M: 7668008d1593f639365390e9d7e0576a0ad739b1 192.168.18.227:6381
   slots:5461-10922 (5462 slots) master
   1 additional replica(s)
S: b7a790dae2130afd385ae5eb71f9a7ebb33d55da 192.168.18.227:6380
   slots: (0 slots) slave
   replicates 1ab69ef9565fe858858c5b2192248c6386ff5427
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.

6. zookeeper install
[root@localhost app]# tar xzf zookeeper-3.4.6.tar.gz
[root@localhost app]# mv zookeeper-3.4.6 /mnt/app/zookeeper
[root@localhost app]# chown -R root.root /mnt/app/zookeeper

[root@localhost app]# echo 'export ZK_HOME=/mnt/app/zookeeper' | tee /etc/profile.d/zookeeper.sh
[root@localhost app]# echo 'export ZK_BIN=${ZK_HOME}/bin' | tee -a /etc/profile.d/zookeeper.sh                   
[root@localhost app]# echo 'export PATH=${ZK_BIN}:$PATH' | tee -a /etc/profile.d/zookeeper.sh                      
[root@localhost app]# source /etc/profile

[root@localhost app]# mkdir -p /mnt/{data,log}/zookeeper
[root@localhost app]# chown -R wisdom.wisdom /mnt/{data,log}/zookeeper


ZK-cluster-1:
[root@localhost app]# cat > /mnt/app/zookeeper/conf/zookeeper-env.sh <<EOF
\> ZOO_LOG_DIR=/mnt/log/zookeeper
\> EOF

[root@localhost app]# cat > /mnt/data/zookeeper/myid <<EOF
\> 228
\> EOF

[root@localhost app]# cat > /mnt/app/zookeeper/conf/zoo.cfg <<EOF
\> tickTime=2000
\> initLimit=5
\> syncLimit=2
\> clientPort=2181
\> clientPortAddress=192.168.18.228
\> maxClientCnxns=2000
\> autopurge.snapRetainCount=5
\> autopurge.purgeInterval=3
\> dataDir=/mnt/data/zookeeper
\> dataLogDir=/mnt/log/zookeeper
\> server.228=192.168.18.228:3181:4181
\> server.229=192.168.18.229:3181:4181
\> server.230=192.168.18.230:3181:4181
\> EOF

[root@localhost app]# chown -R wisdom.wisdom /mnt/app/zookeeper/conf
[root@localhost app]# su - wisdom
[wisdom@localhost ~]$ /mnt/app/zookeeper/bin/zkServer.sh start


ZK-cluster-2:
[root@localhost app]# cat > /mnt/app/zookeeper/conf/zookeeper-env.sh <<EOF
\> ZOO_LOG_DIR=/mnt/log/zookeeper
\> EOF

[root@localhost app]# cat > /mnt/data/zookeeper/myid <<EOF
\> 229
\> EOF

[root@localhost app]# cat > /mnt/app/zookeeper/conf/zoo.cfg <<EOF
\> tickTime=2000
\> initLimit=5
\> syncLimit=2
\> clientPort=2181
\> clientPortAddress=192.168.18.229
\> maxClientCnxns=2000
\> autopurge.snapRetainCount=5
\> autopurge.purgeInterval=3
\> dataDir=/mnt/data/zookeeper
\> dataLogDir=/mnt/log/zookeeper
\> server.228=192.168.18.228:3181:4181
\> server.229=192.168.18.229:3181:4181
\> server.230=192.168.18.230:3181:4181
\> EOF

[root@localhost app]# chown -R wisdom.wisdom /mnt/app/zookeeper/conf
[root@localhost app]# su - wisdom
[wisdom@localhost ~]$ /mnt/app/zookeeper/bin/zkServer.sh start


ZK-cluster-3:
[root@localhost app]# cat > /mnt/app/zookeeper/conf/zookeeper-env.sh <<EOF
\> ZOO_LOG_DIR=/mnt/log/zookeeper
\> EOF

[root@localhost app]# cat > /mnt/data/zookeeper/myid <<EOF
\> 230
\> EOF

[root@localhost app]# cat > /mnt/app/zookeeper/conf/zoo.cfg <<EOF
\> tickTime=2000
\> initLimit=5
\> syncLimit=2
\> clientPort=2181
\> clientPortAddress=192.168.18.230
\> maxClientCnxns=2000
\> autopurge.snapRetainCount=5
\> autopurge.purgeInterval=3
\> dataDir=/mnt/data/zookeeper
\> dataLogDir=/mnt/log/zookeeper
\> server.228=192.168.18.228:3181:4181
\> server.229=192.168.18.229:3181:4181
\> server.230=192.168.18.230:3181:4181
\> EOF

[root@localhost app]# chown -R wisdom.wisdom /mnt/app/zookeeper/conf
[root@localhost app]# su - wisdom
[wisdom@localhost ~]$ /mnt/app/zookeeper/bin/zkServer.sh start


7. erlang install
[root@localhost app]# tar xzf otp_src_19.2.tar.gz
[root@localhost app]# cd otp_src_19.2
[root@localhost otp_src_19.2]# ./configure --prefix=/mnt/app/erlang
or:
[root@localhost otp_src_19.2]# ./configure --prefix=/mnt/app/erlang --without-javac
[root@localhost otp_src_19.2]# make
[root@localhost otp_src_19.2]# make install

[root@localhost otp_src_19.2]# echo 'export ERLANG_HOME=/mnt/app/erlang' | tee /etc/profile.d/erlang.sh
[root@localhost otp_src_19.2]# echo 'export ERLANG_BIN=${ERLANG_HOME}/bin' | tee -a /etc/profile.d/erlang.sh
[root@localhost otp_src_19.2]# echo 'export PATH=${ERLANG_BIN}:$PATH' | tee -a /etc/profile.d/erlang.sh  
[root@localhost otp_src_19.2]# source /etc/profile

8. rabbitmq install
[root@localhost app]# xz -d rabbitmq-server-generic-unix-3.6.6.tar.xz
[root@localhost app]# tar xf rabbitmq-server-generic-unix-3.6.6.tar
[root@localhost app]# mv rabbitmq_server-3.6.6 /mnt/app/rabbitmq
[root@localhost app]# chown -R root.root /mnt/app/rabbitmq

[root@localhost app]# /mnt/app/rabbitmq/sbin/rabbitmq-plugins enable rabbitmq_management


[root@localhost app]# echo 'export RABBITMQ_HOME=/mnt/app/rabbitmq' | tee /etc/profile.d/rabbitmq.sh
[root@localhost app]# echo 'export RABBITMQ_BIN=${RABBITMQ_HOME}/sbin' | tee -a /etc/profile.d/rabbitmq.sh                    
[root@localhost app]# echo 'export PATH=${RABBITMQ_BIN}:$PATH' | tee -a /etc/profile.d/rabbitmq.sh                     
[root@localhost app]# source /etc/profile

[root@localhost app]# touch /mnt/app/rabbitmq/etc/rabbitmq/rabbitmq-env.conf
[root@localhost app]# touch /mnt/app/rabbitmq/etc/rabbitmq/rabbitmq.config
[root@localhost app]# chown -R wisdom.wisdom /mnt/app/rabbitmq/etc/

[root@localhost app]# mkdir -p /mnt/{data,log}/rabbitmq
[root@localhost app]# mkdir -p /mnt/data/rabbitmq/mnesia
[root@localhost app]# chown -R wisdom.wisdom /mnt/{data,log}/rabbitmq

RabbitMQ cluster-1:
[root@localhost app]# hostname rabbit228
[root@localhost app]# echo 'rabbit228' |tee /etc/hostname
[root@localhost app]# echo '192.168.18.228  rabbit228' |tee -a /etc/hosts
[root@localhost app]# echo '192.168.18.229  rabbit229' |tee -a /etc/hosts  
[root@localhost app]# echo '192.168.18.230  rabbit230' |tee -a /etc/hosts

RabbitMQ cluster-2:
[root@localhost app]# hostname rabbit229
[root@localhost app]# echo 'rabbit229' |tee /etc/hostname
[root@localhost app]# echo '192.168.18.228  rabbit228' |tee -a /etc/hosts
[root@localhost app]# echo '192.168.18.229  rabbit229' |tee -a /etc/hosts  
[root@localhost app]# echo '192.168.18.230  rabbit230' |tee -a /etc/hosts

RabbitMQ cluster-3:
[root@localhost app]# hostname rabbit230
[root@localhost app]# echo 'rabbit230' |tee /etc/hostname
[root@localhost app]# echo '192.168.18.228  rabbit228' |tee -a /etc/hosts
[root@localhost app]# echo '192.168.18.229  rabbit229' |tee -a /etc/hosts  
[root@localhost app]# echo '192.168.18.230  rabbit230' |tee -a /etc/hosts

RabbitMQ cluster-X:(三台机器都要执行)
[root@localhost app]# su - wisdom
[wisdom@localhost ~]$ cat > /mnt/app/rabbitmq/etc/rabbitmq/rabbitmq-env.conf <<EOF
\> RABBITMQ_NODE_IP_ADDRESS=
\> RABBITMQ_NODE_PORT=5672
\> RABBITMQ_DIST_PORT=25672
\> RABBITMQ_NODENAME=rabbit@\$HOSTNAME
\> RABBITMQ_MNESIA_BASE=/mnt/data/rabbitmq/mnesia
\> RABBITMQ_LOG_BASE=/mnt/log/rabbitmq
\> EOF

[wisdom@rabbitX ~]$ cat > /mnt/app/rabbitmq/etc/rabbitmq/rabbitmq.config <<EOF
\> [
\>  {rabbit,
\>   [
\>   ]},
\>  {kernel,
\>   [
\>   ]},
\>  {rabbitmq_management,
\>   [
\>   ]},
\>  {rabbitmq_shovel,
\>   [{shovels,
\>     [
\>     ]}
\>   ]},
\>  {rabbitmq_stomp,
\>   [
\>   ]},
\>  {rabbitmq_mqtt,
\>   [
\>   ]},
\>  {rabbitmq_amqp1_0,
\>   [
\>   ]},
\>  {rabbitmq_auth_backend_ldap,
\>   [
\>   ]}
\> ].
\> EOF

[wisdom@rabbitX ~]$ /mnt/app/rabbitmq/sbin/rabbitmq-server &
[wisdom@rabbitX ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl stop
[wisdom@rabbitX ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl status

1. 在228上找到elang.cookie
[wisdom@rabbit228 ~]$ cat ~/.erlang.cookie
HBSJBDVPUCEITCQZQQDB
2. 将.erlang.cookie内容copy到229和230这两台机器的~/.erlang.cookie文件中
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl stop
[wisdom@rabbit230 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl stop

[wisdom@rabbit229 ~]$ chmod 600 ~/.erlang.cookie
[wisdom@rabbit229 ~]$ echo HBSJBDVPUCEITCQZQQDB | tee ~/.erlang.cookie
[wisdom@rabbit229 ~]$ chmod 400 ~/.erlang.cookie  

[wisdom@rabbit230 ~]$ chmod 600 ~/.erlang.cookie
[wisdom@rabbit230 ~]$ echo HBSJBDVPUCEITCQZQQDB | tee ~/.erlang.cookie
[wisdom@rabbit230 ~]$ chmod 400 ~/.erlang.cookie

[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmq-server &
[wisdom@rabbit230 ~]$ /mnt/app/rabbitmq/sbin/rabbitmq-server &
3. 将229 RabbitMQ加入到228 RabbitMQ集群中(磁盘存储)
* 查看228节点的集群状态
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl -n rabbit@rabbit228 cluster_status
Cluster status of node rabbit@rabbit228 ...
[{nodes,[{disc,[rabbit@rabbit228,rabbit@rabbit229]}]},
 {running_nodes,[rabbit@rabbit228]},
 {cluster_name,<<"rabbit@rabbit228">>},
 {partitions,[]},
 {alarms,[{rabbit@rabbit228,[]}]}]
* 停止Rabbitmq服务
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl stop_app
* 清空229 Rabbit元数据
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl -n rabbit@rabbit229 reset
* 将229 Rabbit加入到228集群中
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl join_cluster rabbit@rabbit228
* 启动229 Rabbit服务
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl start_app
* 再次查看集群状态
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl -n rabbit@rabbit228 cluster_status
Cluster status of node rabbit@rabbit228 ...
[{nodes,[{disc,[rabbit@rabbit228,rabbit@rabbit229]}]},
 {running_nodes,[rabbit@rabbit228]},
 {cluster_name,<<"rabbit@rabbit228">>},
 {partitions,[]},
 {alarms,[{rabbit@rabbit228,[]}]}]
3. 将230 RabbitMQ加入到228 RabbitMQ集群中(内存存储)
[wisdom@rabbit230 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl stop_app
[wisdom@rabbit230 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl -n rabbit@rabbit230 reset
[wisdom@rabbit230 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl join_cluster rabbit@rabbit228 --ram
[wisdom@rabbit230 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl start_app

[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl -n rabbit@rabbit228 cluster_status
Cluster status of node rabbit@rabbit228 ...
[{nodes,[{disc,[rabbit@rabbit228,rabbit@rabbit229]},{ram,[rabbit@rabbit230]}]},
 {running_nodes,[rabbit@rabbit230,rabbit@rabbit229,rabbit@rabbit228]},
 {cluster_name,<<"rabbit@rabbit228">>},
 {partitions,[]},
 {alarms,[{rabbit@rabbit230,[]},{rabbit@rabbit229,[]},{rabbit@rabbit228,[]}]}]

4. 设置集群中所有的队列为镜像队列(任意一台机器上执行)
[wisdom@rabbit228 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl set_policy ha-all "^" '{"ha-mode":"all"}'

[wisdom@rabbit228 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl add_user pms pms123  
[wisdom@rabbit229 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl set_user_tags pms administrator
[wisdom@rabbit228 ~]$ /mnt/app/rabbitmq/sbin/rabbitmqctl set_permissions -p / pms ".\*" ".\*" ".\*"  

5. 安装haproxy,作为反向代理
[root@localhost app]# useradd -s /sbin/nologin haproxy

[root@localhost app]# tar xzf haproxy-1.7.2.tar.gz
[root@localhost app]# cd haproxy-1.7.2
[root@localhost haproxy-1.7.2]# make TARGET=generic PREFIX=/mnt/app/haproxy
[root@localhost haproxy-1.7.2]# make install PREFIX=/mnt/app/haproxy

[root@localhost haproxy-1.7.2]# echo 'export HAPROXY_HOME=/mnt/app/haproxy' | tee /etc/profile.d/haproxy.sh   
[root@localhost haproxy-1.7.2]# echo 'export HAPROXY_BIN=${HAPROXY_HOME}/sbin' | tee -a /etc/profile.d/haproxy.sh
[root@localhost haproxy-1.7.2]# echo 'export PATH=${HAPROXY_BIN}:$PATH' | tee -a /etc/profile.d/haproxy.sh       
[root@localhost haproxy-1.7.2]# source /etc/profile

[root@localhost haproxy-1.7.2]# mkdir -p /mnt/app/haproxy/conf

[root@localhost app]# vim /mnt/app/haproxy/conf/haproxy.cfg
global
    log /mnt/log/haproxy 127.0.0.1 local0
    log /mnt/log/haproxy 127.0.0.1 local1 notice
    stats socket /mnt/log/haproxy/haproxy.socket mode 770 level admin
    pidfile /mnt/log/haproxy/haproxy.pid
    maxconn 5000
    user haproxy
    group haproxy
    deamon

defaults
    log global
    mode tcp
    option tcplog
    option dontlognull
    retries 3
    option redispatch
    timeout connect 5s
    timeout client  120s
    timeout server  120s

listen haproxy_stats
    bind 0.0.0.0:8080
    stats refresh 30s
    stats uri /haproxy?stats
    stats realm Haproxy Manager
    stats auth admin:admin
    stats hide-version

listen rabbitmq_admin
    bind 0.0.0.0:8090
    server rabbit228 192.168.18.228:15672
    server rabbit229 192.168.18.229:15672
    server rabbit230 192.168.18.230:15672

listen rabbitmq_cluster
    bind 0.0.0.0:5672
    mode tcp
    option tcplog
    option clitcpka
    timeout client  3h
    timeout server  3h
    balance roundrobin
    server rabbit228 192.168.18.228:15672 check inter 5s rise 2 fall 3
    server rabbit229 192.168.18.229:15672 check inter 5s rise 2 fall 3
    server rabbit230 192.168.18.230:15672 check inter 5s rise 2 fall 3

[root@localhost haproxy-1.7.2]# /mnt/app/haproxy/sbin/haproxy -f /mnt/app/haproxy/conf/haproxy.cfg

在浏览器中打开:
http://192.168.18.223:8080/haproxy?stats    admin/admin
http://192.168.18.223:8090/   pms/pms123

9. postgresql install
[root@localhost app]# tar xzf postgresql-9.6.1.tar.gz
[root@localhost app]# cd postgresql-9.6.1
[root@localhost postgresql-9.6.1]# ./configure --prefix=/mnt/app/pgsql
[root@localhost postgresql-9.6.1]# make
[root@localhost postgresql-9.6.1]# make install

//安装自带插件安装
[root@localhost postgresql-9.6.1]# cd contrib/
[root@localhost contrib]# make install

[root@localhost contrib]# git clone https://github.com/postgrespro/pg_pathman /mnt/ops/app/postgresql-9.6.1/contrib/pg_pathman
[root@localhost contrib]# cd pg_pathman
[root@localhost pg_pathman]# make
[root@localhost pg_pathman]# make install

[root@localhost postgresql-9.6.1]# echo 'export PGSQL_HOME=/mnt/app/pgsql' | tee /etc/profile.d/postgresql.sh
[root@localhost postgresql-9.6.1]# echo 'export PGSQL_BIN=${PGSQL_HOME}/bin' | tee -a /etc/profile.d/postgresql.sh                   
[root@localhost postgresql-9.6.1]# echo 'export PATH=${PGSQL_BIN}:$PATH' | tee -a /etc/profile.d/postgresql.sh                        
[root@localhost postgresql-9.6.1]# source /etc/profile

[root@localhost postgresql-9.6.1]# mkdir -p /mnt/{data,log}/pgsql
[root@localhost postgresql-9.6.1]# chown -R wisdom.wisdom /mnt/{data,log}/pgsql

PG-master:
[root@localhost postgresql-9.6.1]# su - wisdom
[wisdom@localhost ~]$ /mnt/app/pgsql/bin/initdb -D /mnt/data/pgsql/

[wisdom@localhost ~]$ vim /mnt/data/pgsql/pg_hba.conf
local   all             all                                     trust
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
host    replication     repl            192.168.0.0/16          md5     =>追加语句
host    all             all             192.168.0.0/16          md5     =>其它用户访问策略

[wisdom@localhost ~]$ vim /mnt/data/pgsql/postgresql.conf
listen_addresses = '\*'
port = 5432
wal_level = replica
max_wal_senders = 5
wal_keep_segments = 64
synchronous_standby_names = '\*'
archive_mode = on
archive_command = 'DIR=/mnt/log/pgsql/archive/$(date +%Y%m%d);test ! -d $DIR && mkdir -p $DIR;test ! -f $DIR/%f && cp %p $DIR/%f'
shared_preload_libraries = 'pg_pathman,pg_stat_statements'

[root@localhost postgresql-9.6.1]# cat >> /etc/sysctl.conf <<EOF
\> kernel.sem = 50100 128256000 50100 2560
\> EOF
[root@localhost postgresql-9.6.1]# sysctl -p

[wisdom@localhost ~]$ /mnt/app/pgsql/bin/pg_ctl -D /mnt/data/pgsql/ -l /mnt/log/pgsql/pgsql.log start


[wisdom@localhost ~]$ /mnt/app/pgsql/bin/psql -d postgres

postgres=# create user repl superuser password 'klip2[gE0_%y';
postgres=# create extension pgcrypto;
postgres=# create extension pg_pathman;
postgres-# \q
[wisdom@localhost ~]$ /mnt/app/pgsql/bin/pg_ctl -D /mnt/data/pgsql/ -l /mnt/log/pgsql/pgsql.log restart

PG-slave:
[root@localhost postgresql-9.6.1]# su - wisdom
[wisdom@localhost ~]$ /mnt/app/pgsql/bin/pg_basebackup -F p --progress -R -D /mnt/data/pgsql/ -h 192.168.18.226 -p 5432 -U repl --password
Password:
22824/22824 kB (100%), 1/1 tablespace
NOTICE:  pg_stop_backup complete, all required WAL segments have been archived

[wisdom@localhost ~]$ vim /mnt/data/pgsql/recovery.conf
standby_mode = 'on'
primary_conninfo = 'user=repl password=klip2[gE0_%y host=192.168.18.226 port=5432 sslmode=disable sslcompression=1'
recovery_target_timeline = 'latest'

[wisdom@localhost ~]$ vim /mnt/data/pgsql/postgresql.conf
listen_addresses = '\*'
port = 5432

hot_standby = on
max_standby_streaming_delay = 30s
wal_receiver_status_interval = 1s
hot_standby_feedback = on

[wisdom@localhost ~]$ chmod 700 /mnt/data/pgsql
[wisdom@localhost ~]$ /mnt/app/pgsql/bin/pg_ctl -D /mnt/data/pgsql/ -l /mnt/log/pgsql/pgsql.log start


PG-master：
[wisdom@localhost ~]$ /mnt/app/pgsql/bin/psql -d postgres
1.创建用户
postgres=# create user "grp_dev" with password '123456';     
postgres=# create user "pcm_dev" with password '123456';   
postgres=# create user "pms_dev" with password '123456';       
2.创建数据库
postgres=# create database grp_dev with owner=grp_dev encoding=UTF8;
postgres=# create database pcm_dev with owner=pcm_dev encoding=UTF8;      
postgres=# create database pms_dev with owner=pms_dev encoding=UTF8;
3.授权
postgres=# grant all privileges on database grp_dev to grp_dev;
postgres=# grant all privileges on database pcm_dev to pcm_dev;   
postgres=# grant all privileges on database pms_dev to pms_dev;


---
1.创建role
[wisdom@localhost ~]$ /mnt/app/pgsql/bin/psql -d postgres
postgres=# create role pms with login;
CREATE ROLE

2.创建用户grp_dev并加入角色pms
postgres=# create user grp_dev with in role pms password '123456';
CREATE ROLE

postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 grp_dev   |                                                            | {pms}
 pms       | Cannot login                                               | {}
 repl      | Superuser                                                  | {}
 wisdom    | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

3.创建数据库
postgres=# create database grp_dev;
CREATE DATABASE
postgres=# \l
                               List of databases
   Name    | Owner  | Encoding |   Collate   |    Ctype    | Access privileges
-----------+--------+----------+-------------+-------------+-------------------
 grp_dev   | wisdom | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres  | wisdom | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | wisdom | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/wisdom        +
           |        |          |             |             | wisdom=CTc/wisdom
 template1 | wisdom | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/wisdom        +
           |        |          |             |             | wisdom=CTc/wisdom
(4 rows)

4.授权
postgres=# grant all privileges on database grp_dev to pms;              
GRANT

5.创建一个schema
[wisdom@localhost ~]$ /mnt/app/pgsql/bin/psql -d grp_dev -U grp_dev
grp_dev=> create schema grp_dev;
CREATE SCHEMA

10. tomcat install
[root@localhost app]# mkdir /mnt/app/tomcat
[root@localhost app]# tar xzf apache-tomcat-8.0.41.tar.gz
[root@localhost app]# mv apache-tomcat-8.0.41 /mnt/app/tomcat/tomcat
[root@localhost app]# chown -R  wisdom.wisdom /mnt/app/tomcat  

[root@localhost bin]# mkdir -p /mnt/log/tomcat/tomcat
[root@localhost bin]# mkdir /mnt/web/webapp
[root@localhost bin]# chown -R wisdom.wisdom /mnt/log/tomcat
[root@localhost bin]# chown -R wisdom.wisdom /mnt/web/webapp
