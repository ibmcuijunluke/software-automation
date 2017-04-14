#############PMS_CLoud_Local本地部署Solution##################
1.Hardware/Server Option 硬件服务器的选型
服务器型号 配置 参数选型的Solution
选型 报价
2.Software/Virtualization Option 软件/虚拟化/PMS虚拟机的选型 报价
2.1 HostOS Installation 服务器主机OS的安装和设置 Solution TBD 列出具体的解决方案 并且列出选型解决方案的具体原因
2.2 Virtualization Installation 服务器主机OS的虚拟化软件的安装和设置 Solution TBD 列出具体的解决方案 并且列出选型解决方案的具体原因
2.3 PMS Local VM Installation PMS本地部署虚拟机的部署方案和架构 安装和设置 OS Solution TBD 列出具体的解决方案 并且列出选型解决方案的具体原因
3.Automation Tool Develop & Setup &Usage
3.1 Automation Tool 开发和使用
3.2 Automation Tool UI配置实施界面和客户监控界面的开发和使用
3.3 Database Backup& Sych Automation Tools.
4.Customer Monitor Service Option & Usage
4.1 客户本地部署服务的监控ui的使用
4.2 客户本地部署服务的Troubleshooting
5.Deploy Engineer & Customer Training & Usage
5.1 实施工程师的培训和使用
5.2 客户的培训使用
6.Build Auto-Sych Deploy Solution TBD build的自动同步更新 2期以后实现
Tips:
以上是我列出的PMS本地部署的具体的方案子，请根据我们的方案,列出你的具体开发和实施培训的方案子.
这个方案 要有具体的计划 开发 使用 培训的步骤。
这个方案 涉及人群包括 研发 运维 实施 以及客户。
这个方案 要列出来 这套解决方案和工具开发完成以后，
研发 需要 如何使用， 做一些什么
实施 需要 如何使用， 做一些什么
客户以及客户的运维人员 需要 如何使用， 做一些什么
=======================================================================================

R&D,and QA Machine Information as below:
序号	项目	　	操作系统	版本	内网IP	用户名	密码	内存	CPU	说明	 
1	mysql-5.6（主）	master	linux（64位）	RHEL7或CENTOS7	192.168.18.200	root	JdaQC5qN	4G	1核	虚拟机	 
2	mysql-5.6（从）	slave	linux（64位）	RHEL7或CENTOS7	192.168.18.201	root	CMXVuXMg	4G	1核	虚拟机	 
3	zookeeper-3.4.8	server1	linux（64位）	RHEL7或CENTOS7	192.168.18.202	root	xHjCyaS6	4G	1核	虚拟机	　
4	zookeeper-3.4.8	server2	linux（64位）	RHEL7或CENTOS7	192.168.18.203	root	3aLg5KDp	4G	1核	虚拟机	　
5	web apache mod_jk	server1	linux（64位）	RHEL7或CENTOS7	192.168.18.204	root	JnBDRynT	4G	1核	虚拟机	　
6	web apache mod_jk	server2	linux（64位）	RHEL7或CENTOS7	192.168.18.205	root	FtPbLq8k	4G	1核	虚拟机	　
7	server（ git + jenkins）	server1	linux（64位）	RHEL7或CENTOS7	192.168.18.206	root	RrFHNxAa	4G	1核	虚拟机	 
8	server（ git + jenkins）	server2	linux（64位）	RHEL7或CENTOS7	192.168.18.207	root	uJLGvEkF	4G	1核	虚拟机	 
9	zookeeper-3.4.8	server3	linux（64位）	RHEL7或CENTOS7	192.168.18.208	root	66wygPtv	4G	1核	虚拟机	　
10	redis64-3.0共享存储	三主从	linux（64位）	RHEL7或CENTOS7	192.168.18.209	root	yRU5skRh	4G	1核	虚拟机	　

序号	项目	　	操作系统	版本	内网IP	用户名	密码	内存	CPU	说明	 
11	消息队列镜像模式集群	mq1	linux（64位）	RHEL7或CENTOS7	192.168.18.211	root	dyLvEa2p	4G	1核	虚拟机	 
12	消息队列镜像模式集群	mq2	linux（64位）	RHEL7或CENTOS7	192.168.18.212	root	V6qdVWbp	4G	1核	虚拟机	 
13	消息队列镜像模式集群	mq3	linux（64位）	RHEL7或CENTOS7	192.168.18.213	root	KnBdAwcd	4G	1核	虚拟机	 
14	埋点 分布式配置管理	GA	linux（64位）	RHEL7或CENTOS7	192.168.18.214	root	eNw6Luth	4G	1核	虚拟机	 
15	Mycat集群	mycat1	linux（64位）	RHEL7或CENTOS7	192.168.18.215	root	UbjJTfjp	4G	1核	虚拟机	 
16	Mycat集群	mycat2	linux（64位）	RHEL7或CENTOS7	192.168.18.216	root	bE5yVRED	4G	1核	虚拟机	 
17	自动化（Jenkins）	server	linux（64位）	RHEL7或CENTOS7	192.168.18.217	root	sFAQRqsR	4G	1核	虚拟机	　
18	Nginx Proxy	proxy1	linux（64位）	RHEL7或CENTOS7	192.168.18.218	root	xUDnpjPD	4G	1核	虚拟机	 
19	Nginx Proxy	proxy2	linux（64位）	RHEL7或CENTOS7	192.168.18.219	root	cqvfYr7v	4G	1核	虚拟机	 
20	对象存储服务 私有仓库	server	linux（64位）	RHEL7或CENTOS7	192.168.18.220	root	D4N364Mj	4G	1核	虚拟机	　

测试开发联调机器信息

开发调试后端服务	Windows	Windows	Windows	192.168.18.35	Administrator\123456	 




分布式测试环境机器信息 8 Machine SetUp

项目
操作系统
版本
版本
内网IP
用户名/ 密码
 	Nodejs Ngnix	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.223	root/zh123456
 	Tomcat Java	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.224	root/zh123456
 	Tomcat Java	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.225	root/zh123456
 	PostgreSQL Master	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.226	root/zh123456
 	PostgreSQL Slave	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.227	root/zh123456
 	MQ/ZK/Redis Cluster	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.228	root/zh123456
 	MQ/ZK/Redis Cluster	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.229	root/zh123456
 	MQ/ZK/Redis Cluster	Linux	linux（64位）	RHEL7或CENTOS7	192.168.18.230	root/zh123456

阿里云生产环境机器信息 8 Machine SetUp  -TBD
机器编号
项目
操作系统
版本
版本
内网IP
用户名/ 密码




应急环境环境机器信息  -TBD
