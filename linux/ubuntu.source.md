1.备份源配置文件

sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup

2.用编辑器打开源配置文件

sudo vim /etc/apt/sources.list

3.删除文件内容，更换为以下内容（也可使用其他源）

deb http://mirrors.aliyun.com/ubuntu trusty main restricted
deb-src http://mirrors.aliyun.com/ubuntu trusty main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb http://mirrors.aliyun.com/ubuntu trusty-updates main restricted
deb-src http://mirrors.aliyun.com/ubuntu trusty-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://mirrors.aliyun.com/ubuntu trusty universe
deb-src http://mirrors.aliyun.com/ubuntu trusty universe
deb http://mirrors.aliyun.com/ubuntu trusty-updates universe
deb-src http://mirrors.aliyun.com/ubuntu trusty-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://mirrors.aliyun.com/ubuntu trusty multiverse
deb-src http://mirrors.aliyun.com/ubuntu trusty multiverse
deb http://mirrors.aliyun.com/ubuntu trusty-updates multiverse
deb-src http://mirrors.aliyun.com/ubuntu trusty-updates multiverse

## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb http://mirrors.aliyun.com/ubuntu trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu trusty-backports main restricted universe multiverse

deb http://security.ubuntu.com/ubuntu trusty-security main restricted
deb-src http://security.ubuntu.com/ubuntu trusty-security main restricted
deb http://security.ubuntu.com/ubuntu trusty-security universe
deb-src http://security.ubuntu.com/ubuntu trusty-security universe
deb http://security.ubuntu.com/ubuntu trusty-security multiverse
deb-src http://security.ubuntu.com/ubuntu trusty-security multiverse



4.执行以下命令，刷新
sudo apt-get clean
sudo apt-get update


重要的事情说三遍：配置好上网信息（ip，DNS等），电脑插上网线.....
1、首先备份Ubuntu源列表
[plain] view plain copy
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup  
     或者
[plain] view plain copy
cd /etc/apt/  
sudo cp sources.list sources.list.bak  

 2、打开更新源列表
[plain] view plain copy
sudo gedit /etc/apt/sources.list  

3、选择更新源地址
      可将更新源地址复制到 sources.list中去（注意文件权限），例如重庆大学源地址（代码）如下：
[plain] view plain copy
deb http://mirrors.cqu.edu.cn/ubuntu/ trusty main restricted universe multiverse  
deb http://mirrors.cqu.edu.cn/ubuntu/ trusty-security main restricted universe multiverse  
deb http://mirrors.cqu.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse  
deb http://mirrors.cqu.edu.cn/ubuntu/ trusty-proposed main restricted universe multiverse  
deb http://mirrors.cqu.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse  
deb-src http://mirrors.cqu.edu.cn/ubuntu/ trusty main restricted universe multiverse  
deb-src http://mirrors.cqu.edu.cn/ubuntu/ trusty-security main restricted universe multiverse  
deb-src http://mirrors.cqu.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse  
deb-src http://mirrors.cqu.edu.cn/ubuntu/ trusty-proposed main restricted universe multiverse  
deb-src http://mirrors.cqu.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse  
      把上面的地址“全部“”复制到sources.list中。可根据个人情况选择更新源，个人觉得重庆大学更新源速度比较快，而且有各个版本ubuntu的更新源，比较推荐，所以在此列出：
       重庆大学镜像地址： http://mirrors.cqu.edu.cn
       切换ubuntu系统源到重庆大学镜像源方法（其它镜像源设置方法都一样）的wiki见下边链接：
http://mirrors.cqu.edu.cn/wiki/index.php?title=Ubuntu

4、 更新源列表信息：    
[html] view plain copy
sudo apt-get update  
必须执行这一步骤，在执行这一步时如有提示错误，则找到相关内容将其注释掉（可能会出现网站无法连接的情况，将相关网站注释掉即可），想省事儿可以在第三步把 sources.list中内容全部删除，然后将需要的更新源的地址复制进去即可。若在软件更新界面为刷新，可以尝试重启。

源地址服务器列表（可参考http://wiki.ubuntu.org.cn/Qref/Source）如下：

可将 http://cn.archive.ubuntu.com/ubuntu/ 替换为下列任意服务器：
Ubuntu 官方（欧洲，国内较慢，无同步延迟）
http://archive.ubuntu.com/ubuntu/
Ubuntu 官方中国（目前是阿里云）
http://cn.archive.ubuntu.com/ubuntu/
网易（广东广州电信/联通千兆双线接入）
http://mirrors.163.com/ubuntu/
搜狐（山东联通千兆接入）
http://mirrors.sohu.com/ubuntu/
阿里云（北京万网/浙江杭州阿里云服务器双线接入）
http://mirrors.aliyun.com/ubuntu/
中国开源软件中心
http://mirrors.oss.org.cn/ubuntu/
首都在线科技
http://mirrors.yun-idc.com/ubuntu/
Linux Story:http://mirrors.linuxstory.org/ubuntu/
贝特康姆（江苏常州电信）
http://centos.bitcomm.cn/ubuntu
Linux运维派
https://mirrors.skyshe.cn/ubuntu/
教育网
以下服务器有教育网接入，推荐教育网用户使用 IPv6：
中科大 LUG（合肥，电信/联通/移动/教育网自动分流，同时也是 Deepin 官方）
https://mirrors.ustc.edu.cn/ubuntu/(v4/v6) http://mirrors4.ustc.edu.cn/ubuntu/ (v4) http://mirrors6.ustc.edu.cn/ubuntu/ (v6)
中科院 OpenCAS
http://mirrors.opencas.cn/ubuntu/
清华 TUNA（教育网核心节点百兆接入，已计划提高到千兆）
http://mirrors.tuna.tsinghua.edu.cn/ubuntu/(v4/v6) http://mirrors.4.tuna.tsinghua.edu.cn/ubuntu/ (v4) http://mirrors.6.tuna.tsinghua.edu.cn/ubuntu/ (v6)
中国地质大学开源镜像站，中国地质大学点石团队
http://mirrors.cug.edu.cn/ubuntu/(v4/v6) http://mirrors.cug6.edu.cn/ubuntu/ (v6)
北京交通大学更新服务器（教育网/电信百兆接入），由北交信息中心赞助
http://mirror.bjtu.edu.cn/ubuntu/(v4/v6) http://mirror6.bjtu.edu.cn/ubuntu/ (v6)
北京理工大学
http://mirror.bit.edu.cn/(v4/v6) http://mirror.bit6.edu.cn/ubuntu/ (v6)
北京化工大学
http://ubuntu.buct.cn/ubuntu/(v4/v6) http://ubuntu.buct6.edu.cn/ubuntu/ (v6)
天津大学，天津大学信息与网络协会和天津大学自由软件联盟(校外限 IPv6 访问)
http://mirror.tju.edu.cn/ubuntu/(v4/v6) http://mirror.tju6.edu.cn/ubuntu/ (v6)
南开大学，限教育网访问
http://ftp.nankai.edu.cn/ubuntu/
山东理工大学，限校内访问
http://mirrors.sdutlinux.org/ubuntu/
东北大学
http://ftp.neu.edu.cn/mirrors/ubuntu/(v4/v6) http://ftp.neu6.edu.cn/mirrors/ (v6)
哈尔滨工业大学
http://run.hit.edu.cn/ubuntu/(v4/v6) http://run6.hit.edu.cn/ubuntu/ (v6)
吉林大学，由吉林大学网络中心维护
http://mirrors.jlu.edu.cn/ubuntu/
大连理工大学
http://mirror.dlut.edu.cn/ubuntu/
上海交通大学（教育网千兆接入，联通/电信线路情况不详）
http://ftp.sjtu.edu.cn/ubuntu/(v4/v6) http://ftp6.sjtu.edu.cn/ubuntu/ (v6)
江苏开放大学，由江苏开放大学技术中心维护
http://mirrors.jstvu.edu.cn/ubuntu/
南京师范大学，限校内访问
http://mirrors.njnu.edu.cn/ubuntu/
南京信息工程大学，限教育网访问
http://mirrors.duohuo.org/ubuntu/
浙江大学，由浙江大学Linux用户组维护
http://mirrors.zjustu.org/ubuntu/
华中科技大学，由华中科技大学网络与计算中心维护
http://mirrors.hust.edu.cn/ubuntu/
华中科大联创团队，由华中科技大学启明学院的联创团队维护
http://mirrors.hustunique.com/ubuntu/
厦门大学，由厦门大学信息与网络中心维护
http://mirrors.xmu.edu.cn/ubuntu/archive/(v4/v6) http://mirrors.xmu6.edu.cn/ubuntu/ (v6)
中山大学，由中山大学网络与信息技术中心维护
http://mirror.sysu.edu.cn/ubuntu/
电子科技大学（位于成都），由电子科技大学学生宿舍网络管理委员会维护，仅包含 Ubuntu 镜像
http://ubuntu.dormforce.net/ubuntu/
重庆大学，由重庆大学蓝盟维护
http://mirrors.cqu.edu.cn/ubuntu/
西安交通大学，由西安交通大学众享社维护
http://ubuntu.xjtuns.cn/ubuntu/
西安电子科技大学，限教育网访问
http://ftp.xdlinux.info/ubuntu/
兰州大学，由兰州大学开源社区维护
http://mirror.lzu.edu.cn/ubuntu/
大陆地区以外
香港中文大学更新服务器，由香港中文大学资讯科技服务处维护
http://ftp.cuhk.edu.hk/pub/Linux/ubuntu
香港 01link 更新服务器，由香港联达网络服务有限公司维护
http://ubuntu.01link.hk
香港 uhost 更新服务器，由香港互联科技有限公司维护
http://ubuntu.uhost.hk
台湾的官方源。速度有时甚至快于内地的，包含 ian 等其他镜像
http://tw.archive.ubuntu.com/ubuntu
