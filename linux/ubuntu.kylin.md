sudo gedit /etc/apt/sources.list
1）下载一个deb格式的软件kismet

curl https://www.kismetwireless.net/code/dists/quantal/kismet/binary-i386/kismet-2011.03.2.i386.deb >kismet-2011.03.2.i386.deb

2）安装kismet

dpkg -i kismet-2011.03.2.i386.deb

3）根据提示安装相关包

sudo apt-get install libnl2
删除 MySQL

sudo apt-get autoremove --purge mysql-server-*
sudo apt-get remove mysql-server
sudo apt-get autoremove mysql-server
sudo apt-get remove mysql-common
清理残留数据

dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P

sudo mysqladmin -u root password newpassword
