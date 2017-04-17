Ubuntu 16.04发布了，带来了很多新特性，同样也依然带着很多不习惯的东西，所以装完系统后还要进行一系列的优化。
1.删除libreoffice
libreoffice虽然是开源的，但是Java写出来的office执行效率实在不敢恭维，装完系统后果断删掉
?
1
sudo apt-get remove libreoffice-common
2.删除Amazon的链接
?
1
sudo apt-get remove unity-webapps-common
 3.删掉基本不用的自带软件（用的时候再装也来得及）
?
1
2
3
sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install

sudo apt-get remove onboard deja-dup
这样系统就基本上干净了。
4.安装Vim
居然默认没有集成Vim神器，只能手动安装了。
?
1
sudo apt-get install vim
5.设置时间使用UTC
?
1
sudo vim /etc/default/rcS
将UTC=no改为UTC=yes
6.安装Chrome
到 https://dl.google.com/Linux/direct/google-chrome-stable_current_amd64.deb 下载最新的安装文件。
然后
?
1
2
3
sudo apt-get install libappindicator1 libindicator7
sudo dpkg -i google-chrome-stable_current_amd64.deb  
sudo apt-get -f install
这样以后就可以apt安装和更新chrome浏览器了。
7.安装搜狗输入法
vim /etc/apt/sources.list.d/ubuntukylin.list文件，加入ubuntu kylin的apt源
?
1
deb http://archive.ubuntukylin.com:10006/ubuntukylin trusty main
然后
?
1
2
sudo apt-get update
sudo apt-get install sogoupinyin
这样就可以apt安装和更新搜狗输入法了。
8.安装WPS Office
目前MS一直不出Linux版的Office，只能凑合着用WPS了
?
1
sudo apt-get install wps-office
9.安装Oracle Java
?
1
2
3
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update  
sudo apt-get install oracle-java8-installer
由于系统自带的是OpenJDK，卸载OpenJDK之后会带有残留，导致运行
?
1
java -version
时第一行不是java的版本号，会是Picked up JAVA_TOOL_OPTIONS: -javaagent:/usr/share/java/jayatanaag.jar这个提示，导致很多检测java版本号的脚本会运行出错，因此需要手动清除残留。
?
1
sudo rm /usr/share/upstart/sessions/jayatana.conf
删除/usr/share/upstart/sessions/jayatana.conf文件，重启之后再运行java -version就不会再有Picked
 up JAVA_TOOL_OPTIONS: -javaagent:/usr/share/java/jayatanaag.jar提示了。
10.安装Sublime Text 3
?
1
2
3
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update  
sudo apt-get install sublime-text
11.安装经典菜单指示器
?
1
2
3
sudo add-apt-repository ppa:diesch/testing
sudo apt-get update
sudo apt-get install classicmenu-indicator
12.安装系统指示器SysPeek
?
1
2
3
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update  
sudo apt-get install syspeek
13.自定义DHCP网络的DNS Server IP地址
sudo vim /etc/dhcp/dhclient.conf文件，在第21行#prepend domain-name-servers 127.0.0.1;下一行添加如下2行使用aliyun和114的DNS
?
1
2
prepend domain-name-servers 114.114.114.114;
prepend domain-name-servers 223.5.5.5;
这样可以优先使用aliyun的dns，次要使用114的DNS。
14.安装git和vpnc
git和vpn大家都懂的，程序员的好工具。
?
1
sudo apt-get install vpnc git
15.安装axel
axel是Linux命令行界面的多线程下载工具，比wget的好处就是可以指定多个线程同时在命令行终端里下载文件。
?
1
sudo apt-get install axel
安装之后，就可以代替wget用多线程下载了。
16.安装openssh-server
?
1
sudo apt-get install openssh-server
安装之后，就可以在Win下用ssh工具远程登陆了，当然也多了一个安全隐患，如果不想远程登陆本机的话，可以不装openssh-server。
17.安装CMake和Qt Creator
CMake和Qt Creator是Linux下开发C++程序的神器，Ubuntu 15.04已经集成了最新版的Qt Creator （3.1.1）。
?
1
sudo apt-get install cmake qtcreator
18.安装ExFat文件系统驱动
Ubuntu默认不支持exFat文件系统的挂载，需要手动安装exfat的支持
?
1
sudo apt-get install exfat-fuse
装上exfat-fuse之后就可以挂载exfat分区的磁盘了。
19.安装lnav
lnav工具是在终端界面看日志的神器
?
1
sudo apt-get install lnav
装上之后在终端里就可以用lnav彩色显示日志了。
20.安装unrar
系统默认不带解压缩rar文件的功能，手动安装unrar程序
?
1
sudo apt-get install unrar
装上之后就可以用命令解压缩rar文件了。
使用如下命令解压缩文件到当前目录。
?
1
unrar x test.rar
以上就是本文的全部内容，希望对大家的学习有所帮助，也希望大家多多支持脚本之家。
原文链接：http://blog.csdn.net/skykingf/article/details/45267517/



########################################################################################

问题：系统重装后，安装和配置SSH，防火墙配置

#安装install openssh-server
sudo apt install openssh-server -y
遇到问题：
sudo apt install openssh-server -y
正在读取软件包列表... 完成
正在分析软件包的依赖关系树
正在读取状态信息... 完成
有一些软件包无法被安装。如果您用的是 unstable 发行版，这也许是
因为系统无法达到您要求的状态造成的。该版本中可能会有一些您需要的软件
包尚未被创建或是它们已被从新到(Incoming)目录移出。
下列信息可能会对解决问题有所帮助：
下列软件包有未满足的依赖关系：
?
1
openssh-server : 依赖: openssh-client (= 1:7.1p1-4)
依赖: openssh-sftp-server 但是它将不会被安装
推荐: ssh-import-id 但是它将不会被安装
E: 无法修正错误，因为您要求某些软件包保持现状，就是它们破坏了软件包间的依赖关系。
解决方法：
ubuntu自带的有openssh-client,所以可以通过
ssh username@host
来远程连接linux
可是要想通过ssh被连接,ubuntu系统需要有openssh-server,可以通过
?
1
ps -e | grep ssh
来查看,如果没有显示sshd则说明没有安装openssh-server
可通过
?
1
sudo apt-get install openssh-server
来安装openssh-server,如果顺利的话会安装成功,如果遇到
?
1
$ sudo apt install openssh-server -y
正在读取软件包列表... 完成
正在分析软件包的依赖关系树
正在读取状态信息... 完成
有一些软件包无法被安装。如果您用的是 unstable 发行版，这也许是
因为系统无法达到您要求的状态造成的。该版本中可能会有一些您需要的软件
包尚未被创建或是它们已被从新到(Incoming)目录移出。
下列信息可能会对解决问题有所帮助：
下列软件包有未满足的依赖关系：
openssh-server : 依赖: openssh-client (= 1:7.1p1-4)
依赖: openssh-sftp-server 但是它将不会被安装
推荐: ssh-import-id 但是它将不会被安装
E: 无法修正错误，因为您要求某些软件包保持现状，就是它们破坏了软件包间的依赖关系。
这是因为,openssh-server是依赖于openssh-clien的,那ubuntu不是自带了openssh-client吗?原由是自带的openssh-clien与所要安装的openssh-server所依赖的版本不同,这里所依赖的版本是
1:7.1p1-4
所以要安装对应版本的openssh-clien,来覆盖掉ubuntu自带的
PS：下面看下ubuntu无法安装openssh-server的解决方法
使用ubuntu安装的命令
?
1
sudo apt-get install openssh-server
出现如下的错误
现在没有可用的软件包 openssh-server,但是它被其它的软件包引用了.
这可能意味着这个缺失的软件包可能已被废弃,或者只能在劳动保险发布源中找到.
E:软件包openssh-server还没有可供安装的候选者
解决方法
命令：
?
1
sudo apt-get update
之后用如下命令下载openssh-server
命令：
?
1
sudo apt-get install openssh-server
这样就OK
检查ssh服务开启状态

ps -s | grep ssh
#启用ssh的指令
启动ssh服务：
#sudo /etc/init.d/ssh start
停止ssh服务：
#sudo /etc/init.d/ssh stop
重启ssh服务：
#sudo /etc/init.d/ssh restart


1、帮助
      --help简单的帮助
      help command 较详细的帮助
      man command 最详细的帮助
2、ls 命令
      ls -a 显示全部的文件及文件夹，包括隐藏的文件或文件夹
      ls -l 显示较全的文件信息，包括权限、用户、用户组等。
      ls --color 显示文件及文件夹，并标有不同的颜色。
3、tab键
      tab command 用于当你的命令记不全时，输入一部再按一下进行补全，如果有多个前面部分相同命令，则
      按两次tab键
4、alias
      alias ubuntu="ls" 用于为一个命令取别名。当你输入ubuntu时等价于输入了ls命令。

(二)ubuntu 基本命令二

1、which
      which command 用于查找你所执行的命令文件存放的目录.
2、env
     当前用户的运行环境。
3、echo
      echo $PSTH 查看环境变量的路径有哪些，which命令使用时就是在环境变量的目录里面查找命令文件
      所存放的目录，从前到后。
4、cmp
     cmp /bin/ls /bin/dir 用于比较两个文件是否是完全相同的。
5、cp
     cp /bin/ls /bin/a 用于复制文件的命令。这时就复制了一个命令文件，就可以运行a命令，与ls用法相同。
6、drwxr-xr-x
     前面的d表示是一个文件夹，若为-表示是一个文件。
     rwx表示文件所有者拥有 读写执行 的权限
     r-x 表示文件所有者所在组的权限 读执行
     r-x 表示其他人所拥有的权限 读执行。
7、chmod
     用于改为用户对于文件的操作权限。chmod 0+r 添加读的权限。sudo chmod 0-r filename取消读的权限。
8、lsattr
     用于显示并设置用户文件及目录的高级属性。
9、lsusb
     用于列出计算机里的usb设备。
10、lspci
      用于列出计算机里的pci设备。
11、lsmod
      linux下的驱动有两种形式。一种是加载到内核中的，另一种是以模块化的形式出现的。lsmod就是用于
      列出计算机里面的驱动模块。

(三)ubuntu 基本命令三

1、cat
     cat 命令就是用于查看ubuntu中文本文件的内容的命令。
     cat /proc/cpuinfo 用于查看计算机的cpu信息。
     cat /proc/meminfo 用于查看计算机的内在信息。
     cat /etc/issue 查看ubuntu的版本信息。
2、free
     free 命令也是用来查看ubuntu计算机中的内在信息的。
3、grep
     ubuntu中的grep命令是用来过滤出一个文件中对自己有用的信息的。
     cat /proc/meminfo |grep MemTotal 用于过滤出内存中的内存大小。
4、more
     uubntu中的more命令是用于将结果分页显示。ls -a |more 用于分页显示。
5、fdisk
      ubuntu中查看硬盘信息的命令用fdisk。
6、uname
     ubuntu中查看内核版本的命令是uname -a ，只输入uname则会输出linux作为结果。

(四)文件操作命令：
1、ls
     格式：ls 目录
     ls命令用于显示文件下有哪些文件。
2、touch
     格式：touch test1 test2 test3
     touch命令用于创建文件，可以同一时间创建多个文件。
3、rm
     格式：rm 文件   
     rm命令用于删除文件，当文件不能够被删除时可以加上 -f 选项，强制将文件删除。
4、cat
     格式：cat /proc/cpuinfo
     cat命令用于查看文件内的信息。如果只想查看某一项内容时，要加上grep选项。
     例如：cat /proc/meminfo |grep MemTotal
5、less
     格式：less /proc/meminfo
     less命令也是用来查看文件的内容的命令，但是他显示时是一屏一屏的显示地。
          a、按下空格键后进入到下一屏。
          b、还可以通过上下键来上下移动行。
          c、按下 q 键后退出查看。
6、more
     格式：more /proc/meminfo
     more命令与less命令一样用于查看文件内的内容，同样是分屏显示的。
          a、按下空格键后进入到下一屏
          b、按下 q 键后退出查看
7、cp
     格式：cp /etc/apt/sources.list /etc/aptsources.listbacker
     cp是copy的缩写用于复制文件。
8、mv
     格式：mv /home/user1/桌面/ruijie/xrgsu /usr/share/local/bin/xrgsu
     mv命令是用于移动文件的。
9、find
     格式：sudo find / -name ls
     find命令是用于查找文件：
          a、／ 表示的是查找的起始目录，
          b、-name 有了这个选项，在显示只有找到的结果才会显示出来。
          c、ls 为你要找的目录文件。

(五)目录操作命令：
1、mkdir
      格式：mkdir home/user1/f1
      mkdir命令是用来创建目录的。
            a、home/user1/ 这是一个目录，既可以是一个绝对路径，也可以是一个相对路径。
            b、如果在当前目录下也可以创建多个文件.如：mkdir f2 f3 f4
2、rm
      格式：rm -rf test/f2 test/f3
      rm命令与操作文件一样是用来删除的。
            a、-rf 有r可以将目录与其子目录一直删除，f是用来强制删除的。
            b、test/f2 test/f3 是同时删除多个文件。
3、pwd
      格式：pwd
      pwd命令是用来指出当前所在的路径。是print working directory的缩写。
4、cd
      格式：cd ..
      cd命令是用来改变当前目录的。
            a、.. 表示回到父目录，. 表示当前目录。
            b、- 表示回到上一次所使用的目录。
5、ls
      格式:ls 目录名
      ls命令是用来查看目录里面所拥有的子目录与文件有哪些。
6、cp
      格式：cp -r 源目录名 目标目录名
      cp命令与操作文件一样是用来复制的，带r表示将其子目录一起复制。
7、mv
      格式：mv 源目录名 目标目录名
      mv命令与操作文件一样是用来移动的，当在源目录与目标目录在同一个父目录下表示改名。
8、find
      格式：find 起始目录 -name 要找的目录
      find命令与操作文件一样是用来查找的。
