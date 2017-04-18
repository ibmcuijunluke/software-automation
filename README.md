# software-automation
software-automation softwareluke
http://www.java2s.com/
https://developers.google.cn/china/
https://github.com/
https://www.ibm.com/developerworks/cn/
https://developer.microsoft.com/zh-cn/windows
https://www.yahoo.com/

https://open.1688.com/
http://open.china.alibaba.com/
http://open.qq.com/mobi_guide
http://app.baidu.com/




[root@18-217 ~]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.18.254  0.0.0.0         UG    100    0        0 eno16780032
192.168.18.0    0.0.0.0         255.255.255.0   U     100    0        0 eno16780032
[root@18-217 ~]# nmcli dev show
GENERAL.设备:                           eno16780032
GENERAL.类型:                           ethernet
GENERAL.硬盘:                           00:0C:29:41:60:93
GENERAL.MTU:                            1500
GENERAL.状态:                           100 (连接的)
GENERAL.CONNECTION:                     eno16780032
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/0
WIRED-PROPERTIES.容器:                  开
IP4.地址[1]:                            192.168.18.217/24
IP4.网关:                               192.168.18.254
IP4.DNS[1]:                             114.114.114.114
IP6.地址[1]:                            fe80::20c:29ff:fe41:6093/64
IP6.网关:                               fe80::24d7:d3b0:cec4:73b5

GENERAL.设备:                           lo
GENERAL.类型:                           loopback
GENERAL.硬盘:                           00:00:00:00:00:00
GENERAL.MTU:                            65536
GENERAL.状态:                           10 (未管理)
GENERAL.CONNECTION:                     --
GENERAL.CON-PATH:                       --
IP4.地址[1]:                            127.0.0.1/8
IP4.网关:                               
IP6.地址[1]:                            ::1/128
IP6.网关:                               
[root@18-217 ~]# nmcli con show
名称         UUID                                  类型            设备        
eno16780032  567c2c16-9e8d-4eac-bff0-ec038d1672d8  802-3-ethernet  eno16780032
[root@18-217 ~]#
