

sudo apt-get update

sudo apt-get upgrade

sudo adduser git //创建用户  密码 *******

su git//切换到git用户

cd ~  //进入用户git根目录



sudo apt-get install git //安装git

git --version //检查git是否安装成功



sudo apt-get install mysql-server //安装mysql数据库    账户：root  密码：********

mysql --version //检查mysql版本判断是否安装成功

//创建数据gogs

mysql -u root -p
mysql> SET GLOBAL storage_engine = 'InnoDB';
mysql> CREATE DATABASE gogs CHARACTER SET utf8 COLLATE utf8_bin;
mysql> GRANT ALL PRIVILEGES ON gogs.* TO ‘root’@‘localhost’ IDENTIFIED BY ‘itadmin’;
mysql> FLUSH PRIVILEGES;
mysql> QUIT；

sudo mkdir goapp //go应用安装目录

//安装golang环境

sudo wget http://www.golangtc.com/static/go/go1.4.1.linux-amd64.tar.gz    //下载64位二进制文件

解压缩二进制文件

tar -xzvf go1.4.1.linux-amd64.tar.gz -C /var/opt/

然后可以在/var/opt/的目录下发现一个go文件夹，这里包含了golang环境文件

配置golang环境

echo export GOROOT=/var/opt/go >> .bashrc

echo export GOBIN=$GOROOT/bin >> .bashrc

echo export GOARCH=amd64 >> .bashrc

echo export GOOS=linux >> .bashrc

echo export GOPATH=/home/gogs/goapp >> .bashrc

echo export PATH=.:$PATH:$GOBIN >> .bashrc

使配置环境立马生效

source  .bashrc

使用env命令检查golang是否安装成功

go env

sudo mkdir repositories //创建仓库目录

cd goapp

sudo wget  http://gogs.dn.qbox.me/gogs_v0.5.13_linux_amd64.zip   //下载gogs

sudo apt-get install zip //安装zip工具用于解压缩*.zip文件

sudo unzip gogs_v0.5.11_linux_amd64.zip //解压gogs文件

ls // 查看/home/git/goapp目录下文件和文件夹

cd gogs //进入解压创建的文件gogs

mkdir custom

mkdir custom/conf //创建自定义配置文件目录

sudo chmod -R 777 custom //修改custom文件夹权限

mkdir log  //创建日志目录

sudo chmod -R 777 log//修改log文件夹权限


启动gogs
cd /home/git/goapp/gogs

./gogs web

然后访问 http://localhost:3000/install来完成首次运行的配置工作
